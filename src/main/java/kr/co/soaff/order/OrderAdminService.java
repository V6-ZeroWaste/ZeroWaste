package kr.co.soaff.order;

import java.util.Map;

public interface OrderAdminService {

	Map<String, Object> list(OrderVO orderVo);

	Map<String, Object> detail(OrderVO orderVo);

	int updateDeliveryStatus(OrderVO orderVO);

}
