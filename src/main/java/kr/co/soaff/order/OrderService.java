package kr.co.soaff.order;

import java.util.List;
import java.util.Map;

public interface OrderService {
	// Mypage > order > list
	Map<String, Object> list(OrderVO orderVo);

	// Mypage > order > detail
	OrderVO orderInfo(OrderVO orderVO);
	OrderDetailVO orderDetailInfo(OrderDetailVO orderVO);
	List<OrderDetailVO> orderDetailList(OrderVO orderVO);


	boolean orderConfirm(OrderDetailVO vo);

	// Order
	Map<String, Object> order(OrderVO vo);

	boolean orderInsert(OrderVO vo);

	int deleteCartAfterOrder(OrderVO vo);

}
