package kr.co.soaff.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class CancelAdminController {

	@Autowired
	private CancelAdminService service;

	@GetMapping("cancel/list")
	public String index(Model model, CancelAdminListVO vo) {
		model.addAttribute("map", service.list(vo));
		return "admin/cancel/list";
	}

	@GetMapping("/cancel/{order_detail_no}")
	public String cancelDetail(@PathVariable int order_detail_no, Model model) {
		Map<String, Object> cancelDetail = service.cancelDetail(order_detail_no);
		model.addAttribute("cancelDetail", cancelDetail.get("cancelDetail"));
		return "admin/cancel/detail"; // JSP 파일 이름
	}
	
	@GetMapping("/cancel/getList")
	@ResponseBody
	public Map<String, Object> list(CancelAdminListVO cancelAdminListVO) {
	    // 기본 정렬 설정
	    if (cancelAdminListVO.getOrderBy() == null || cancelAdminListVO.getOrderBy().isEmpty()) {
	        cancelAdminListVO.setOrderBy("오래된순");
	    }

	    Map<String, Object> map = service.list(cancelAdminListVO);
	    String printList = "";
	    List<CancelAdminListVO> cancelList = (List<CancelAdminListVO>) map.get("list");
	    if (cancelList.size() == 0) {
	        printList = "<td class='first' colspan='10' style='text-align: center;'>등록된 글이 없습니다.</td>";
	    }
	    for (CancelAdminListVO vo : cancelList) {
	        printList += "<tr>";
	        printList += "<td onclick=location.href='/admin/cancel/" + vo.getOrder_detail_no() + "'>" + vo.getOrder_no() + "</td>";
	        String cancelRequestDate = (vo.getCancel_request_date() != null) ? (vo.getCancel_request_date() + "").substring(0, 19) : "";
	        String cancelApproveDate = (vo.getCancel_approve_date() != null) ? (vo.getCancel_approve_date() + "").substring(0, 19) : "";
	        
	        printList +="<td>" +vo.getOrder_detail_no() + "</td>";
	        printList += "<td>" + vo.getItem_name() + "</td>";
	        printList += "<td>" + vo.getUser_id() + "</td>";
	        printList += "<td>" + vo.getAmount() + "</td>";
	        printList += "<td>" + vo.getPrice() + "</td>";
	        printList += "<td>" + cancelRequestDate + "</td>";
	        printList += "<td>" + (cancelApproveDate.isEmpty() ? "" : cancelApproveDate) + "</td>";
	        String cancel_status = "";
	        if (vo.getCancel_status() ==  null && vo.getCancel_request_date() != null) {
	            cancel_status = "취소 거절";
	        } else if (vo.getCancel_status() == 1) {
	            cancel_status = "취소 승인";
	        } else if (vo.getCancel_status() == 2) {
	            cancel_status = "취소 완료";
	        } else if (vo.getCancel_status() == 0) {
	            cancel_status = "취소 요청";
	        }
	        printList += "<td>" + cancel_status + "</td>";
	        printList += "</tr>";
	    }

	    map.put("printList", printList);
	    map.put("page", cancelAdminListVO.getPage());
	    map.put("totalPage", map.get("totalPage"));
	    map.put("count", map.get("count"));
	    map.put("startPage", map.get("startPage"));
	    map.put("endPage", map.get("endPage"));
	    map.put("isPrev", map.get("isPrev"));
	    map.put("isNext", map.get("isNext"));
	    return map;
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
