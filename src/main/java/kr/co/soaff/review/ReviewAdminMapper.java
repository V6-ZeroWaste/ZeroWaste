package kr.co.soaff.review;

import java.util.List;

import kr.co.soaff.qna.QnaVO;

public interface ReviewAdminMapper {
	List<QnaVO> list(QnaVO vo);
	QnaVO detail(QnaVO vo);
	int updateStatus(QnaVO vo);
	int count (QnaVO vo);
}
