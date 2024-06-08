package kr.co.soaff.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewAdminMapper mapper;
	
	@Override
	public Map<String,Object> list(ReviewVO vo) {
		List<ReviewVO> list = mapper.list(vo);
		int count = mapper.count(vo); 
		int totalPage = count /20;
	    if (count % 20 > 0) totalPage++;
		Map<String,Object> map = new HashMap();
        map.put("count", count);
        map.put("totalPage", totalPage);
        map.put("list", list);
        
        // 하단에 페이징처리
        int endPage = (int)(Math.ceil(vo.getPage()/15.0)*15);
        int startPage = endPage - 14;
        if (endPage > totalPage) endPage = totalPage;
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;
        map.put("endPage", endPage);
        map.put("startPage", startPage);
        map.put("prev", prev);
		map.put("next", next);
		return map;
	}

	@Override
	public ReviewVO detail(ReviewVO vo) {
		ReviewVO data = mapper.detail(vo);
		return data;
	}

	 @Override
	    public int updateStatus(ReviewVO vo) {
	        return mapper.updateStatus(vo);
	    }

}
