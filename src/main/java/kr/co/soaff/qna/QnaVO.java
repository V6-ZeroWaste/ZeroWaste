package kr.co.soaff.qna;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class QnaVO {
	int qna_no;
	int user_no;
	String user_id;
	int type;
	String title;
	String content;
	String qna_img;
	Timestamp question_date;
	String reply;
	Timestamp reply_date;
	int item_no;
	
	private int deleteContent;
	private int deleteAndUpdateReply; // 0 이 삭제(null 처리) 1 수정
	private String searchWord;
	private String orderBy;
	private String filter;
	private Timestamp startDate;
	private Timestamp endDate;
	private int page;
	private int startIdx; // limit 앞에 들어갈 시작인덱스값
	
	public QnaVO() {
		this.page = 1;
	}
	
	public int getStartIdx() {
		return (page-1) * 20;
	}
}
