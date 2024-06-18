package kr.co.soaff.qna;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaMapper {
	List<QnaVO> list(QnaVO vo);

	QnaVO detail(QnaVO vo);

	int count(QnaVO vo);

	int update(QnaVO vo);
	
	int delete(int qna_no);
}
