package kr.co.soaff.order;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {

	@Autowired
	private OrderService service;

	@GetMapping("/mypage/order/list")
	public String index(Model model, OrderVO orderVo, HttpSession session) {
		orderVo.setUser_no(1);
		// session에서 user_no 가져오기
//    	orderVo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("map", service.list(orderVo));

		return "/user/order/list";
	}

	@GetMapping("/mypage/order/detail")
	public String detail(Model model, OrderVO orderVo, HttpSession session) {
		orderVo.setUser_no(1);
		// session에서 user_no 가져오기
//    	orderVo.setUser_no((int) session.getAttribute("user_no"));
		OrderVO vo = service.orderInfo(orderVo);
		if (vo == null) {
			return "/user/include/404";
		}

		model.addAttribute("order", vo);
		model.addAttribute("list", service.orderDetailInfo(orderVo));
		return "/user/order/detail";
	}

	@PostMapping(value = "/mypage/order/detail/confirm", produces = "application/text; charset=utf8")
	@ResponseBody
	public String confirm(@RequestBody OrderDetailVO vo, HttpSession session) {
		vo.setUser_no(1);
		// session에서 user_no 가져오기
//    	orderVo.setUser_no((int) session.getAttribute("user_no"));
		String msg = "";
		if (service.orderConfirm(vo)) {
			msg = "처리 완료";
		} else {
			msg = "처리 실패";
		}
		return msg;
	}

	@PostMapping("/order")
	public String goOrder(OrderVO vo, Model model) {
		vo.setUser_no(1); // 세션처리
		vo.setBuyer_name("테스트0"); // 세션처리

		model.addAttribute("map", service.order(vo));

		return "/user/order/order";
	}

	@GetMapping("/order/success")
	public String success() {
		return "/user/order/success";
	}

	@PostMapping("payment/complete")
	public int paymentComplete(@RequestBody OrderVO vo, Model model) {
		return service.updateOrder(vo);
	}
}
