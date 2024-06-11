package kr.co.soaff.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user/review")
public class ReviewUserController {
	@Autowired
	private ReviewAdminService service;
	
	@GetMapping("/list")
	public String index(Model model, ReviewVO vo) {
		model.addAttribute("map", service.list(vo));
		return "/user/review/list";
	}
}
