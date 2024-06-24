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
    private UserLoginService userLoginService;

    @GetMapping("/user/user/login")
    public String login(Model model, @CookieValue(value = "saved_id", required = false) String id) {
        model.addAttribute("saved_id", id);
        return "user/user/login"; 
    }

    @PostMapping(value = "/user/user/login")
    @ResponseBody
    public String login(@RequestBody UserVO vo,HttpSession session, HttpServletResponse res) throws IOException {
//        res.setContentType("text/html;charset=utf-8");
//        PrintWriter out = res.getWriter();
        UserVO login = userLoginService.login(vo);
        System.out.println(login);
        if (login != null) {
            if(login.getDelete() != null) {
                return "2";
            }
            session.setAttribute("user_id", login.getId());
            session.setAttribute("user_name", login.getName());
            session.setAttribute("user_no", login.getUser_no());
            session.setAttribute("vo", login);

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
            return "0";//성공
        } else if (login == null) {
            return "1";
        }
        return "1";
    }
}
