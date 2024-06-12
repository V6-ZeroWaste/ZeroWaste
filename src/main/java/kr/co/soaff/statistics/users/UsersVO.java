package kr.co.soaff.statistics.users;

import lombok.Data;

@Data
public class UsersVO {

	private String date;
	private int user_cnt;
	private int leave_cnt;

	private String start_date;
	private String end_date;
	private String filter;
	private int page; // 사용자가 요청한 페이지 번호
	int startIdx;
	private String orderBy;

	public UsersVO() {
		this.page = 1;
	}

	public int getStartIdx() {
		return (page - 1) * 20;
	}

}
