package kr.co.soaff.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	@GetMapping("/index")
	public String index() {
		return "/user/main/index";
	}

	@GetMapping("/login")
	public String login() {
		return "/user/login";
	}

}
