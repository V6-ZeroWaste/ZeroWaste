package kr.co.soaff.qna;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class QnaVO {
	private int qna_no;
	private int user_no;
	private String user_id;
	private String name;
	private Integer type;
	private String title;
	private String content;
	private String qna_img;
	private Timestamp question_date;
	private String reply;
	private Timestamp reply_date;
	private int item_no;
	private String item_name;
	
	private String typeString;
	private String item_img;
	private String replyState;
	private String searchWord;
	private String orderBy;
	private String filter;
	private String start_date;
	private String end_date;
	private int page;
	private int startIdx; // limit 앞에 들어갈 시작인덱스값
	private int pageSize;
	
	public QnaVO() {
		this.page = 1;
		this.orderBy = "최신순";
	}
	
	public void setType(Integer type) {
        this.type = type;
        if (type == 0) {
            this.typeString = "교환/환불문의";
        } else if (type == 1) {
            this.typeString = "상품상세문의";
        }
    }

    public void setTypeString(String typeString) {
        this.typeString = typeString;
        if (typeString.equals("교환/환불문의")) {
            this.type = 0;
        } else if (typeString.equals("상품상세문의")) {
            this.type = 1;
        }
    }

    public String getTypeString() {
        return typeString;
    }

//	public int getStartIdx() {
//		return (page - 1) * 20;
//	}
}
