package kr.co.soaff.user;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class UserVO {
	private int user_no;
	private String id;
	private String name;
	private String email;
	private String pw;
	private String zipcode;
	private String addr;
	private String addr_detail;
	private String tel;
	private Timestamp date;
	private Timestamp delete;
}
