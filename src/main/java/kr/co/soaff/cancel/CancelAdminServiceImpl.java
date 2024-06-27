package kr.co.soaff.cancel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.soaff.point.PointMapper;
import kr.co.soaff.point.PointVO;

@Service
public class CancelAdminServiceImpl implements CancelAdminService {
	@Autowired
	private CancelAdminMapper mapper;
	@Autowired
	private PointMapper pointMapper;

	@Value("${imp.apiSecret}")
	private String apiSecret;

	@Override
	public Map<String, Object> list(CancelAdminListVO vo) {
		int count = mapper.count(vo);
		int totalPage = count / 20;
		if (count % 20 > 0)
			totalPage++;
		List<CancelAdminListVO> list = mapper.list(vo); // 목록

		Map<String, Object> map = new HashMap<>();
		map.put("count", count);
		map.put("totalPage", totalPage);
		map.put("list", list);

		int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage)
			endPage = totalPage;
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		return map;
	}

	@Override
	public Map<String, Object> cancelDetail(int order_detail_no) {
		CancelAdminDetailVO orderDetail = mapper.detailFromOrderDetailVO(order_detail_no);
		CancelAdminOrderVO order = mapper.detailFromOrderVO(orderDetail.getOrder_no());

		// 최종 결제 정보 공식 계산
		int total_price = order.getPayment_price() - order.getDelivery_price() + order.getPoint();
		int refundPoint = orderDetail.getPay_point();
		
		//		int refundPoint = (int) (order.getPoint()
//				* (((double) (orderDetail.getPrice()) * orderDetail.getAmount())
//						/ (order.getPayment_price() - order.getDelivery_price() + order.getPoint())));

		// 주문 상품 총 개수 및 남은 개수 가져오기
		int totalOrderItems = mapper.countOrderItems(orderDetail.getOrder_no());
		int remainingItems = totalOrderItems - orderDetail.getAmount(); // 현재 취소 요청 중인 상품을 제외한 나머지 상품 수량

//		int refundPrice = (orderDetail.getPrice()) * orderDetail.getAmount() - refundPoint;
		int refundPrice = orderDetail.getPay_price();
		if ((orderDetail.getCancel_request_date()).equals(order.getLast_cancel_date())) {
			// 마지막 취소 요청 상품
			refundPrice += order.getDelivery_price();
		}

		// VO에 필요한 데이터 설정
		orderDetail.setOrder_no(order.getOrder_no());
		orderDetail.setOrder_detail_no(order_detail_no);
		orderDetail.setRefund_price(refundPrice);
		orderDetail.setRefund_point(refundPoint);
		orderDetail.setTotal_price(total_price);
		orderDetail.setDelivery_price(order.getDelivery_price());
		orderDetail.setPayment_method(order.getPayment_method());
		orderDetail.setPayment_price(order.getPayment_price());
		orderDetail.setPoint(order.getPoint());
		orderDetail.setUser_no(order.getUser_no());

		Map<String, Object> map = new HashMap<>();
		map.put("cancelDetail", orderDetail);

		return map;
	}

	@Override
	public int approveCancel(int order_detail_no) {
		CancelAdminDetailVO vo = new CancelAdminDetailVO();
		vo.setOrder_detail_no(order_detail_no);
		return mapper.approveCancel(vo);
	}

	@Override
	public int refuseCancel(int order_detail_no) {
		CancelAdminDetailVO vo = new CancelAdminDetailVO();
		vo.setOrder_detail_no(order_detail_no);
		return mapper.refuseCancel(vo);
	}

	@Override
	@Transactional
	public int completeCancel(int order_detail_no) {
		// 환불에 필요한 정보 가져오기
		CancelAdminDetailVO orderDetail = mapper.detailFromOrderDetailVO(order_detail_no);
		CancelAdminOrderVO order = mapper.detailFromOrderVO(orderDetail.getOrder_no());

//		int refundPoint = (int) (order.getPoint()
//				* (((double) (orderDetail.getPrice()) * orderDetail.getAmount())
//						/ (order.getPayment_price() - order.getDelivery_price() + order.getPoint())));
//		int refundPrice = (orderDetail.getPrice()) * orderDetail.getAmount() - refundPoint;
		int refundPoint = orderDetail.getPay_point();
		int refundPrice = orderDetail.getPay_price();
		if ((orderDetail.getCancel_request_date()).equals(order.getLast_cancel_date())) {
			refundPrice += order.getDelivery_price(); // 마지막 취소 상품
		}
		int reason_type = orderDetail.getCancel_reason_type();
		String reason = reason_type == 0 ? "배송지연" : (reason_type == 1 ? "제품불량" : "단순변심");

		// 포트원 결제 취소
		int result = 0;
		
		if (cancelPortone(order.getPayment_Id(), reason, refundPrice)) { // 결제 취소 완료 시
				// order_detail 결제 취소 정보 UPDATE
				result += mapper.completeCancel(orderDetail);
				// order 취소 금액 UPDATE
				order.setRefund_price(refundPrice);
				order.setRefund_point(refundPoint);
				result += mapper.cancelOrderUpdate(order);
				// point 취소 금액 UPDATE
				if (refundPoint > 0) {
					PointVO pointVo = new PointVO();
					pointVo.setContent("환불 적립금");
					pointVo.setUser_no(order.getUser_no());
					pointVo.setPoint(refundPoint);
					pointVo.setOrder_no(order.getOrder_no());
					result += pointMapper.insert(pointVo);
				}else {
					result++;
				}
				// item 재고 수량 UPDATE
				mapper.updateItemAmount(orderDetail);

		} else {
				return 0;
		} 

		return result == 3 ? 1 : 0;
	}

	@Override
	public int adminCancel(int order_detail_no, String cancel_reason_detail) {
		CancelAdminDetailVO cancelDetail = new CancelAdminDetailVO();
		cancelDetail.setOrder_detail_no(order_detail_no);
		cancelDetail.setCancel_reason_detail(cancel_reason_detail);
		if (mapper.adminCancel(cancelDetail) > 0) {
			return completeCancel(order_detail_no);
		} else {
			return 0;
		}
	}

	@Override
	public Map<String, Object> forceDetail(int order_detail_no) {
		CancelAdminDetailVO orderDetail = mapper.detailFromOrderDetailVO(order_detail_no);
		CancelAdminOrderVO order = mapper.detailFromOrderVO(orderDetail.getOrder_no());

		// 최종 결제 정보 공식 계산
		int total_price = order.getPayment_price() - order.getDelivery_price() + order.getPoint();
//		int refundPoint = (int) (((double) (orderDetail.getPrice()) * orderDetail.getAmount())
//				/ ((order.getPayment_price() - order.getDelivery_price() + order.getPoint())) * order.getPoint());
		int refundPoint = orderDetail.getPay_point();
		int refundPrice = orderDetail.getPay_price();
		// 주문 상품 총 개수 및 남은 개수 가져오기
		int totalOrderItems = mapper.countOrderItems(orderDetail.getOrder_no());
		int remainingItems = totalOrderItems - orderDetail.getAmount(); // 현재 취소 요청 중인 상품을 제외한 나머지 상품 수량

		if (remainingItems == 0) {
			// 모든 상품을 취소하는 경우
			refundPrice += order.getDelivery_price();
		} 

		// VO에 필요한 데이터 설정
		orderDetail.setItem_name(orderDetail.getItem_name());
		orderDetail.setRefund_price(refundPrice);
		orderDetail.setRefund_point(refundPoint);
		orderDetail.setTotal_price(total_price);
		orderDetail.setDelivery_price(order.getDelivery_price());
		orderDetail.setPayment_method(order.getPayment_method());
		orderDetail.setPayment_price(order.getPayment_price());
		orderDetail.setPoint(order.getPoint());
		orderDetail.setUser_no(order.getUser_no());
		orderDetail.setUser_id(order.getUser_id());

		Map<String, Object> map = new HashMap<>();
		map.put("forceDetail", orderDetail);

		return map;
	}

	public boolean cancelPortone(String paymengt_id, String reason, int amount) {
		if(amount <= 0) {return true;}
		try {

			String apiUrl = "https://api.portone.io/payments/" + paymengt_id + "/cancel";
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "PortOne " + apiSecret);
			headers.setContentType(MediaType.APPLICATION_JSON);

			RestTemplate restTemplate = new RestTemplate();
			Map<String, Object> keyMap = new HashMap<>();
			keyMap.put("amount", amount);
			keyMap.put("reason", reason);

			ObjectMapper objectMapper = new ObjectMapper();
			String keyJson = objectMapper.writeValueAsString(keyMap);
			HttpEntity<String> requestEntity = new HttpEntity<>(keyJson, headers); // HttpEntity 객체 생성
			ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity,
					String.class);

			if (responseEntity.getStatusCode() == HttpStatus.OK) {
				return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("err msg : " + e.getMessage());
			return false;
		}
	}

}
