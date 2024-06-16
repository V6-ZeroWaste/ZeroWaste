package kr.co.soaff.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.net.http.HttpRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	ItemService itemService;

	@GetMapping("/list")
	public String item(Model model, ItemVO vo) {
		model.addAttribute("map", itemService.list(vo));
		model.addAttribute("item",vo);
		model.addAttribute("categories", itemService.categories());
		return "user/item/list";
	}

	@GetMapping("/getItemList")
	@ResponseBody
	public Map<String, Object> getItemList(Model model, ItemVO vo) {
		Map<String, Object> map = itemService.list(vo);
		String printList = "";
		List<ItemVO> itemList = (List<ItemVO>) map.get("items");
		for (ItemVO item : itemList) {
			printList += "<div class='col-6 col-lg-3'>";
			printList += "<div class='product'>";
			printList += "<figure class='product-image'>";
			printList += "<a href='detail?item_no=" + item.getItem_no() + "'>";
			printList += "<img src='/upload/item_img/" + item.getItem_img() + "' alt='Image'>";
			printList += "</a>";
			printList += "</figure>";
			printList += "<div class='product-meta'>";
			printList += "<h3 class='product-title'><a href='detail?item_no=" + item.getItem_no() + "'>" + item.getName() + "</a></h3>";
			printList += "<div class='product-price'>";
			if(item.getDiscount_rate()!=0){
				printList += "<span><s class='text-muted'>" + item.getPrice() + "원 </s>&nbsp</span>";
			}
			printList += "<span>" + item.getDiscounted_price() + "원</span>";
			printList += "<span class='product-action'>";
			printList += "<a href='#!'>Add to cart</a>";
			printList += "</span>";
			printList += "</div>";
			printList += "</div>";
			printList += "</div>";
			printList += "</div>";
		}
		map.put("printList", printList);
		model.addAttribute("categories", itemService.categories());
		return map;
	};


	@GetMapping("/detail")
	public String detail(Model model, ItemVO vo) {
		model.addAttribute("item", itemService.detail(vo));
		return "user/item/detail";
	}
}
