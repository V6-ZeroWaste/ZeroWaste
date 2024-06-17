package kr.co.soaff.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.soaff.qna.QnaVO;
@Mapper
public interface ReviewUserMapper {
	List<ReviewVO> list(ReviewVO vo);
	ReviewVO detail(ReviewVO vo);
	int count (ReviewVO vo);
	int update(ReviewVO vo);
	int delete(int review_no);
	int post(ReviewVO vo);
}
