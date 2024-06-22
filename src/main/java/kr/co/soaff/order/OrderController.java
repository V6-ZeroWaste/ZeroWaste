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
	public String goOrder(OrderVO vo, Model model, HttpSession session) {
//		session에서 user_no 가져오기
		vo.setUser_no((int) session.getAttribute("user_no"));
		vo.setBuyer_name((String) session.getAttribute("user_name"));
//		vo.setUser_no(1); // 세션 사용시 지울것
//		vo.setBuyer_name("테스트0"); // 세션 사용시 지울것

		model.addAttribute("map", service.order(vo));

		return "user/order/order";
	}

	@GetMapping("/order/success")
	public String success(HttpSession session) {
		return "/user/order/success";
	}
//	@GetMapping("/order/success")
//	public String success(HttpServletRequest req, HttpServletResponse res, Model model) throws Exception {
//		RequestDispatcher dispatcher = req.getRequestDispatcher("user/order/success");
//		dispatcher.forward(req, res);
//		
//		return "user/order/success";
//	}

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
//		session에서 user_no 가져오기
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
