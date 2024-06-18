package kr.co.soaff.review;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import util.S3Uploader;

@Controller
@RequestMapping("/mypage/review")
public class ReviewController {
	@Autowired
	private ReviewService service;

//	@Autowired
//	private S3Uploader s3Uploader;

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
			printList += "<td>" + reviewVo.getTitle() + "</td>";
			printList += "<td>" + reviewVo.getUser_id() + "</td>";
			printList += "<td>" + (reviewVo.getRegist_date() + "").substring(0, 10) + "<br>"
					+ (reviewVo.getRegist_date() + "").substring(11, 19) + "</td>";
			printList += "<td>" + reviewVo.getScore() + "</td>";
			printList += "</tr>";
		}
		map.put("printList", printList);
		return map;
	}

	@GetMapping("/detail")
	public String detail(Model model, ReviewVO vo) {
		model.addAttribute("vo", service.detail(vo));
		return "/user/review/detail";
	}

	@GetMapping("/update")
	public String detail2(Model model, ReviewVO vo) {
		model.addAttribute("vo", service.detail(vo));
		return "/user/review/update";
	}

	@GetMapping("/post")
	public String write(Model model, ReviewVO vo) {
		return "/user/review/post";
	}

//	@PostMapping("/postReview")
//	public String post(@RequestParam String title, String content, int score,
//			@RequestParam(required = false) String review_img, Model model) {
//		ReviewVO vo = new ReviewVO();
//		vo.setTitle(title);
//		vo.setContent(content);
//		vo.setScore(score);
//		vo.setReview_img(review_img);
//
//		int result = service.post(vo);
//
//		if (result > 0) {
//			return "redirect:/user/review/list";
//		} else {
//			model.addAttribute("error", "리뷰 작성에 실패했습니다.");
//			return "/user/review/post";
//		}
//	}
/*
	@PostMapping("/postReview")
	public String post(@RequestParam String title, @RequestParam String content, @RequestParam int score,
			@RequestParam(required = false) MultipartFile review_img, Model model) {
		ReviewVO vo = new ReviewVO();
		vo.setTitle(title);
		vo.setContent(content);
		vo.setScore(score);

		if (review_img != null && !review_img.isEmpty()) {
			try {
				String imgUrl = s3Uploader.uploadFile(review_img);
				vo.setReview_img(imgUrl);
			} catch (IOException e) {
				model.addAttribute("error", "이미지 업로드에 실패했습니다.");
				return "/user/review/post";
			}
		}

		int result = service.post(vo);

		if (result > 0) {
			return "redirect:/user/review/list";
		} else {
			model.addAttribute("error", "리뷰 작성에 실패했습니다.");
			return "/user/review/post";
		}
	}
	*/

	@PostMapping("/delete")
	@ResponseBody
	public int delete(@RequestParam int review_no) {
		int result = service.delete(review_no);
		return result;
	}

}
