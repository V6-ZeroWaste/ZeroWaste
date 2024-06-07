package kr.co.soaff.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderAdminController {

	@Autowired
	private OrderAdminService service;

//	@ResponseBody
	@GetMapping("/admin/order/index")
	public String index(Model model, OrderVO vo) {
		model.addAttribute("map", service.list(vo));
		return "/admin/order/index";
	}

//	@ResponseBody
	@PostMapping("/admin/order/detail")
	public String detail(Model model, OrderVO orderVO) {
		model.addAttribute("detailMap", service.detail(orderVO));
//		log.info("order_no={}", orderVO.getOrder_no());
		return "/admin/order/detail";
	}

	// 상품상세페이지 배송상태 변경
	// ajax로 alert 띄울 예정
	@PostMapping("/admin/order/detail/updateDeliveryStatus")
	public int updateDeliveryStatus(OrderVO orderVO) {
		return service.updateDeliveryStatus(orderVO);
	}

}
