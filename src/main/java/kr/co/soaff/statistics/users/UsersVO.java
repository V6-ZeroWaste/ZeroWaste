package kr.co.soaff.statistics.users;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class UsersVO {

	private Timestamp join_date;
	private int user_cnt;
	private Timestamp start_date;
	private String filter;

}
