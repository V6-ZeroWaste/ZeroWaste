package kr.co.soaff.common;

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
    public void addCategoriesToModel(Model model, HttpServletRequest request) {
        List<CategoryVO> categories = itemService.categories();
        model.addAttribute("categories", categories);
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("user_id");
        if(userId != null) {
        	PointVO pointVo = new PointVO();
        	pointVo.setUser_no((int) session.getAttribute("user_no"));
        	model.addAttribute("userPoint", (int) poinstService.total(pointVo));
        	model.addAttribute("userId", userId);
        	
        }
        
      
    }
}
