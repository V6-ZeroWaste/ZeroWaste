package kr.co.soaff.order;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderAdminMapper {
	List<OrderVO> list(OrderVO vo);

	int count(OrderVO vo);

	OrderVO detailFromOrderVO(OrderVO vo);

	OrderDetailVO detailFromOrderDetailVO(OrderDetailVO vo);

	int updateDeliveryStatus(OrderVO vo);
}
