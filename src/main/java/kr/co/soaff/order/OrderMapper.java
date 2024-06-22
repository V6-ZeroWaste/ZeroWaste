package kr.co.soaff.order;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {
	// Mypage > order > list
	List<OrderVO> list(OrderVO vo);
	int count(OrderVO vo);
	// Mypage > order > detail
	OrderVO orderInfo(OrderVO vo);
	OrderDetailVO orderDetailInfo(OrderDetailVO vo);
	List<OrderDetailVO> orderDetailList(OrderVO vo);
	int orderConfirm(OrderDetailVO vo);
}
