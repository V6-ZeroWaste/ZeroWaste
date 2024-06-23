package kr.co.soaff.qna;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.soaff.item.ItemVO;

@Mapper
public interface QnaMapper {
	List<QnaVO> list(QnaVO vo);

	ItemVO write(int item_no);

	QnaVO detail(QnaVO vo);

	int post(QnaVO vo);

	int count(QnaVO vo);

	int update(QnaVO vo);

	int delete(int qna_no);

}
