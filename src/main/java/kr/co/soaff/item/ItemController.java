package kr.co.soaff.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	ItemService itemService;

	@GetMapping("/list")
	public String item(Model model, ItemVO vo) {
		model.addAttribute("map", itemService.list(vo));
		model.addAttribute("item",vo);
		return "user/item/list";
	}

	@GetMapping("/detail")
	public String detail(Model model, ItemVO vo) {
		model.addAttribute("item", itemService.detail(vo));
		return "user/item/detail";
	}
}
