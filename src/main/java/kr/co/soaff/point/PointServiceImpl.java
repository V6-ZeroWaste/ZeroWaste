package kr.co.soaff.point;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PointServiceImpl implements PointService {

	@Autowired
	PointMapper mapper;
	
	@Override
	public int total(PointVO vo) {
		return mapper.total(vo);
	}

	@Override
	public Map<String, Object> list(PointVO vo) {
		Map<String, Object> map = new HashMap<>();
		
		// 총개수 
		int total = mapper.count(vo);
		map.put("total", total);
		
		// 총 페이지수 
		int totalPage = total / 10;
		if(total % 10 > 0) {
			totalPage++;
		}
		map.put("totalPage", totalPage);
		
		// 페이지 네이션 정보 
		int endPage=(int) (Math.ceil(vo.getPage() / 10.0)*10);
		int startPage=endPage-9;
		if(endPage>totalPage) {
			endPage=totalPage;
			}
		boolean isPrev= startPage>1;
		boolean isNext = endPage < totalPage;
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		
		// 목록 
		List<PointVO> list = mapper.list(vo);
		map.put("list", list);
		
		return map;
	}

	@Override
	public boolean insert(PointVO vo) {
		return mapper.insert(vo) == 0? false : true;
	}

	@Override
	public boolean delete(int point_no) {
		return mapper.delete(point_no) == 0? false : true;
	}
	
	
	@Override
	public Map<String, Object> userList(PointVO vo) {
		Map<String, Object> map = new HashMap<>();
		
		// 총개수 
		int total = mapper.count(vo);
		map.put("total", total);
		
		// 총 페이지수 
		int totalPage = total / 10;
		if(total % 10 > 0) {
			totalPage++;
		}
		map.put("totalPage", totalPage);
		
		// 페이지 네이션 정보 
		int endPage=(int) (Math.ceil(vo.getPage() / 10.0)*10);
		int startPage=endPage-9;
		if(endPage>totalPage) {
			endPage=totalPage;
			}
		boolean isPrev= startPage>1;
		boolean isNext = endPage < totalPage;

		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		
		// 목록 
		List<PointVO> list = mapper.list(vo);
		map.put("list", list);
		
		return map;
	}

}
