package kr.co.soaff.item;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ItemVO {
	private int item_no;
	private String category_name;
	private String name;
	private String description;
	private int price;
	private int discount_rate;
	private int discounted_price;
	private int amount;
	private String detail;
	private String item_img;
	private boolean exposed_status;
	private boolean packable_option;
	private int packing_price;
	private Timestamp item_regist_date;
	private int category_no;

	// 검색 키워드
	public String searchWord;
	// 필터 종류
	private String filter;
	// 정렬 기준
	private String orderBy;
	// 페이지 번호
	private int page;
	// 시작 인덱스 값
	private int startIdx;

	public ItemVO() {
		this.page = 1;
	}

	public int getStartIdx() {
		return (page - 1) * 20;
	};
}
