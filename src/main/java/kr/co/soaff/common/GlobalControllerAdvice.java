package kr.co.soaff.common;

import kr.co.soaff.admin.AdminVO;
import kr.co.soaff.item.CategoryVO;
import kr.co.soaff.item.ItemService;
import kr.co.soaff.point.PointService;
import kr.co.soaff.point.PointVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private ItemService itemService;
    @Autowired
    private PointService poinstService;

    @ModelAttribute
    public void addCategoriesToModel(Model model) {
        List<CategoryVO> categories = itemService.categories();
        model.addAttribute("categories", categories);
    }

    @ModelAttribute
    public void addUserInfo(Model model, HttpSession session){
        String userId = (String) session.getAttribute("user_id");
        if(userId != null) {
            PointVO pointVo = new PointVO();
            pointVo.setUser_no((int) session.getAttribute("user_no"));
            model.addAttribute("userPoint", (int) poinstService.total(pointVo));
            model.addAttribute("userId", userId);
        }
    }

    @ModelAttribute
    public void addLoginInfo(Model model, HttpSession session){
        AdminVO adminVo = (AdminVO) session.getAttribute("adminLogin");
        if(adminVo != null) {
            model.addAttribute("adminVo", adminVo);
        }
    }
}
