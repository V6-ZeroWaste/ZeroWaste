package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class UserFindController {

    @Autowired
    UserFindService service;

    @GetMapping("/{find}")
    public String userFind(@PathVariable String find, Model model) {
        model.addAttribute("find", find);
        return "user/user/find";
    }

    @PostMapping("/idFindCheck")
    @ResponseBody
    public String idFindCheck(@RequestBody UserVO vo) {
        UserVO idfinds = service.idFindCheck(vo);
        if (idfinds != null) {
            return "1";
        } else {
            return "0";
        }
    }

    @PostMapping("/pwFindCheck")
    @ResponseBody
    public String pwFindCheck(@RequestBody UserVO vo) {
//        System.out.println(vo);
        UserVO pwfinds = service.pwFindCheck(vo);
//        System.out.println(pwfinds);
        if (pwfinds != null) {
            return "1";
        } else {
            return "0";
        }
    }

    @PostMapping("/idFind")
    public String idFind(UserVO vo, RedirectAttributes redirectAttributes) {
        UserVO idfinds = service.idFindCheck(vo);
        redirectAttributes.addFlashAttribute("find", idfinds);
        return "redirect:/idFindSuccess";
    }

    @GetMapping("/idFindSuccess")
    public String idFindSuccess(Model model) {
        if (model.containsAttribute("find")) {
            UserVO idfinds = (UserVO) model.getAttribute("find");
            model.addAttribute("find", idfinds);
        }
        return "user/user/idFindSuccess";
    }




    @PostMapping("/pwFind") //아이디 , 이름
    public String pwFind(UserVO vo, HttpSession session) {
        UserVO pwfinds = service.pwFindCheck(vo);
        session.setAttribute("find", pwfinds);
        return "/user/user/pwFindEmail";
    }


    @PostMapping("/pwFindResubmit")
    public String pwFindResubmit(HttpSession session) {
        session.getAttribute("find");
        return "/user/user/pwFindResubmit";
    }

    @PostMapping("/pwNewCheck")
    @ResponseBody
    public String pwNewCheck(@RequestBody UserVO vo,HttpSession session) {
        UserVO pwNewCheck = (UserVO) session.getAttribute("find");
        pwNewCheck.setPw(vo.getPw());
        int i = service.pwNewCheck(pwNewCheck);
        if (i > 0) {
            return "1";
        }
        else {
            int j = service.pwNewInsert(pwNewCheck);
            if (j > 0) {
                return "2";
            }
            return "0";
        }
    }

}
