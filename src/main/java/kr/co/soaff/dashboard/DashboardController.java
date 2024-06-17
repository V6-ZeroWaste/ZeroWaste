package kr.co.soaff.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/dashboard")
public class DashboardController {
	@Autowired
	private DashboardService service;

	@GetMapping("/index")
	public String login() {
		return "/admin/dashboard/index";
	}

	@GetMapping("/취소")
	public String goCancel() {
		return "/admin/cancel/list";
	}

	@GetMapping("/문의")
	public String goReview() {
		return "/admin/qna/list";
	}

	@GetMapping("/주문")
	public String goOrder() {
		return "/admin/order/list";
	}

}
