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

    @GetMapping("/cancelAdminList")
    public Map<String, Object> cancelAdminList(CancelAdminListVO vo) {
        return service.list(vo);
    }

    @GetMapping("/cancelDetail/{order_detail_no}")
    public Map<String, Object> cancelDetail(@PathVariable int order_detail_no) {
        return service.cancelDetail(order_detail_no);
    }

    @PutMapping("/approveCancel/{order_detail_no}")
    public String approveCancel(@PathVariable int order_detail_no) {
        int r = service.approveCancel(order_detail_no);
        return r == 1 ? "취소승인" : "오류";
    }

    @PutMapping("/refuseCancel/{order_detail_no}")
    public String refuseCancel(@PathVariable int order_detail_no) {
        int r = service.refuseCancel(order_detail_no);
        return r == 1 ? "취소거절" : "오류";
    }

    @PutMapping("/completeCancel/{order_detail_no}")
    public String completeCancel(@PathVariable int order_detail_no) {
        int r = service.completeCancel(order_detail_no);
        return r == 1 ? "취소완료" : "오류";
    }

    @PutMapping("/adminCancel/{order_detail_no}")
    public String adminCancel(@PathVariable int order_detail_no, @RequestParam String reason) {
        int r = service.adminCancel(order_detail_no, reason);
        return r == 1 ? "강제취소완료" : "오류";
    }
}
