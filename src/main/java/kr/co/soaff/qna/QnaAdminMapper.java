package kr.co.soaff.qna;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaAdminMapper {
	List<QnaVO> list(QnaVO vo);

	QnaVO detail(QnaVO vo);

	int deleteContent(int qna_no);

	int updateReply(QnaVO vo);
	
	int deleteReply(int qna_no);

	int count(QnaVO vo);
}