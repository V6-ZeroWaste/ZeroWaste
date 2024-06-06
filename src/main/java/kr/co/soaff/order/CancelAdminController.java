package kr.co.soaff.order;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin")
public class CancelAdminController {

	@Autowired
	private CancelAdminService service;

	@GetMapping("/cancelList")
	public Map<String, Object> canceladminlist(OrderDetailVO vo) {
		return service.list(vo);
	}

	@PutMapping("/approveCancel/{orderDetailNo}")
	public String approveCancel(@PathVariable int orderDetailNo) {
		int r = service.approveCancel(orderDetailNo);
		return r == 1 ? "취소승인" : "오류";
	}

	@PutMapping("/refuseCancel/{orderDetailNo}")
	public String refuseCancel(@PathVariable int orderDetailNo) {
		int r = service.refuseCancel(orderDetailNo);
		return r == 1 ? "취소거절" : "오류";
	}

	@PutMapping("/completeCancel/{orderDetailNo}")
	public String completeCancel(@PathVariable int orderDetailNo) {
		int r = service.completeCancel(orderDetailNo);
		return r == 1 ? "취소완료" : "오류";
	}

	@PutMapping("/adminCancel/{orderDetailNo}")
	public String adminCancel(@PathVariable int orderDetailNo, @RequestParam String reason) {
		int r = service.adminCancel(orderDetailNo, reason);
		return r == 1 ? "강제취소완료" : "오류";
	}
}