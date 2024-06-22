package kr.co.soaff.cart;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface CartService {

	Map<String, Object> list(CartVO vo);

	int updateAmount(CartVO vo);

	int delete(CartVO vo);

	List<Integer> insert(CartItemDTO dto, int user_no);

}
