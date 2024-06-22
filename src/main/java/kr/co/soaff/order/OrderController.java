package kr.co.soaff.order;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;


@Controller
public class OrderController {


    @Autowired
    private OrderService service;

    @GetMapping("/mypage/order/list")
    public String index(Model model, OrderVO vo, HttpSession session) {
    	vo.setUser_no(1); 
    	// session에서 user_no 가져오기
//    	orderVo.setUser_no((int) session.getAttribute("user_no"));
    	model.addAttribute("map", service.list(vo));
    	
      return "/user/order/list";
    }

    @GetMapping("/mypage/order/detail")
    public String detail(Model model, OrderVO vo, HttpSession session) {
    	vo.setUser_no(1); 
    	// session에서 user_no 가져오기
//    	vo.setUser_no((int) session.getAttribute("user_no"));
    	OrderVO orderVo = service.orderInfo(vo);
    	if(orderVo == null || orderVo.getOrder_no() == 0) {
    		return "/user/include/404";
    	}
    	orderVo.setUser_no(1);
//    	orderVo.setUser_no((int) session.getAttribute("user_no"));
    	model.addAttribute("order", orderVo);
    	model.addAttribute("list", service.orderDetailList(orderVo));
    	return "/user/order/detail";
    }	
    @PostMapping( value = "/mypage/order/detail/confirm", produces = "application/text; charset=utf8")
    @ResponseBody
    public String confirm(@RequestBody OrderDetailVO vo, HttpSession session) {
    	vo.setUser_no(1);
    	// session에서 user_no 가져오기
//    	vo.setUser_no((int) session.getAttribute("user_no"));
    	String msg = "";
    	if(service.orderConfirm(vo)) {
    		msg = "처리 완료";
		} else {
			msg = "처리 실패";
		}
		return msg;
    }	
    


    @GetMapping("/order")
    public String goOrder() {
        return "/user/order/order";
    }

    @GetMapping("/order/success")
    public String success() {
        return "/user/order/success";
    }
    
        


}

