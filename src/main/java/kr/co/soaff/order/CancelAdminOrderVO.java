package kr.co.soaff.order;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CancelAdminOrderVO {
	private int order_no;
	private int user_no;
	private Timestamp payment_date;
	private int point;
	private String payment_Id;
	private String imp_uid;
	private int payment_price;
	private String payment_method;
	private int delivery_price;

}
