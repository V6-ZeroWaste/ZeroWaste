package kr.co.soaff.user;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class UserAdminController {
	
	@Autowired
	private UserAdminService service;

	// 회원 상세 페이지
	@GetMapping("/user/list")
	public String list(Model model, UserVO vo) {
		return "admin/user/list";
	}
	
	// 회원 상세 페이지 - 리스트 불러오기 (ajax)  
	@GetMapping("/user/list.do") // Do:  회원가입 id 중복 체크
	@ResponseBody
	public Map<String, Object> idCheck(UserVO vo){
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<UserVO> userList = (List<UserVO>) map.get("list");
		if (userList.size() == 0) {
			printList = "<td class='first' colspan='5' style='text-align: center;'>등록된 글이 없습니다.</td>";
		} 
		for(UserVO userVo: userList) {
			printList += "<tr onclick=\"location.href='/admin/user/detail?user_no="+ userVo.getUser_no() + "'\">";
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
	
	
	@GetMapping("/user/detail")
	public String detail(Model model, UserVO vo) {
		model.addAttribute("user", service.detail(vo));
		return "admin/user/detail";
	}
	
	@PostMapping("/user/update")
	public String update(Model model, UserVO vo) {
		if(service.update(vo)) {
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "/user/detail");
		}else{
			model.addAttribute("msg", "오류: 관리자에게 문의하세요.");
			model.addAttribute("url", "/user/detail");	
		}
		return "common/alert";
	}
	
}