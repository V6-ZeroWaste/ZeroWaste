package kr.co.soaff.statistics.items;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soaff.review.ReviewVO;

@Controller
@RequestMapping("/admin/statistics/items")
public class ItemsController {
	@Autowired
	private ItemsService service;

	@GetMapping("/index")
	public String index() {
		return "/admin/statistics/items";
	}
	
	@GetMapping("/getList")
	@ResponseBody
	public Map<String, Object> listAjax(ItemsVO vo){
		System.out.println(vo);
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<ItemsVO> itemList = (List<ItemsVO>) map.get("list");
		if (itemList.size() == 0) {
			printList = "<td class='first' colspan='8' style='text-align: center;'>등록된 글이 없습니다.</td>";
		} 
		for(ItemsVO itemsVo: itemList) {
			printList += "<tr>"; 
			printList += "<td onclick=\"location.href='/admin/item/detail?item_no="+ itemsVo.getItem_no() + "'\">" + itemsVo.getItem_no() + "</td>";
			printList += "<td>" +itemsVo.getName()+"</td>";
       		printList += "<td>" + itemsVo.getOrder() + "</td>";
       		printList += "<td>" + itemsVo.getSales() + "</td>";
       		printList += "<td>" + itemsVo.getCancel() + "</td>";
       		printList += "<td>" + Math.round(itemsVo.getCancel_rate()*10)/10.0 + " %</td>";
       		printList += "<td>" + itemsVo.getRevenue() + " 원</td>";
       		printList += "</tr>";
		}
		map.put("printList", printList);
		return map;
	}

}
