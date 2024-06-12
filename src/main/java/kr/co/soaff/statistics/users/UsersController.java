package kr.co.soaff.statistics.users;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/statistics/users")
public class UsersController {
	@Autowired
	private UsersService service;

	@GetMapping("/index")
	public String login(Model model, UsersVO vo) {
		model.addAttribute("map", service.list(vo));
		model.addAttribute("vo", vo);
		return "/admin/statistics/users";
	}

//	@GetMapping("/getList")
//	@ResponseBody
//	public Map<String, Object> listAjax(UsersVO vo, Model model) {
//		Map<String, Object> map = service.list(vo);
//		String printList = "";
//		List<SalesVO> list = (List<SalesVO>) map.get("list");
//
//		for (SalesVO sales : list) {
//			printList += "<tr class='itemRow'>";
//			printList += "<td class=\"col-sales-date\">" + sales.getDate() + "</td>";
//			printList += "<td class=\"col-sales-sales\">" + sales.getSales() + "</td>";
//			printList += "</tr>";
//		}
//		map.put("printList", printList);
//		model.addAttribute("map", service.list(vo));
//		return map;
//	}

}
