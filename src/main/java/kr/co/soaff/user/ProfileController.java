package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class ProfileController {
    @Autowired
    ProfileService service;

    @GetMapping("/user/user/profile")
    public String profile(HttpSession session, Model model) {
        UserVO vo = (UserVO) session.getAttribute("vo");
        model.addAttribute("vo", vo);
        String tel = vo.getTel();
        if (tel.length() == 10) {
            model.addAttribute("tel1", tel.substring(0, 3));
            model.addAttribute("tel2", tel.substring(3, 6));
            model.addAttribute("tel3", tel.substring(6, 10));
        }
        if (tel.length() == 11) {
            model.addAttribute("tel1", tel.substring(0, 3));
            model.addAttribute("tel2", tel.substring(3, 7));
            model.addAttribute("tel3", tel.substring(7, 11));
        }
        System.out.println(model);
        return "/user/user/profile";
    }

    @PostMapping("/user/user/updateInfo")
    @ResponseBody
    public String update(@RequestBody UserVO vo, HttpSession session) {
        UserVO info = (UserVO) session.getAttribute("vo");

        vo.setUser_no(info.getUser_no());
        vo.setEmail(info.getEmail());

        if ("default".equals(vo.getPw())) {
            vo.setPw(info.getPw());
        }

        int i = service.updateInfo(vo);
        int user_no = vo.getUser_no();
        if (i > 0) {
            UserVO login = service.updateSession(user_no);
            session.setAttribute("user_id", login.getId());
            session.setAttribute("user_name", login.getName());
            session.setAttribute("user_no", login.getUser_no());
            session.setAttribute("vo",login);
            return "1";
        } else {
            return "0";
        }
    }

    @PostMapping("/user/user/deletecheck")
    @ResponseBody
    public String deleteCheck(@RequestBody UserVO vo, HttpSession session) {
        UserVO deleteCheck = (UserVO) session.getAttribute("vo");
        deleteCheck.setPw(vo.getPw());
        int i = service.deleteCheck(deleteCheck);
        if (i > 0) {
            return "1";
        }else {
            return "0";
        }
    }

    @GetMapping("/user/user/delete")
    public String delete(UserVO vo, HttpSession session, HttpServletResponse res) {
        UserVO delete = (UserVO) session.getAttribute("vo");
        delete.setPw(vo.getPw());
        int i = service.delete(delete);
        if (i > 0) {
            session.invalidate();
            Cookie cookie = new Cookie("saved_id", null);
            cookie.setMaxAge(0); // 쿠키 삭제
            res.addCookie(cookie);
        }
        return "redirect:/";
    }
}
