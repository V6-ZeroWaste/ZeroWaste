package kr.co.soaff.order;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderVO {

	private int order_no;
	private int user_no;
	private Timestamp payment_date;
	private int point;
	private String payment_id;
	private int order_status;
	private String imp_uid;
	private String order_name;
	private String receiver_name;
	private String zipcode;
	private String addr;
	private String addr_detail;
	private String receiver_tel;
	private String delivery_request;
	private int delivery_price;
	private String buyer_name;
	private String buyer_email;
	private String buyer_tel;
	private int delivery_status;
	private Timestamp delivery_date;

}
