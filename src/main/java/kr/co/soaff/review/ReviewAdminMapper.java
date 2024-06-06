package kr.co.soaff.review;

import java.util.List;
<<<<<<< HEAD

import kr.co.soaff.qna.QnaVO;
=======
>>>>>>> refs/heads/qna2

import org.apache.ibatis.annotations.Mapper;

import kr.co.soaff.review.ReviewVO;

@Mapper
public interface ReviewAdminMapper {

	List<ReviewVO> list(ReviewVO vo);
	ReviewVO detail(ReviewVO vo);
	int updateStatus(ReviewVO vo);
	int count (ReviewVO vo);
}
