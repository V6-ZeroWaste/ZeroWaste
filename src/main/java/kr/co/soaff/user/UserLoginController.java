package kr.co.soaff.user;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserLoginController {
	@Autowired
	private UserService userService;

	@GetMapping("/user/user/login")
	public String login(Model model, @CookieValue(value = "saved_id", required = false) String id) {
		model.addAttribute("saved_id", id);
		return "user/user/login";
	}

	@PostMapping(value = "/user/user/login")
	@ResponseBody
	public String login(@RequestBody UserVO vo, HttpSession session, HttpServletResponse res) throws IOException {
//        res.setContentType("text/html;charset=utf-8");
//        PrintWriter out = res.getWriter();
		UserVO login = userService.login(vo);

		System.out.println(vo);
		String result = "1";
		if (login != null) {
			session.setAttribute("user_id", login.getId());
			session.setAttribute("user_name", login.getName());
			session.setAttribute("user_no", login.getUser_no());

			String saved_id = vo.getIdSaveCheck();
			if ("yes".equals(saved_id)) { // Check if rememberMe is checked
				Cookie cookie = new Cookie("saved_id", login.getId());
				cookie.setMaxAge(60 * 60 * 24 * 30); // 쿠키 유효기간 30일
				res.addCookie(cookie);
			} else {
				Cookie cookie = new Cookie("saved_id", null);
				cookie.setMaxAge(0); // 쿠키 삭제
				res.addCookie(cookie);
			}
			result = "0";// 성공
		} else {
			result = "1"; // 실패
		}
		return result;
	}
}
