package kr.co.soaff.review;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReviewVO {
	private int review_no;
	private int user_no;
	private String user_id;
	private int score;
	private String title;
	private String content;
	private String review_img;
	private Timestamp regist_date;
	private int exposed_status;
	private int order_detail_no;
	private int item_no;
	private String item_img;
	private int order_no;
	
	private String searchWord;
	private String orderBy;
	private String startDate;
	private String endDate;
	private String filter;
	private int page;
	private int startIdx; // limit 앞에 들어갈 시작인덱스값
	private String item_name; // item.name
	private String category_name; // category.name
	
	public ReviewVO() {
		this.page = 1;
	}
	
//	public int getStartIdx() {
//		return (page-1) * 20;
//	}
	
	public ReviewVO withReview_no(int review_no) {
        this.review_no = review_no;
        return this;
    }
	
}
