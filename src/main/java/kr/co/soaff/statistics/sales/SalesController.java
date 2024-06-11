package kr.co.soaff.statistics.sales;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/statistics/sales")
public class SalesController {
	@Autowired
	private SalesService service;

	@GetMapping("/index")
	public String login() {
		return "/admin/login";
	}

}
