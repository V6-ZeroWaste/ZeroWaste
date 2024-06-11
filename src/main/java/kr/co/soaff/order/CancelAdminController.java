package kr.co.soaff.order;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class CancelAdminController {

	@Autowired
	private CancelAdminService service;

//    @GetMapping("/cancelAdminList")
//    public Map<String, Object> cancelAdminList(CancelAdminListVO vo) {
//        return service.list(vo);
//    }

	@GetMapping("cancel/list")
	public String index(Model model, CancelAdminListVO vo) {
		model.addAttribute("map", service.list(vo));
		return "admin/cancel/list";
	}

//    @GetMapping("/cancelDetail/{order_detail_no}")
//    public Map<String, Object> cancelDetail(@PathVariable int order_detail_no) {
//        return service.cancelDetail(order_detail_no);
//    }

	@GetMapping("/cancel/{order_detail_no}")
	public String cancelDetail(@PathVariable int order_detail_no, Model model) {
		Map<String, Object> cancelDetail = service.cancelDetail(order_detail_no);
		model.addAttribute("cancelDetail", cancelDetail.get("cancelDetail"));
		return "admin/cancel/detail"; // JSP 파일 이름
	}

	@PostMapping("/cancel/approve/{order_detail_no}")
	public ResponseEntity<Map<String, String>> approveCancel(@PathVariable int order_detail_no) {
		int r = service.approveCancel(order_detail_no);
		Map<String, String> response = new HashMap<>();
		if (r == 1) {
			response.put("status", "success");
			response.put("message", "승인 완료");
		} else {
			response.put("status", "error");
			response.put("message", "오류");
		}
		return ResponseEntity.ok(response);
	}

	@PostMapping("/cancel/refuse/{order_detail_no}")
	public ResponseEntity<Map<String, String>> refuseCancel(@PathVariable int order_detail_no) {
		int r = service.refuseCancel(order_detail_no);
		Map<String, String> response = new HashMap<>();
		if (r == 1) {
			response.put("status", "success");
			response.put("message", "거절 완료");
		} else {
			response.put("status", "error");
			response.put("message", "오류");
		}
		return ResponseEntity.ok(response);
	}

	@PostMapping("/completeCancel/{order_detail_no}")
	public String completeCancel(@PathVariable int order_detail_no) {
		int r = service.completeCancel(order_detail_no);
		return r == 1 ? "취소완료" : "오류";
	}

	@PostMapping("/cancel/force/{order_detail_no}")
	public ResponseEntity<Map<String, String>> forceCancel(@PathVariable int order_detail_no,
			@RequestParam String cancel_reason_detail) {
		int r = service.adminCancel(order_detail_no, cancel_reason_detail);
		Map<String, String> response = new HashMap<>();
		if (r == 1) {
			response.put("status", "success");
			response.put("message", "강제 취소 완료");
		} else {
			response.put("status", "error");
			response.put("message", "오류");
		}
		return ResponseEntity.ok(response);
	}
	
	@GetMapping("/cancel/force/{order_detail_no}")
	public String forceDetail(@PathVariable int order_detail_no, Model model) {
		Map<String, Object> forceDetail = service.forceDetail(order_detail_no);
		model.addAttribute("forceDetail", forceDetail.get("forceDetail"));
		return "admin/cancel/force"; // JSP 파일 이름
	}
}
