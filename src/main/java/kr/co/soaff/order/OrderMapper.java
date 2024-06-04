package kr.co.soaff.order;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {
	OrderVO list();

	int count();

	OrderVO detailFromOrderVO();

	OrderDetailVO detailFromOrderDetailVO();

	int updateDeliveryStatus();
}
