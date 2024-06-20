package kr.co.soaff.cart;

import java.util.Map;

public interface CartService {

	Map<String, Object> list(CartVO vo);

	int updateAmount(CartVO vo);

	int delete(CartVO vo);

}
