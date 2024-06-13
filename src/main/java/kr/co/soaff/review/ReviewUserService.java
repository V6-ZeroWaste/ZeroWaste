package kr.co.soaff.review;

import java.util.Map;

public interface ReviewUserService {
	Map<String,Object> list(ReviewVO vo);
	ReviewVO detail(ReviewVO vo);
	int update(ReviewVO vo);
	int delete(int review_no);
}
