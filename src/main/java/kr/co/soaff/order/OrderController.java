package kr.co.soaff.order;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {

	@Autowired
	private OrderService service;

	@GetMapping("/mypage/order/list")
	public String index(Model model, OrderVO vo, HttpSession session) {
		// session에서 user_no 가져오기
		vo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("map", service.list(vo));

		return "/user/order/list";
	}

	@GetMapping("/mypage/order/detail")
	public String detail(Model model, OrderVO vo, HttpSession session) {
		// session에서 user_no 가져오기
		vo.setUser_no((int) session.getAttribute("user_no"));
		OrderVO orderVo = service.orderInfo(vo);
		if (orderVo == null || orderVo.getOrder_no() == 0) {
			return "/user/include/404";
		}
		orderVo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("order", orderVo);
		model.addAttribute("list", service.orderDetailList(orderVo));
		return "/user/order/detail";
	}

	@PostMapping(value = "/mypage/order/detail/confirm", produces = "application/text; charset=utf8")
	@ResponseBody
	public String confirm(@RequestBody OrderDetailVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		String msg = "";
		if (service.orderConfirm(vo)) {
			msg = "처리 완료";
		} else {
			msg = "처리 실패";
		}
		return msg;
	}

	@PostMapping("/order")
	public String goOrder(OrderVO vo, Model model, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		vo.setBuyer_name((String) session.getAttribute("user_name"));
		model.addAttribute("map", service.order(vo));
		return "user/order/order";
	}

	@GetMapping("/order/success")
	public String success(HttpSession session, int order_no) {
		return "user/order/success";
	}

	@ResponseBody
	@PostMapping(value = "/order/insert", produces = "application/text; charset=utf8")
	public String orderInsert(@RequestBody OrderVO vo, HttpSession session) {
		int userNo = (int) session.getAttribute("user_no");
		vo.setUser_no(userNo);
		boolean orderInsertResult = service.orderInsert(vo);

		String msg = "";
		if (orderInsertResult) {
			msg = "success";
		} else {
			msg = "fail";
		}
		return msg;

	}

	@ResponseBody
	@GetMapping("/order/deleteCartAfterOrder")
	public String deleteCartAfterOrder(@RequestParam("checkedCartNo") int[] checkedCartNo, HttpSession session) {
		OrderVO vo = new OrderVO();
		vo.setCheckedCartNo(checkedCartNo);
		vo.setUser_no((int) session.getAttribute("user_no"));

		log.info(vo.toString());

		String msg = "";
		if (service.deleteCartAfterOrder(vo) > 0) {
			msg = "success";
		} else {
			msg = "fail";
		}
		return msg;

	}

}
