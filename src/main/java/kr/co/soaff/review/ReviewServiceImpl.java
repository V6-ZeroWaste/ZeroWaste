package kr.co.soaff.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soaff.qna.QnaVO;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewMapper mapper;

	@Override
	public Map<String, Object> list(ReviewVO vo) {
	    Map<String, Object> map = new HashMap<>();
	    int pageSize = 10;
	    int total = mapper.count(vo);
	    map.put("total", total);

	    int totalPage = total / pageSize;
	    if (total % pageSize > 0) {
	        totalPage++;
	    }
	    map.put("totalPage", totalPage);

	    int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
	    int startPage = endPage - 9;
	    if (endPage > totalPage) {
	        endPage = totalPage;
	    }
	    boolean isPrev = startPage > 1;
	    boolean isNext = endPage < totalPage;

	    map.put("startPage", startPage);
	    map.put("endPage", endPage);
	    map.put("isPrev", isPrev);
	    map.put("isNext", isNext);
	    map.put("currentPage", vo.getPage());

	    vo.setStartIdx((vo.getPage() - 1) * pageSize);
	    List<ReviewVO> list = mapper.list(vo);
	    map.put("list", list);

	    return map;
	}


	@Override
	public ReviewVO detail(ReviewVO vo) {
		ReviewVO data = mapper.detail(vo);
		return data;
	}

	@Override
	public int update(ReviewVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(int review_no) {
		return mapper.delete(review_no);
	}

	@Override
	public int post(ReviewVO vo) {
		vo.setTitle(vo.getTitle().trim());
	    vo.setContent(vo.getContent().trim());
		return mapper.post(vo);
	}
	
	@Override
	public ReviewVO write(int item_no) {
		return mapper.write(item_no);
	}

	
}
