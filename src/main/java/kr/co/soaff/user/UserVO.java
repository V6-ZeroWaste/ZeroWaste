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

	private String orderBy; // 정렬 조건
	private String searchWord; // 검색 키워드
	private int page; // 요청 페이지 번호

	public UserVO() {
		this.page = 1; // 처음 페이지 접속할 때 page 초기값은 항상 1
	}

	// limit 앞에 들어갈 시작 인덱스
	public int getStartIdx() {
		return (page - 1) * 20;
	}
}
