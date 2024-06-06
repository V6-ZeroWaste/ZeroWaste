package kr.co.soaff.order;

import java.util.Map;

public interface CancelAdminService {
	Map<String, Object>list(OrderDetailVO vo);
	int approveCancel(int orderDetailNo);
	int refuseCancel(int orderDetailNo);
	int completeCancel(int orderDetailNo);
	int adminCancel(int orderDetailNo, String reason);
}
