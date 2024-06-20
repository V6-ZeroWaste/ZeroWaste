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

    @GetMapping("user/user/login")
    public String login(Model model ,@CookieValue(value = "saved_id", required = false) String id ) {
        model.addAttribute("saved_id",id);
        return "user/login";
    }

    @PostMapping("user/user/login")
    public void login(UserVO vo, HttpSession session, HttpServletResponse res, Model model) throws IOException {
        UserVO login = userService.login(vo);
        String saved_id = login.getSaved_id();
        res.setContentType("text/html;charset=utf-8");
        PrintWriter out = res.getWriter();
        System.out.println(vo.toString());
        if (login != null) {
            session.setAttribute("user", login);
            if (saved_id.equals("yes")) {
                Cookie cookie = new Cookie("saved_id", login.getId());
                cookie.setMaxAge(60 * 60 * 24 * 30); // 쿠키 유효기간 30일
                res.addCookie(cookie);
            }
            out.println("<script type=\"text/javascript\">");
            out.println("alert('로그인 성공')");
            out.println("location.href = '/';");
            out.println("</script>");
        }
        else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('일치하는 계정이 없습니다')");
            out.println("location.href = 'user/user/login';");
        }
        out.flush();
    }
    }