package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class UserAdminController {
	
	@Autowired
	private UserAdminService service;

	@GetMapping("/user")
	public String list(Model model, UserVO vo) {
		model.addAttribute("map", service.list(vo));
		return "admin/user/list";
	}
	
	@GetMapping("/user/detail")
	public String detail(Model model, UserVO vo) {
		model.addAttribute("user", service.detail(vo));
		return "admin/user/detail";
	}
	
	@PostMapping("/user/update")
	public String update(Model model, UserVO vo) {
		if(service.update(vo)) {
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "/user/detail");
		}else{
			model.addAttribute("msg", "오류: 관리자에게 문의하세요.");
			model.addAttribute("url", "/user/detail");	
		}
		return "common/alert";
	}
	
}