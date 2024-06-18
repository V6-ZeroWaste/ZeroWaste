package kr.co.soaff.order;


import java.util.List;
import java.util.Map;

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
    private OrderAdminService service;

    @GetMapping("/mypage/order")
    public String index(Model model, OrderVO orderVO) {
      return "/user/order/list";
    }

    @GetMapping("/mypage/order/detail")
    public String detail(Model model, OrderVO orderVO) {
      return "/user/order/detail";
    }	
    @GetMapping("/mypage/cancelInfo")
    public String cancelInfo(Model model, OrderVO orderVO) {
      return "/user/order/cancelForm";
    }
    @GetMapping("/mypage/cancelRequest")
    public String cancelRequest(Model model, OrderVO orderVO) {
        return "/user/order/cancelForm";
      }

    @GetMapping("/mypage/point")
    public String point(Model model, OrderVO orderVO) {
      return "/user/order/pointList";
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

