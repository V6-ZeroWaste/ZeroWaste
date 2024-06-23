package kr.co.soaff.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private AdminService service;
	
	@GetMapping("/login")
	public String login() {
		return "/admin/login";
	}
	@PostMapping(value="/login")
	@ResponseBody
	public void login(AdminVO vo, HttpSession session, HttpServletResponse resp) throws IOException {
		AdminVO login = service.login(vo);
		resp.setContentType("text/html;charset=utf8");
		System.out.println(vo.toString());
		PrintWriter out = resp.getWriter();
		if(login == null) {
			out.print("<script>alert('아이디, 비밀번호를 확인하세요'); history.go(-1)");
			out.print("</script>");
		} else {
			session.setAttribute("adminLogin", login);
			out.print("<script>location.href='/admin'");
			out.print("</script>");
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession sess){
		sess.invalidate();
		return "redirect:/admin/login";
	}

}
