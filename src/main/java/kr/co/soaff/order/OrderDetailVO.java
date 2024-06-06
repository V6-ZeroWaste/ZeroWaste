package kr.co.soaff.order;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class OrderDetailVO {
    private int order_detail_no;
    private int order_no;
    private int user_no;
    private int amount;
    private int price;
    private Timestamp confirm_date;
    private int cancel_status;
    private Timestamp cancel_request_date;
    private Timestamp cancel_approve_date;
    private int cancel_reason_type;
    private int item_no;
    private String cancel_reason_detail;
    
    private List<Integer> cancelStatusList;
    
    private String startRequestDate;
    private String endRequestDate;
    private String startApproveDate;
    private String endApproveDate;

    // join으로 가져올 데이터
    private String user_id; // 유저아이디
    private String item_name; // 상품명
    private String order_method; // 예) 카카오페이 네이버페이
    private int refund_price; // 환불금액
    private int refund_point; // 환불 적립금 및 사용 적립금
    private int sale_price; // 할인금액
    private String item_img;
    private String total_item_price;

    // 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
    private String searchWord;
    private String orderBy;
    private Integer filter;
    private int page; // 사용자가 요청한 페이지 번호
    private int startIdx; // limit 앞에 들어갈 시작인덱스값

    public OrderDetailVO() {
        this.page = 1;
    }

    public int getStartIdx() {
        return (page - 1) * 20;
    }
    
//    public OrderDetailVO(int order_detail_no, int order_no, String user_id, String item_name, int amount, int price, int cancel_status, Timestamp cancel_request_date, Timestamp cancel_approve_date) {
//        this.order_detail_no = order_detail_no;
//        this.order_no = order_no;
//        this.user_id = user_id;
//        this.item_name = item_name;
//        this.amount = amount;
//        this.price = price;
//        this.cancel_status = cancel_status;
//        this.cancel_request_date = cancel_request_date;
//        this.cancel_approve_date = cancel_approve_date;
//    }
}
