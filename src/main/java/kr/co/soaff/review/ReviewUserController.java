package kr.co.soaff.review;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user/review")
public class ReviewUserController {
	@Autowired
	private ReviewUserService service;

	@GetMapping("/list")
	public String index(Model model, ReviewVO vo) {
		model.addAttribute("map", service.list(vo));
		return "/user/review/list";
	}

	// 회원 상세 페이지 - 리스트 불러오기 (ajax)
	@GetMapping("/getList") // Do: 회원가입 id 중복 체크
	@ResponseBody
	public Map<String, Object> listAjax(ReviewVO vo) {
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<ReviewVO> reviewList = (List<ReviewVO>) map.get("list");
		if (reviewList.size() == 0) {
			printList = "<td class='first' colspan='8' style='text-align: center;'>등록된 글이 없습니다.</td>";
		}
		for (ReviewVO reviewVo : reviewList) {
			printList += "<tr onclick=\"location.href='/user/review/detail?review_no=" + reviewVo.getReview_no()
					+ "'\">";
			printList += "<td>"
					+ (reviewVo.getReview_img() == null ? "" : ("<img src='" + reviewVo.getReview_img() + "'/>"))
					+ "</td>";
			printList += "<td>" + reviewVo.getItem_name() + "</td>";
			printList += "<td>" + reviewVo.getUser_id() + "</td>";
			printList += "<td>" + reviewVo.getTitle() + "</td>";
			printList += "<td>" + (reviewVo.getRegist_date() + "").substring(0, 10) + "<br>"
					+ (reviewVo.getRegist_date() + "").substring(11, 19) + "</td>";
			printList += "<td>" + reviewVo.getScore() + "</td>";
			printList += "</tr>";
		}
		map.put("printList", printList);
		return map;
	}
	
	@GetMapping("/detail")
	public String reply(Model model, ReviewVO vo) {
		model.addAttribute("vo", service.detail(vo));
		return "/user/review/detail";
	}
	
	// 리뷰등록페이지 입장하는 버튼
	@GetMapping("write")
	public String write() {
		return "user/review/write";
	}
	
	
	
}
