package kr.co.soaff.review;

import kr.co.soaff.qna.QnaVO;

public interface ReviewMapper {
	QnaVO list(QnaVO vo);
	QnaVO detail(QnaVO vo);
	int updateStatus(QnaVO vo);
	int count (QnaVO vo);
}
