package kr.co.soaff.statistics.users;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

	@GetMapping("/getList")
	@ResponseBody
	public Map<String, Object> listAjax(UsersVO vo, Model model) {
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<UsersVO> usersList = (List<UsersVO>) map.get("usersList");
		List<UsersVO> leaveList = (List<UsersVO>) map.get("leaveList");

		for (int i = 0; i < leaveList.size(); i++) {
			System.out.print(usersList.get(i).getDate()+" /// "+usersList.get(i).getUser_cnt()+" /// ");
			System.out.println(leaveList.get(i).getLeave_cnt());
			printList += "<tr class='itemRow'>";
			printList += "<td class=\"col-sales-date\">" + leaveList.get(i).getDate() + "</td>";
			printList += "<td class=\"col-sales-sales\">" + usersList.get(i).getUser_cnt() + "</td>";
			printList += "<td class=\"col-sales-sales\">" + leaveList.get(i).getLeave_cnt() + "</td>";
			printList += "</tr>";

		}
		map.put("printList", printList);
		model.addAttribute("map", service.list(vo));
		return map;
	}

}
