package kr.co.soaff.qna;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class QnaVO {
	private int qna_no;
	private int user_no;
	private String user_id;
	private String name;
	private int type;
	private String title;
	private String content;
	private String qna_img;
	private Timestamp question_date;
	private String reply;
	private Timestamp reply_date;
	private int item_no;
	private String item_name;
	
	private String item_img;
	private String replyState;
	private String searchWord;
	private String orderBy;
	private String filter;
	private String start_date;
	private String end_date;
	private int page;
	private int startIdx; // limit 앞에 들어갈 시작인덱스값

	public QnaVO() {
		this.page = 1;
	}

	public int getStartIdx() {
		return (page - 1) * 20;
	}
}
