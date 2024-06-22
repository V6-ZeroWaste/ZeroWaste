package kr.co.soaff.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
public class OrderServiceImpl implements OrderService{
	@Autowired
	OrderMapper mapper;
	
	@Override
	public Map<String, Object> list(OrderVO orderVO) {
		// 페이징 처리(10개씩)
		int count = mapper.count(orderVO); // 총 개수
		int totalPage = count / 10; // 총 페이지수
		if (count % 10 > 0) totalPage++;
				
		// 페이지네이션(1-10)
		int endPage = (int) (Math.ceil(orderVO.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage) endPage = totalPage;
				
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;

		List<OrderVO> list = mapper.list(orderVO); // 목록

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("total", count);
		map.put("totalPage", totalPage);
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		map.put("currentPage", orderVO.getPage());
		return map;
	}
	
	@Override
	public OrderVO orderInfo(OrderVO orderVO) {
		return  mapper.orderInfo(orderVO);
	}
	
	@Override
	public OrderDetailVO orderDetailInfo(OrderDetailVO orderDetailVO) {
		return  mapper.orderDetailInfo(orderDetailVO);
	}
	
	@Override
	public List<OrderDetailVO> orderDetailList(OrderVO orderVO) {
		return  mapper.orderDetailList(orderVO);
	}

	@Override
	public boolean orderConfirm(OrderDetailVO vo) {
		return mapper.orderConfirm(vo) == 0 ? false : true;
	}
	
	

}
