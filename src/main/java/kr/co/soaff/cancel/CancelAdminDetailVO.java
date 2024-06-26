package kr.co.soaff.cancel;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CancelAdminDetailVO {
	private int order_detail_no;
	private int order_no;
	private int user_no;
	private int amount;
	private int price;
	private int point;
	private int cancel_status;
	private Timestamp confirm_date;
	private Timestamp cancel_request_date;
	private Timestamp cancel_approve_date;
	private int cancel_reason_type;
	private String cancel_reason_detail;
	private int packing_status;
	private int pay_point;
	private int pay_price;

	private int total_price;
	private int delivery_price;
	private String payment_method;
	private int payment_price;
	private String item_name;
	private String item_no;
	private String user_id;

	// 환불 계산에 필요한 필드
	private int refund_price; // 환불금액
	private int refund_point; // 환불 적립금 및 사용 적립금
}
