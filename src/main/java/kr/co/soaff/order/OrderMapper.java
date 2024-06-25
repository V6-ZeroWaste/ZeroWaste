package kr.co.soaff.order;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.soaff.cart.CartVO;

@Mapper
public interface OrderMapper {
	// Mypage > order > list
	List<OrderVO> list(OrderVO vo);

	int count(OrderVO vo);

	// Mypage > order > detail
	OrderVO orderInfo(OrderVO vo);

	OrderDetailVO orderDetailInfo(OrderDetailVO vo);

	List<OrderDetailVO> orderDetailList(OrderVO vo);

	List<OrderDetailVO> orderDetailInfo(OrderVO vo);

	int orderConfirm(OrderDetailVO vo);

	// Order
	OrderVO info(OrderVO vo);

	int point(OrderVO vo);

	List<CartVO> cartList(OrderVO vo);

	int cartCount(OrderVO vo);

	int orderInsert(OrderVO vo);

	int pointPlus(OrderVO vo);

	int pointMinus(OrderVO vo);

	int deleteCartAfterOrder(OrderVO vo);

//	int orderDetailInsert(OrderVO vo);
	int orderDetailInsert(List<OrderVO> list);

	List<Integer> checkAmount(List<OrderVO> list);
}
