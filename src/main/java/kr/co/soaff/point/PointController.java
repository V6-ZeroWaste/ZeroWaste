package kr.co.soaff.point;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soaff.order.OrderVO;
import kr.co.soaff.user.UserVO;


@Controller
public class PointController {
	@Autowired
	PointService service;
	
	// point 리스트 ajax 처리
	@GetMapping("/point/getList")
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
			if(pointVo.getPoint()!=0){
				printList += "<tr>";
				printList += "<td style='color:" + (pointVo.getPoint() < 0 ? "red;'>사용":"blue;'>적립") + "</td>";
				printList += "<td style='color:" + (pointVo.getPoint() < 0 ? "red;'>":"blue;'>") + pointVo.getPoint() + "</td>";
				printList += "<td>" + pointVo.getContent() + "</td>";
				printList += "<td>" +( pointVo.getOrder_no() == 0 ? "" :pointVo.getOrder_no() )+ "</td>";
//       		printList += "<td>"+pointVo.getPoint_date()+"</td>";
				printList += "<td>"+(pointVo.getPoint_date()+"").substring(0, 10)+"</td>";
				printList += "<td><button class='btn btn-danger' point_no='"+pointVo.getPoint_no()+"' onclick='pointDelete(this);'>삭제</td>";
				printList += "</tr>";
			}
		}
		map.put("printList", printList);
		
		return map;
	}
	
	// point 삭제
	@PostMapping(value="/point/delete", produces = "application/tex; charset=utf8")
	@ResponseBody
	public String delete(@RequestBody PointVO vo) {
		String msg = "";
		if(service.delete(vo.getPoint_no())) {
			msg = "삭제 완료";
		}else {
			msg = "삭제 실패";
		}
		return msg;
	}
	
	
	// point 추가 페이지
	@GetMapping("/point/form")
	public String form(Model model, PointVO vo) {
		return "admin/user/pointForm";
	}
	// point 추가
	@PostMapping(value="/point/insert", produces = "application/text; charset=utf8")
	@ResponseBody
	public String insert(@RequestBody PointVO vo) {
		String msg = "";
		if(service.insert(vo)) {
			msg = "등록 완료";
		}else {
			msg = "등록 실패";
		}
		return msg;
	}
	
	

    @GetMapping("/mypage/point")
    public String pointReqForm(Model model, OrderVO orderVO) {
      return "/user/order/pointList";
    }
    
    @GetMapping("/mypage/point/list")
	@ResponseBody
	public Map<String, Object> userListAjax(PointVO vo, HttpSession session) {
    	vo.setUser_no((int) session.getAttribute("user_no"));
		Map<String, Object> map = service.list(vo);
		return map;
	}



}
