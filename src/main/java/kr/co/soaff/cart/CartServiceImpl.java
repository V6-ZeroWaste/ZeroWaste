package kr.co.soaff.cart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartMapper mapper;

	@Override
	public Map<String, Object> list(CartVO vo) {
		Map<String, Object> map = new HashMap<>();
		List<CartVO> list = mapper.list(vo);
		map.put("list", list);

		int count = mapper.count(vo); // 총 개수
		int totalPage = count / 10; // 총 페이지수
		if (count % 10 > 0)
			totalPage++;
		// 페이지네이션(1-10)
		int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage)
			endPage = totalPage;
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;

		map.put("count", count);
		map.put("total", totalPage);
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		return map;
	}

	@Override
	public int updateAmount(CartVO vo) {
		return mapper.updateAmount(vo);
	}

	@Override
	public int delete(CartVO vo) {
		return mapper.delete(vo);
	}

	public List<Integer> insert(CartItemDTO dto, int user_no) {
		List<Integer> itemNoArray = dto.getItem_no_array();
		List<Integer> packingStatusArray = dto.getPacking_status_array();
		List<Integer> amountArray = dto.getAmount_array();
		int size = itemNoArray.size();
		List<Integer> cartNos = new ArrayList<>();
		for(int i=0; i<size; i++) {
			CartVO vo = new CartVO();
			vo.setUser_no(user_no);
			vo.setItem_no(itemNoArray.get(i));
			vo.setPacking_status(packingStatusArray.get(i));
			vo.setAmount(amountArray.get(i));
			if(mapper.insert(vo)!=0){
				cartNos.add(vo.getCart_no());
			}
		}
		return cartNos;
    }

}
