package kr.co.soaff.order;

import java.util.Map;

public interface CancelAdminService {
    Map<String, Object> list(CancelAdminListVO vo);
    Map<String, Object> cancelDetail(int order_detail_no);
    int approveCancel(int order_detail_no);
    int refuseCancel(int order_detail_no);
    int completeCancel(int order_detail_no);
    int adminCancel(int order_detail_no, String reason);
}
