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
	private Integer delivery_status;
	private Timestamp delivery_date;
	private String id;
	private int payment_price;
	private String payment_method;
	private int total_item_price;
	private int refund_price;
	private int[] checkedCartNo;
	private int checkedCartCount;
	// orderDeatil 관련정보
	private int[] amountArray;
	private int[] itemNoArray;
	private int[] priceArray;
	private int[] packingStatusArray;
	private int[] payPriceArray;
	private int[] payPointArray;
	private int amount;
	private int item_no;
	private int price;
	private int packing_status;
	private int pay_price;
	private int pay_point;
	// 포인트 관련
	private String pointPlusContent;
	private String pointContent;
	private int pointPlus;

	private int total_amount; // 주문 총 수량
	private int item_amount; // 주문 총 수량
	private Integer cancel_status;
	private Integer cancel_count; // 상품 취소 수량
	private String item_img; // 상품 이미지
	private Timestamp last_cancel_date;

	// 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
	private String searchWord;
	private String orderBy;
	private Integer filter;
	private String start_date;
	private String end_date;
	private int page; // 사용자가 요청한 페이지 번호
	private int startIdx; // limit 앞에 들어갈 시작인덱스값

	public OrderVO() {
		this.page = 1;
	}

	public int getStartIdx() {
		return (page - 1) * 20;
	}

}