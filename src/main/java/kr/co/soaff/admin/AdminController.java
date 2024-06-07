package kr.co.soaff.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private AdminService service;
	
	@GetMapping("/login")
	public String login() {
		return "/admin/login";
	}
	@PostMapping("/login")
	public String login(AdminVO vo, Model model, HttpSession session) {
		AdminVO login = service.login(vo);
		if(login == null) {
			model.addAttribute("msg","아이디, 비밀번호를 확인하세요.");
			model.addAttribute("url", "/admin/login");
			return "common/alert";
		} else {
			session.setAttribute("login", login);
		}
		return "redirect:/admin/index";
	}

}
