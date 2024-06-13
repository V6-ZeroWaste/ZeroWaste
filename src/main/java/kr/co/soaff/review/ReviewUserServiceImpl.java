package kr.co.soaff.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewUserServiceImpl implements ReviewUserService {
	@Autowired
	ReviewUserMapper mapper;

	@Override
	public Map<String, Object> list(ReviewVO vo) {
		Map<String, Object> map = new HashMap();

		// 총개수
		int total = mapper.count(vo);
		map.put("total", total);

		// 총 페이지수
		int totalPage = total / 20;
		if (total % 20 > 0) {
			totalPage++;
		}
		map.put("totalPage", totalPage);

		// 페이지 네이션 정보
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

		List<ReviewVO> list = mapper.list(vo);
		map.put("list", list);

		System.out.println("조회된 리뷰 개수: " + list.size());
		System.out.println("조회된 리뷰: " + list);

		return map;
	}
	
	@Override
	public ReviewVO detail(ReviewVO vo) {
		ReviewVO data = mapper.detail(vo);
		return data;
	}

}
