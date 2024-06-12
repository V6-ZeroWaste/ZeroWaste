package kr.co.soaff.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user/qna")
public class QnaUserController {
	@Autowired
	private QnaUserService service;
	
	@GetMapping("/list")
	public String index(Model model, QnaVO vo) {
		model.addAttribute("map", service.list(vo));
		return "/user/qna/list";
	}

	// 회원 상세 페이지 - 리스트 불러오기 (ajax)
	@GetMapping("/getList") // Do: 회원가입 id 중복 체크
	@ResponseBody
	public Map<String, Object> listAjax(QnaVO vo) {
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<QnaVO> qnaList = (List<QnaVO>) map.get("list");
		if (qnaList.size() == 0) {
			printList = "<td class='first' colspan='8' style='text-align: center;'>등록된 글이 없습니다.</td>";
		}
		for (QnaVO qnaVO : qnaList) {
			printList += "<tr onclick=\"location.href='/user/qna/detail?qna_no=" + qnaVO.getQna_no()
					+ "'\">";
			printList += "<td>"
					+ (qnaVO.getQna_img() == null ? "" : ("<img src='" + qnaVO.getQna_img() + "'/>"))
					+ "</td>";
			printList += "<td>" + qnaVO.getItem_name() + "</td>";
			printList += "<td>" + qnaVO.getTitle() + "</td>";
			printList += "<td>" + qnaVO.getUser_id() + "</td>";
			
			printList += "<td>" + (qnaVO.getQuestion_date() + "").substring(0, 10) + "<br>"
					+ (qnaVO.getQuestion_date() + "").substring(11, 19) + "</td>";
			printList += "<td>" + qnaVO.getReplyState() + "</td>";
			printList += "</tr>";
		}
		map.put("printList", printList);
		return map;
	}
	
	@GetMapping("/detail")
	public String reply(Model model, QnaVO vo) {
		model.addAttribute("vo", service.detail(vo));
		return "/user/qna/detail";
	}
}
