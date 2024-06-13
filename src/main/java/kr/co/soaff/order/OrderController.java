package kr.co.soaff.order;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
public class OrderController {

	@Autowired
	private OrderAdminService service;

	@GetMapping("/mypage/order")
	public String index(Model model, OrderVO orderVO) {
		return "/user/order/list";
	}
	
	@GetMapping("/mypage/order/detail")
	public String detail(Model model, OrderVO orderVO) {
		return "/user/order/detail";
	}


}
