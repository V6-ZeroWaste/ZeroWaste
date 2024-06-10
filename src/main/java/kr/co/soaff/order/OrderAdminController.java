package kr.co.soaff.order;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public Map<String, Object> listAjax(OrderVO orderVO) {
		Map<String, Object> map = service.list(orderVO);
		String printList = "";
		List<OrderVO> orderList = (List<OrderVO>) map.get("list");
		if (orderList.size() == 0) {
			printList = "<td class='first' colspan='5' style='text-align: center;'>등록된 글이 없습니다.</td>";
		}
		for (OrderVO vo : orderList) {
			printList += "<tr>";
			printList += "<td location.href='/admin/order/detail?order_no='" + vo.getOrder_no() + ">" + vo.getOrder_no()
					+ "</td>";
			printList += "<td>" + vo.getPayment_date() + "</td>";
			printList += "<td>" + vo.getId() + "</td>";
			printList += "<td>" + vo.getPayment_price() + "(" + vo.getTotal_amount() + ")</td>";
			printList += "<td>" + vo.getOrder_status() + "</td>";
			printList += "</tr>";
		}
		map.put("printList", printList);
		return map;
	}

//	@ResponseBody
	@GetMapping("/admin/order/detail")
	public String detail(Model model, OrderVO orderVO) {
		model.addAttribute("detailMap", service.detail(orderVO));
		log.info("order_no={}", orderVO.getOrder_no());
		return "/admin/order/detail";
	}

	// 상품상세페이지 배송상태 변경
	// ajax로 alert 띄울 예정
//	@ResponseBody
	@PostMapping("/admin/order/detail/updateDeliveryStatus")
	public int updateDeliveryStatus(OrderVO orderVO) {
		return service.updateDeliveryStatus(orderVO);
	}

}
