package kr.co.soaff.point;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class PointController {
	@Autowired
	PointService service;
	
	// point 리스트 ajax 처리
	@GetMapping("/point/list.do")
	@ResponseBody
	public Map<String, Object> list(PointVO vo) {
		return service.list(vo);
	}
	
	// point 삭제
	@PostMapping("/point/list")
	public String delete(Model model, PointVO vo) {
		if(service.delete(vo.getPoint_no())) {
			model.addAttribute("msg", "추가되었습니다.");
			model.addAttribute("url", "/user/detail");
		}else{
			model.addAttribute("msg", "오류: 관리자에게 문의하세요.");
			model.addAttribute("url", "/user/detail");	
		}
		return "common/alert";
	}
	
	// point 추가
	@PostMapping("/point/form")
	public String insert(Model model, PointVO vo) {
		if(service.insert(vo)) {
			model.addAttribute("msg", "추가되었습니다.");
			model.addAttribute("url", "/user/detail");
		}else{
			model.addAttribute("msg", "오류: 관리자에게 문의하세요.");
			model.addAttribute("url", "/user/detail");	
		}
		return "common/alert";
	}

}
