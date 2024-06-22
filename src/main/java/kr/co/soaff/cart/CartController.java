package kr.co.soaff.cart;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import lombok.extern.slf4j.Slf4j;

@Slf4j
//@RequestMapping("/cart")
@Controller
public class CartController {

	@Autowired
	private CartService service;

	@GetMapping("/cart")
	public String index(Model model, CartVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		Map<String, Object> map = service.list(vo);
		model.addAttribute("map", map);
		return "/user/order/cart";
	}

	@ResponseBody
	@GetMapping("/cart/updateAmount")
	public int updateAmount(Model model, CartVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		return service.updateAmount(vo);
	}

	@ResponseBody
	@GetMapping("/cart/delete")
	public int delete(Model model, CartVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		log.info("vo.getCart_no : " + vo.getCart_no());
		System.out.println("--");
		return service.delete(vo);
	}

	@PostMapping("/cart/addItem")
	@ResponseBody
	public Map<String, Object> addItem(@RequestBody CartItemDTO dto) {
		List<Integer> cartNos = service.insert(dto);
		Map<String, Object> map = new HashMap<>();
		map.put("status", dto.getStatus());
		map.put("cartNos", cartNos);
		return map;
	}


}
