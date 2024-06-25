package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.StringTokenizer;

@Controller
public class ProfileController {
    @Autowired
    ProfileService service;

    @GetMapping("/mypage/profile")
    public String profile(HttpSession session, Model model) {
        int user_no = (int) session.getAttribute("user_no");
        UserVO vo  = service.getInfo(user_no);
        model.addAttribute("vo", vo);
        String tel = vo.getTel();
        StringTokenizer st = new StringTokenizer(tel, "-");
        String tel1 = st.nextToken();
        String tel2 = st.nextToken();
        String tel3 = st.nextToken();
        model.addAttribute("tel1", tel1);
        model.addAttribute("tel2", tel2);
        model.addAttribute("tel3", tel3);
        System.out.println(model);
        return "/user/user/profile";
    }

    @PostMapping("/updateInfo")
    @ResponseBody
    public String update(@RequestBody UserVO vo, HttpSession session) {
//        UserVO info = (UserVO) session.getAttribute("vo");
        int user_no = (int) session.getAttribute("user_no");
        UserVO info  = service.getInfo(user_no);

        vo.setUser_no(info.getUser_no());
        vo.setEmail(info.getEmail());

        if ("default".equals(vo.getPw())) {
            vo.setPw(info.getPw());
        }
        int i = service.updateInfo(vo);
        if (i > 0) {
            UserVO login = service.getInfo(user_no);
            session.setAttribute("user_name", login.getName());
            session.setAttribute("vo",login);
            return "1";
        } else {
            return "0";
        }
    }

    @PostMapping("/deletecheck")
    @ResponseBody
    public String deleteCheck(@RequestBody UserVO vo, HttpSession session, HttpServletResponse res) {
        UserVO deleteCheck = (UserVO) session.getAttribute("vo");
        deleteCheck.setPw(vo.getPw());
        int i = service.deleteCheck(deleteCheck);
        if (i > 0) {
            service.delete(deleteCheck);
            session.invalidate();
            Cookie cookie = new Cookie("saved_id", null);
            cookie.setMaxAge(0); // 쿠키 삭제
            res.addCookie(cookie);
            return "1";
        }else {
            return "0";
        }
    }
}
