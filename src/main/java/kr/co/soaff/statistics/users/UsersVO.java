package kr.co.soaff.statistics.users;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class UsersVO {

	private Timestamp join_date;
	private int user_cnt;
	private Timestamp start_date;
	private Timestamp end_date;
	private String filter;
	private int page; // 사용자가 요청한 페이지 번호
	int startIdx;

	public UsersVO() {
		this.page = 1;
	}

	public int getStartIdx() {
		return (page - 1) * 20;
	}

}
