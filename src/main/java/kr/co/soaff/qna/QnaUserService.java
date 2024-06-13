package kr.co.soaff.qna;

import java.util.Map;

public interface QnaUserService {
	Map<String, Object> list(QnaVO vo);

	QnaVO detail(QnaVO vo);

	int update(QnaVO vo);
	
	int delete(int qna_no);
}
