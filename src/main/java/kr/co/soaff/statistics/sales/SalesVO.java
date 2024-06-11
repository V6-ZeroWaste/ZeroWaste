package kr.co.soaff.statistics.sales;

import lombok.Data;

@Data
public class SalesVO {
	private String date;
	private int sales;

	// 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
	private String searchWord;
	private String orderBy;
	private Integer filter;
	private String start_date;
	private String end_date;
	private int page; // 사용자가 요청한 페이지 번호
	private int startIdx; // limit 앞에 들어갈 시작인덱스값

	public SalesVO() {
		this.page = 1;
	}

	public int getStartIdx() {
		return (page - 1) * 20;
	}
}
