package kr.co.soaff.cart;

import lombok.Data;

@Data
public class CartVO {

	// DB에서 담을 값
	private String item_img;
	private int user_no;
	private int cart_no;
	private String name;
	private int amount;
	private int packing_status;
	private int item_no;
	private int price;
	private int discounted_price;
	private int inventory;

	// 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
	private int page; // 사용자가 요청한 페이지 번호
	private int startIdx; // limit 앞에 들어갈 시작인덱스값

	public CartVO() {
		this.page = 1;
	}

	public int getStartIdx() {
		return (page - 1) * 10;
	}

}