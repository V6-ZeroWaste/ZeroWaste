package kr.co.soaff.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soaff.cart.CartVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	OrderMapper mapper;

	@Override
	public Map<String, Object> list(OrderVO orderVO) {
		// 페이징 처리(10개씩)
		int count = mapper.count(orderVO); // 총 개수
		int totalPage = count / 10; // 총 페이지수
		if (count % 10 > 0)
			totalPage++;

		// 페이지네이션(1-10)
		int endPage = (int) (Math.ceil(orderVO.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage)
			endPage = totalPage;

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
		return mapper.orderInfo(orderVO);
	}

	@Override
	public OrderDetailVO orderDetailInfo(OrderDetailVO orderDetailVO) {
		return mapper.orderDetailInfo(orderDetailVO);
	}

	@Override
	public List<OrderDetailVO> orderDetailList(OrderVO orderVO) {
		return mapper.orderDetailList(orderVO);

	}

	@Override
	public boolean orderConfirm(OrderDetailVO vo) {
		return mapper.orderConfirm(vo) == 0 ? false : true;
	}

	@Override
	public Map<String, Object> order(OrderVO orderVO, String type, int[] amountArray) {
		Map<String, Object> map = new HashMap<>();
		List<CartVO> cartList = mapper.cartList(orderVO);
		int point = mapper.point(orderVO);
		int cartCount = mapper.cartCount(orderVO);
		OrderVO info = mapper.info(orderVO);

		//type = buy 일 때 amountArray에 있는 값으로 보내기
		if(type!=null && type.equals("buy")){
			for(int i = 0 ; i < cartList.size(); i++){
				cartList.get(i).setAmount(amountArray[i]);
			}
		}
		map.put("cartList", cartList);
		map.put("point", point);
		map.put("info", info);
		map.put("cartCount", cartCount);

		return map;
	}

	@Override
	public Integer orderInsert(OrderVO vo) {
		int orderInsertResult = mapper.orderInsert(vo);
		int orderNo = vo.getOrder_no();
		int pointTouse = vo.getPoint() * -1;
		vo.setPoint(pointTouse);
		int pointInsertResult = mapper.pointMinus(vo);
		// int pointPlusResult = mapper.pointPlus(vo);
		int[] amountArray = vo.getAmountArray();
		int[] priceArray = vo.getPriceArray();
		int[] itemNoArray = vo.getItemNoArray();
		List<OrderVO> list = new ArrayList<OrderVO>();
		for (int i = 0; i < amountArray.length; i++) {
			OrderVO orderVO = new OrderVO();
			orderVO.setOrder_no(orderNo);
			orderVO.setUser_no(vo.getUser_no());
			orderVO.setAmount(amountArray[i]);
			orderVO.setPrice(priceArray[i]);
			orderVO.setItem_no(itemNoArray[i]);
			list.add(orderVO);
		}
		int orderDetailInsertResult = mapper.orderDetailInsert(list);
//		int orderDetailInsertResult = 0;
//
//		int[] amountArray = vo.getAmountArray();
//		int[] priceArray = vo.getPriceArray();
//		int[] itemNoArray = vo.getItemNoArray();
//		for (int i = 0; i < amountArray.length; i++) {
//			OrderVO orderVO = new OrderVO();
//			orderVO.setUser_no(vo.getUser_no());
//			orderVO.setAmount(amountArray[i]);
//			orderVO.setPrice(priceArray[i]);
//			orderVO.setItem_no(itemNoArray[i]);
//			orderDetailInsertResult += mapper.orderDetailInsert(orderVO);
//		}

		return orderInsertResult > 0 && pointInsertResult > 0 && orderDetailInsertResult > 0 ? orderNo : null;

	}

	@Override
	public int deleteCartAfterOrder(OrderVO vo) {
		return mapper.deleteCartAfterOrder(vo);
	}

}
