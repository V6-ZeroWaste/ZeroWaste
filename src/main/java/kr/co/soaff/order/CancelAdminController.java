package kr.co.soaff.order;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin")
public class CancelAdminController {
	
	@Autowired
	private CancelAdminService service;
	
	@GetMapping("/cancellist")
	public Map<String,Object> canceladminlist(OrderDetailVO vo) {
		return service.list(vo);
	}
	
}
