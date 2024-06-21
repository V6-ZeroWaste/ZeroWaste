package kr.co.soaff.order;

import java.util.List;
import java.util.Map;

public interface OrderService {
	// Mypage > order > list
	Map<String, Object> list(OrderVO orderVo);

	// Mypage > order > detail
	OrderVO orderInfo(OrderVO orderVO);

	List<OrderDetailVO> orderDetailInfo(OrderVO orderVO);

	boolean orderConfirm(OrderDetailVO vo);

	// Order
	Map<String, Object> order(OrderVO vo);

	int updateOrder(OrderVO vo);
}
