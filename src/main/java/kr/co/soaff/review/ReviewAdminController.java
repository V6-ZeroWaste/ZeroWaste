package kr.co.soaff.review;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("/admin/review")
public class ReviewAdminController {
	
	@Autowired
	private ReviewAdminService service;
	
	@GetMapping("/list")
	public String index(Model model, ReviewVO vo) {
		model.addAttribute("map", service.list(vo));
		return "/admin/review/list";
	}
	
	// 회원 상세 페이지 - 리스트 불러오기 (ajax)  
		@GetMapping("/getList") // Do:  회원가입 id 중복 체크
		@ResponseBody
		public Map<String, Object> listAjax(ReviewVO vo){
			Map<String, Object> map = service.list(vo);
			String printList = "";
			List<ReviewVO> reviewList = (List<ReviewVO>) map.get("list");
			if (reviewList.size() == 0) {
				printList = "<td class='first' colspan='8' style='text-align: center;'>등록된 글이 없습니다.</td>";
			} 
			for(ReviewVO reviewVo: reviewList) {
				printList += "<tr onclick=\"location.href='/admin/review/detail?review_no="+ reviewVo.getReview_no() + "'\">";
				printList += "<td>" + reviewVo.getReview_no() + "</td>";
				printList += "<td>" + (reviewVo.getReview_img() == null ? "" : ("<img src='/upload/item_img/" + reviewVo.getReview_img() + "'/>"))+"</td>";
	       		printList += "<td>" + reviewVo.getItem_name() + "</td>";
	       		printList += "<td>" + reviewVo.getTitle() + "</td>";
	       		printList += "<td>" + reviewVo.getScore() + "</td>";
	       		printList += "<td>" + reviewVo.getCategory_name() + "</td>";
	       		printList += "<td>" + (reviewVo.getRegist_date()+"").substring(0, 10) + "<br>"+ (reviewVo.getRegist_date()+"").substring(11, 19) + "</td>";
	       		printList += "<td>" + (reviewVo.getExposed_status() == 0? "O":"X") + "</td>";
	       		printList += "</tr>";
			}
			map.put("printList", printList);
			return map;
		}
	
	@GetMapping("/detail")
	public String reply(Model model, ReviewVO vo) {
		model.addAttribute("vo", service.detail(vo));
		return "/admin/review/detail";
	}
	
	@PostMapping(value="/update", produces = "application/text; charset=utf8")
	@ResponseBody()
	public String update(@RequestBody ReviewVO vo) {
		
		String msg = "";
		if(service.updateStatus(vo) == 0) {
			msg = "수정 실패";
		}else {
			msg = "수정 완료";
		}
		return msg;
	}

	
	
}
