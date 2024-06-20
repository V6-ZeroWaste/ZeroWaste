package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class UserLoginController {
    @Autowired
    private UserService userService;

    @GetMapping("/user/user/login")
    public String login(Model model, @CookieValue(value = "saved_id", required = false) String id) {
        model.addAttribute("saved_id", id);
        return "user/user/login"; 
    }

    @PostMapping("/user/user/login")
    @ResponseBody
    public int login(UserVO vo,HttpSession session, HttpServletResponse res) throws IOException {
        res.setContentType("text/html;charset=utf-8");
        PrintWriter out = res.getWriter();
        UserVO login = userService.login(vo);
        String saved_id = login.getSaved_id();
        System.out.print(vo);
        int result = -1;
        if (login != null && login.getId() != null) {
            session.setAttribute("user", login);
            if ("yes".equals(saved_id)) { // Check if rememberMe is checked
                Cookie cookie = new Cookie("saved_id", login.getId());
                cookie.setMaxAge(60 * 60 * 24 * 30); // 쿠키 유효기간 30일
                res.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("saved_id", null);
                cookie.setMaxAge(0); // 쿠키 삭제
                res.addCookie(cookie);
            }
            result=0;//성공
        } else {
			result=1; //실패
        }
        return result;
    }
}
