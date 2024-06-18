package kr.co.soaff.cancel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CancelAdminServiceImpl implements CancelAdminService {
	@Autowired
	private CancelAdminMapper mapper;

	@Override
	public Map<String, Object> list(CancelAdminListVO vo) {
	    int count = mapper.count(vo);
	    int totalPage = count / 20;
	    if (count % 20 > 0) totalPage++;
	    List<CancelAdminListVO> list = mapper.list(vo); // 목록

	    Map<String, Object> map = new HashMap<>();
	    map.put("count", count);
	    map.put("totalPage", totalPage);
	    map.put("list", list);

	    int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
	    int startPage = endPage - 9;
	    if (endPage > totalPage) endPage = totalPage;
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
		int refundPoint = (int) (((double) orderDetail.getPrice() * orderDetail.getAmount())
				/ ((order.getPayment_price() - order.getDelivery_price())) * order.getPoint());

		// 주문 상품 총 개수 및 남은 개수 가져오기
		int totalOrderItems = mapper.countOrderItems(orderDetail.getOrder_no());
		int remainingItems = totalOrderItems - orderDetail.getAmount(); // 현재 취소 요청 중인 상품을 제외한 나머지 상품 수량

		int refundPrice;
		if (remainingItems == 0) {
			// 모든 상품을 취소하는 경우
			refundPrice = orderDetail.getPrice() * orderDetail.getAmount() + order.getDelivery_price() - refundPoint;
		} else {
			// 일부 상품만 취소하는 경우
			refundPrice = orderDetail.getPrice() * orderDetail.getAmount() - refundPoint;
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
	public int completeCancel(int order_detail_no) {
		CancelAdminDetailVO vo = new CancelAdminDetailVO();
		vo.setOrder_detail_no(order_detail_no);
		return mapper.completeCancel(vo);
	}
	
	@Override
	public int adminCancel(int order_detail_no, String cancel_reason_detail) {
		CancelAdminDetailVO cancelDetail = new CancelAdminDetailVO();
		cancelDetail.setOrder_detail_no(order_detail_no);
		cancelDetail.setCancel_reason_detail(cancel_reason_detail);
		return mapper.adminCancel(cancelDetail);
	}
	
	@Override
	public Map<String, Object> forceDetail(int order_detail_no) {
		CancelAdminDetailVO orderDetail = mapper.detailFromOrderDetailVO(order_detail_no);
		CancelAdminOrderVO order = mapper.detailFromOrderVO(orderDetail.getOrder_no());

		// 최종 결제 정보 공식 계산
		int total_price = order.getPayment_price() - order.getDelivery_price() + order.getPoint();
		int refundPoint = (int) (((double) orderDetail.getPrice() * orderDetail.getAmount())
				/ ((order.getPayment_price() - order.getDelivery_price())) * order.getPoint());

		// 주문 상품 총 개수 및 남은 개수 가져오기
		int totalOrderItems = mapper.countOrderItems(orderDetail.getOrder_no());
		int remainingItems = totalOrderItems - orderDetail.getAmount(); // 현재 취소 요청 중인 상품을 제외한 나머지 상품 수량

		int refundPrice;
		if (remainingItems == 0) {
			// 모든 상품을 취소하는 경우
			refundPrice = orderDetail.getPrice() * orderDetail.getAmount() + order.getDelivery_price() - refundPoint;
		} else {
			// 일부 상품만 취소하는 경우
			refundPrice = orderDetail.getPrice() * orderDetail.getAmount() - refundPoint;
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
}
