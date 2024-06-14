package kr.co.soaff.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderController {

    @GetMapping("/order")
    public String goOrder() {
        return "/user/order/order";
    }


}