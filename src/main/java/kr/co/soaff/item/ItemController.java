package kr.co.soaff.item;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/item")
public class ItemController {

	@GetMapping("/list")
	public String item() {
		return "user/item/list";
	}

	@GetMapping("/detail")
	public String detail() {
		return "user/item/detail";
	}
}
