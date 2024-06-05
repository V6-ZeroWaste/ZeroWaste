package kr.co.soaff.qna;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaMapper {
	QnaVO list(QnaVO vo);

	QnaVO detail(QnaVO vo);

	int deleteContent(int qna_no);

	int deleteAndUpdateReply(QnaVO vo);

	int count(QnaVO vo);
}
