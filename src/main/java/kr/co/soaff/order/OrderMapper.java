package kr.co.soaff.order;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {
	OrderVO list(OrderVO vo);

	int count(OrderVO vo);

	OrderVO detailFromOrderVO(OrderDetailVO vo);

	OrderDetailVO detailFromOrderDetailVO(OrderDetailVO vo);

	int updateDeliveryStatus(OrderVO vo);
}
