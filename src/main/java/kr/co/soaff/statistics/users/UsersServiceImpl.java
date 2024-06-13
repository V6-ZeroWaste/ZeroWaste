package kr.co.soaff.statistics.users;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsersServiceImpl implements UsersService {
	@Autowired
	private UsersMapper mapper;

	@Override
	public Map<String, Object> list(UsersVO vo) {
		int count = mapper.count(vo); // 총 개수
		int totalPage = count / 20; // 총 페이지수
		if (count % 20 > 0)
			totalPage++;

		List<UsersVO> usersList = mapper.users_list(vo);
		List<UsersVO> leaveList = mapper.leave_list(vo);

		// 페이지네이션(1-10)
		int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage)
			endPage = totalPage;
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;

		Map<String, Object> map = new HashMap<>();
		map.put("count", count);
		map.put("totalPage", totalPage);
		map.put("usersList", usersList);
		map.put("leaveList", leaveList);
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);

		return map;

	};

}
