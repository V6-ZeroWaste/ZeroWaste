package kr.co.soaff.order;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderAdminController {

	@Autowired
	private OrderAdminService service;

//	@ResponseBody
	@GetMapping("/admin/order/list")
	public String index(Model model, OrderVO orderVO) {
		model.addAttribute("map", service.list(orderVO));
//		log.info(vo.getStart_date() + "");
//		log.info(vo.getEnd_date() + "");
		return "/admin/order/list";
	}

// 회원 상세 페이지 - 리스트 불러오기 (ajax)  
	@GetMapping("/admin/order/getList")
	@ResponseBody
	public Map<String, Object> list(OrderVO orderVO) {
		return service.list(orderVO);
	}

//	@ResponseBody
	@GetMapping("/admin/order/detail")
	public String detail(Model model, OrderVO orderVO) {
		model.addAttribute("detailMap", service.detail(orderVO));
		return "/admin/order/detail";
	}

	// 상품상세페이지 배송상태 변경
	// ajax,alert
	@ResponseBody
	@PostMapping(value = "/admin/order/detail/updateDeliveryStatus", produces = "application/text; charset=utf8")
	public String updateDeliveryStatus(@RequestBody OrderVO orderVO) {
//		System.out.println(orderVO.toString());
		return service.updateDeliveryStatus(orderVO) + "";
	}

}
