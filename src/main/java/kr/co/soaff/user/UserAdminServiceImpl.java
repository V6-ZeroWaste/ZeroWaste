package kr.co.soaff.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserAdminServiceImpl implements UserAdminService {
	@Autowired
	UserAdminMapper mapper;
	
	@Override
	public Map<String, Object> list(UserVO vo) {
		
		Map<String, Object> map = new HashMap<>();
		
		// 총개수 
		int total = mapper.count(vo);
		map.put("total", total);
		
		// 총 페이지수 
		int totalPage = total / 20;
		if(total % 20 > 0) {
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
		List<UserVO> list = mapper.list(vo);
		map.put("list", list);
		
		return map;
	}

	@Override
	public UserVO detail(UserVO vo) {
		return mapper.detail(vo);
	}

	@Override
	public boolean update(UserVO vo) {
		return mapper.update(vo) == 0? false : true;
	}

}
