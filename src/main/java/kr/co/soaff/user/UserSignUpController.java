package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class UserSignUpController {
    @Autowired
    private UserSignUpService service;

    @GetMapping("/user/user/signup")
    public String userSignUp() {
        return "/user/user/signup";
    }

    @PostMapping("/user/user/signup")
    public String userSignUp(Model model, UserVO vo){
        return "/user/user/signup";
    }


    @PostMapping("/user/user/idcheck")
    @ResponseBody
    public String idCheck(@RequestBody UserVO vo) {
        System.out.println(vo + "adsd");
        int i = service.idCheck(vo);
        System.out.println(i + "sdasd");
        String result = Integer.toString(i);
        return result;
    }

}
