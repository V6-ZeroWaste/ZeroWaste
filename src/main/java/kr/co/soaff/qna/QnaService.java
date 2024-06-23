package kr.co.soaff.qna;

import java.util.Map;

import kr.co.soaff.item.ItemVO;

public interface QnaService {
	Map<String, Object> list(QnaVO vo);

	ItemVO write(int item_no);

	QnaVO detail(QnaVO vo);

	int post(QnaVO vo);

	int update(QnaVO vo);

	int delete(int qna_no);

}
