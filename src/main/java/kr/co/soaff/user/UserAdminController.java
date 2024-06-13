package kr.co.soaff.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/user")
public class UserAdminController {

	@Autowired
	private UserAdminService service;

	// 회원 상세 페이지
	@GetMapping("/list")
	public String list(Model model, UserVO vo) {
		return "admin/user/list";
	}

	// 회원 상세 페이지 - 리스트 불러오기 (ajax)
	@GetMapping("/getList")
	@ResponseBody
	public Map<String, Object> listAjax(UserVO vo) {
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<UserVO> userList = (List<UserVO>) map.get("list");
		if (userList.size() == 0) {
			printList = "<td class='first' colspan='5' style='text-align: center;'>검색 결과가 없습니다.</td>";
		}
		for (UserVO userVo : userList) {
			printList += "<tr onclick=\"location.href='/admin/user/detail?user_no=" + userVo.getUser_no() + "'\">";
			printList += "<td>" + userVo.getUser_no() + "</td>";
			printList += "<td>" + userVo.getId() + "</td>";
			printList += "<td>" + userVo.getName() + "</td>";
			printList += "<td>" + userVo.getTel() + "</td>";
			printList += "<td>" + userVo.getEmail() + "</td>";
			printList += "</tr>";
		}
		map.put("printList", printList);
		return map;
	}

	@GetMapping("detail")
	public String detail(Model model, UserVO vo) {
		model.addAttribute("user", service.detail(vo));
		return "admin/user/detail";
	}

	@PostMapping(value = "/update", produces = "application/text; charset=utf8")
	@ResponseBody()
	public String update(@RequestBody UserVO vo) {

		String msg = "";
		if (service.update(vo)) {
			msg = "수정 완료";
		} else {
			msg = "수정 실패";
		}
		return msg;
	}

}
