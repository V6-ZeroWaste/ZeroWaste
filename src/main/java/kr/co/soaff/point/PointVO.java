package kr.co.soaff.point;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PointVO {
	private int point_no;
	private int user_no;
	private int order_no;
	private String content;
	private int point;
	private Timestamp point_date;
	
	private String startDate;
	private String endDate;
	
	private int page; // 사용자 요청 페이지 번호 
	public PointVO() {
		this.page = 1; // 처음 페이지 접속할 때 page 초기값은 항상 1
	}
	
	// limit 앞에 들어갈 시작 인덱스 
	public int getStartIdx() {
		return (page-1) * 10;
	}
}
