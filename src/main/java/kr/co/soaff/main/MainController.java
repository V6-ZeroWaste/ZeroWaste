package kr.co.soaff.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class MainController {
	//user_id
	//user_no
	//user_name

	@GetMapping("/")
	public String index(HttpSession session, Model model)
	{
		session.getAttribute("user_id");
		model.addAttribute("user_id", session.getAttribute("user_id"));
		return "/user/main/index";
	}

	@GetMapping("/cart")
	public String cart(HttpSession session, Model model) {

		return "/user/order/cart";
	}

	@GetMapping("/about")
	public String about() {
		return "/user/main/about";
	}

	@GetMapping("/logout")
	public String logout(HttpSession sess) {
		sess.invalidate();
		return "redirect:/";
	}
}
