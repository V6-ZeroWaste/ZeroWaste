package kr.co.soaff.point;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soaff.user.UserVO;


@Controller
public class PointController {
	@Autowired
	PointService service;
	
	// point 리스트 ajax 처리
	@GetMapping("/point/list.do")
	@ResponseBody
	public Map<String, Object> listAjax(PointVO vo) {
		Map<String, Object> map = service.list(vo);
		map.put("totalPoint", service.total(vo));
		List<PointVO> pointList = (List<PointVO>) map.get("list");
		String printList = "";
		if (pointList.size() == 0) {
			printList = "<td class='first' colspan='6' style='text-align: center;'>검색 결과가 없습니다.</td>";
		} 
		for(PointVO pointVo: pointList) {
			printList += "<tr>";
			printList += "<td style='color:" + (pointVo.getPoint() < 0 ? "red;'>사용":"blue;'>적립") + "</td>";
       		printList += "<td style='color:" + (pointVo.getPoint() < 0 ? "red;'>":"blue;'>") + pointVo.getPoint() + "</td>";
       		printList += "<td>" + pointVo.getContent() + "</td>";
       		printList += "<td>" +( pointVo.getOrder_no() == 0 ? "" :pointVo.getOrder_no() )+ "</td>";
//       		printList += "<td>"+pointVo.getPoint_date()+"</td>";
       		printList += "<td>"+(pointVo.getPoint_date()+"").substring(0, 10)+"</td>";
       		printList += "<td><button class='btn btn-danger' point_no='"+pointVo.getPoint_no()+"' onclick=''>삭제</td>";
       		printList += "</tr>";
		}
		map.put("printList", printList);
		
		return map;
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
