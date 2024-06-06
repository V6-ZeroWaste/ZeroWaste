package kr.co.soaff.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CancelAdminServiceImpl implements CancelAdminService {
	@Autowired
	private CancelAdminMapper mapper;

	@Override
	public Map<String, Object> list(OrderDetailVO vo) {
		int count = mapper.count(vo);
		int totalPage = count / 20;
		if (count % 10 > 0)
			totalPage++;
		List<OrderDetailVO> list = mapper.list(vo); // 목록

		Map<String, Object> map = new HashMap<>();
		map.put("count", count);
		map.put("totalPage", totalPage);
		map.put("list", list);

		int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage)
			endPage = totalPage;
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		return map;
	}
	
	@Override
	public int approveCancel(int orderDetailNo) {
		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrder_detail_no(orderDetailNo);
		return mapper.approveCancel(vo);
	}

	@Override
	public int refuseCancel(int orderDetailNo) {
		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrder_detail_no(orderDetailNo);
		return mapper.refuseCancel(vo);
	}

	@Override
	public int completeCancel(int orderDetailNo) {
		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrder_detail_no(orderDetailNo);
		return mapper.completeCancel(vo);
	}

	@Override
	public int adminCancel(int orderDetailNo, String reason) {
		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrder_detail_no(orderDetailNo);
		vo.setCancel_reason_detail(reason);
		return mapper.adminCancel(vo);
	}

}
