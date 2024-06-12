package kr.co.soaff.qna;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaUserMapper {
	List<QnaVO>list(QnaVO vo);
	QnaVO detail(QnaVO vo);
	int count (QnaVO vo);
}
