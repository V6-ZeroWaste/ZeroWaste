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
	private String id;
	private int payment_price;
	private String payment_method;

	// 주문 총 수량
	private int total_amount;

	// 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
	private String searchWord;
	private String orderBy;
	private Integer filter;
	private Timestamp start_date;
	private Timestamp end_date;
	private int page; // 사용자가 요청한 페이지 번호
	private int startIdx; // limit 앞에 들어갈 시작인덱스값

	public OrderVO() {
		this.page = 1;
	}

	public int getStartIdx() {
		return (page - 1) * 20;
	}

}