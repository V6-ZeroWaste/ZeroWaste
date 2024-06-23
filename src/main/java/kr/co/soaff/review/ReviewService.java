package kr.co.soaff.review;

import java.util.Map;

public interface ReviewService {
	Map<String,Object> list(ReviewVO vo);
	ReviewVO write(int item_no);
	ReviewVO detail(ReviewVO vo);
	int update(ReviewVO vo);
	int delete(int review_no);
	int post(ReviewVO vo);
	
	
}
