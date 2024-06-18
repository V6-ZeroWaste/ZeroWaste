package kr.co.soaff.cancel;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.soaff.order.OrderVO;

@Controller
public class CancelController {
	
	
    @GetMapping("/mypage/cancelInfo")
    public String cancelInfo(Model model, OrderVO orderVO) {
      return "/user/order/cancelForm";
    }
    @GetMapping("/mypage/cancelRequest")
    public String cancelRequest(Model model, OrderVO orderVO) {
        return "/user/order/cancelForm";
      }

}
