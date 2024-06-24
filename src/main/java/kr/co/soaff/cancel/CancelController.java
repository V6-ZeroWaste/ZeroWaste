package kr.co.soaff.cancel;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soaff.order.OrderDetailVO;
import kr.co.soaff.order.OrderService;
import kr.co.soaff.order.OrderVO;

@Controller
public class CancelController {
	

	@Autowired
	private CancelService cancelService;
	@Autowired
	private OrderService orderService;
	
	
	
    @GetMapping("/order/cancel/{type}")
    public String cancelInfo(Model model, OrderDetailVO vo, @PathVariable String type, HttpSession session) {
    	if( !("form".equals(type)||"info".equals(type)) || vo.getOrder_detail_no() == 0 ) {
    		return "/user/include/404";
    	}
    	vo.setUser_no((int) session.getAttribute("user_no"));

    	OrderDetailVO orderDetail = orderService.orderDetailInfo(vo);
    	if(orderDetail == null) {
    		return "/user/include/404";
    	}
    	if("form".equals(type) && orderDetail.getCancel_status() != null) {
    		return "/user/include/404";
    	}
    	if("info".equals(type) && orderDetail.getCancel_status() == null) {
    		return "/user/include/404";
    	}
    	OrderVO ovo = new OrderVO();
    	ovo.setUser_no((int) session.getAttribute("user_no"));
    	ovo.setOrder_no(orderDetail.getOrder_no());
    	OrderVO order = orderService.orderInfo(ovo);
    	if("form".equals(type) && order.getDelivery_status() != 0) {
    		return "/user/include/404";
    	}
    	int origin_price = order.getPayment_price() + order.getPoint() - order.getDelivery_price();
    	int refund_point = (int) Math.floor(order.getPoint() * ((double)(orderDetail.getPrice() * orderDetail.getAmount()) / origin_price));
    	int refund_price = orderDetail.getPrice() * orderDetail.getAmount() - refund_point;
    	if(("form".equals(type) && order.getCancel_count() <= 1)
    		||("info".equals(type) && (order.getLast_cancel_date()).equals(orderDetail.getCancel_request_date()))) {
    		refund_price += order.getDelivery_price();
    	}
    	model.addAttribute("origin_price", origin_price);
    	model.addAttribute("refund_point", refund_point);
    	model.addAttribute("refund_price", refund_price);
    	model.addAttribute("order", order);
    	model.addAttribute("detail", orderDetail);
    	model.addAttribute("type", type);
    	return "/user/order/cancelForm";
    }
    
    @PostMapping(value = "/order/cancel/form", produces = "application/text; charset=utf8")
    @ResponseBody
    public String cancel(@RequestBody CancelAdminDetailVO vo, HttpSession session) {
    	String msg = "";
    	vo.setUser_no((int) session.getAttribute("user_no"));
    	if(cancelService.requestCancel(vo)) {
    		msg="true";
    	}else {
    		msg="false";
    	}
    	
    	return msg;
    }
    
    

}
