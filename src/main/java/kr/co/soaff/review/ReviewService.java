package kr.co.soaff.review;

import java.util.Map;


public interface ReviewService {
	Map<String,Object> list(ReviewVO vo);
	ReviewVO detail(ReviewVO vo);
	int updateStatus(ReviewVO vo);
}
