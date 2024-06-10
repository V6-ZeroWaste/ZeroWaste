package kr.co.soaff.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OrderAdminServiceImpl implements OrderAdminService {

	@Autowired
	private OrderAdminMapper mapper;

	@Override
	public Map<String, Object> list(OrderVO orderVO) {
		// 페이징 처리(20개씩)
		int count = mapper.count(orderVO); // 총 개수
		int totalPage = count / 20; // 총 페이지수
		if (count % 20 > 0)
			totalPage++;
		// 페이지네이션(1-10)
		int endPage = (int) (Math.ceil(orderVO.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage)
			endPage = totalPage;
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;

		List<OrderVO> list = mapper.list(orderVO); // 목록

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("count", count);
		map.put("totalPage", totalPage);
		map.put("list", list);
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		return map;
	}

	@Override
	public Map<String, Object> detail(OrderVO orderVO) {
		Map<String, Object> detailMap = new HashMap<String, Object>();

		OrderVO detailFromOrderVO = mapper.detailFromOrderVO(orderVO);
		int currentOrderNo = detailFromOrderVO.getOrder_no();
		log.info(currentOrderNo + "");
		OrderDetailVO orderDetailVO = new OrderDetailVO();
		orderDetailVO.setOrder_no(currentOrderNo);

		List<OrderDetailVO> detailFromOrderDetailVO = mapper.detailFromOrderDetailVO(orderDetailVO);
		detailMap.put("detailFromOrderVO", detailFromOrderVO);
		detailMap.put("detailFromOrderDetailVO", detailFromOrderDetailVO);
		return detailMap;
	}

	@Override
	public int updateDeliveryStatus(OrderVO orderVO) {
		System.out.println(orderVO.toString());
		int result = mapper.updateDeliveryStatus(orderVO);
		System.out.println(result);
		return result;
	}

}
