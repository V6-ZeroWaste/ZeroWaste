package kr.co.soaff.cancel;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CancelAdminListVO {
    private int order_detail_no;
    private int order_no;
    private String item_name;
    private String user_id;
    private int amount;
    private int price;
    private Timestamp cancel_request_date;
    private Timestamp cancel_approve_date;
    private Integer cancel_status;
	private String startRequestDate;
	private String endRequestDate;
	private String startApproveDate;
	private String endApproveDate;

    // 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
    private String orderBy;
    private Integer filter;
    private String searchWord;
    private int page; // 사용자가 요청한 페이지 번호
    private int startIdx; // limit 앞에 들어갈 시작인덱스값

    public CancelAdminListVO() {
        this.page = 1;
        this.orderBy = "오래된순";
        this.filter = 0;
    }

    public int getStartIdx() {
        return (page - 1) * 20;
    }
}
