package kr.co.soaff.order;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderDetailVO {

	private int order_detail_noorder_no;
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

}
