package kr.co.soaff.statistics.items;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/statistics/items")
public class ItemsController {
	@Autowired
	private ItemsService service;

	@GetMapping("/index")
	public String login() {
		return "/admin/login";
	}

}
