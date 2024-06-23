package kr.co.soaff.statistics.sales;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SalesServiceImpl implements SalesService {
	@Autowired
	private SalesMapper mapper;

	public Map<String, Object> list(SalesVO vo) {
		int totalCount = mapper.count(vo);

		int totalPage = totalCount / 20;
		if (totalCount % 20 > 0)
			totalPage++;
		// 시작인덱스
		int startIdx = (vo.getPage() - 1) * 20;
		vo.setStartIdx(startIdx); // sql문에 파라미터로 넣어줌
		List<SalesVO> list = mapper.list(vo);

		// 페이징처리
		int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10); // 끝페이지
		int startPage = endPage - 9; // 시작페이지

		if (endPage > totalPage)
			endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;

		Map<String, Object> map = new HashMap<>();
		map.put("total", totalCount);
		map.put("totalPage", totalPage);
		map.put("list", list);
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", prev);
		map.put("isNext", next);
		return map;
	};

}
