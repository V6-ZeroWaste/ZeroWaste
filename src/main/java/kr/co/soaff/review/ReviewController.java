package kr.co.soaff.review;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

	@Autowired
	private S3Uploader s3Uploader;

	@GetMapping("/list")
	public String index(Model model, ReviewVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("map", service.list(vo));
		return "/user/review/list";
	}

	@GetMapping("/getList")
	@ResponseBody
	public Map<String, Object> listAjax(ReviewVO vo, HttpSession session) {
		Integer user_no = (Integer) session.getAttribute("user_no");
		if (user_no == null) {
			return null;
		}
		vo.setUser_no(user_no);
		vo.setPageSize(10);
		vo.setStartIdx((vo.getPage() - 1) * vo.getPageSize());
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<ReviewVO> reviewList = (List<ReviewVO>) map.get("list");
		if (reviewList.size() == 0) {
			printList = "<td class='first' colspan='8' style='text-align: center;'>등록된 글이 없습니다.</td>";
		} else {
			for (ReviewVO reviewVo : reviewList) {
				String title = reviewVo.getTitle();
				if (title.length() > 10) {
					title = title.substring(0, 10) + "...";
				}
				printList += "<tr onclick=\"location.href='/user/review/detail?review_no=" + reviewVo.getReview_no()
						+ "'\">";
				printList += "<td>"
						+ (reviewVo.getReview_img() == null ? "" : ("<img src='" + reviewVo.getReview_img() + "'/>"))
						+ "</td>";
				printList += "<td>" + reviewVo.getItem_name() + "</td>";
				printList += "<td>" + title + "</td>";
				printList += "<td>" + reviewVo.getUser_id() + "</td>";
				printList += "<td>" + reviewVo.getRegist_date().toString().substring(0, 10) + "<br>"
						+ reviewVo.getRegist_date().toString().substring(11, 19) + "</td>";
				printList += "<td>" + reviewVo.getScore() + "</td>";
				printList += "</tr>";
			}
		}
		map.put("printList", printList);
		return map;
	}

	@GetMapping("/detail")
	public String detail(Model model, ReviewVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("vo", service.detail(vo));
		return "/user/review/detail";
	}

	@GetMapping("/post")
	public String write(Model model, @RequestParam Integer item_no, @RequestParam Integer order_detail_no, HttpSession session) {
	    Integer user_no = (Integer) session.getAttribute("user_no");
	    if (user_no == null) {
	        return "/user/include/404"; 
	    }

	    ReviewVO vo = new ReviewVO();
	    vo.setItem_no(item_no);
	    vo.setOrder_detail_no(order_detail_no);
	    vo.setUser_no(user_no);

	    boolean isOrderValid = service.checkOrder(vo);
	    if (!isOrderValid) {
	        return "/user/include/404"; 
	    }

	    ReviewVO existingOrder = service.write(vo);
	    model.addAttribute("vo", existingOrder);
	    return "/user/review/post";
	}

	@PostMapping("/postReview")
	@ResponseBody
	public String post(@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam("score") int score,
			@RequestParam(value = "review_img", required = false) MultipartFile review_img,
			@RequestParam("order_no") int order_no, @RequestParam("order_detail_no") int order_detail_no,
			@RequestParam("item_no") int item_no, Model model, HttpSession session) {

		Integer user_no = (Integer) session.getAttribute("user_no");
		String user_id = (String) session.getAttribute("user_id");
		ReviewVO vo = new ReviewVO();

		vo.setTitle(title.trim());
		vo.setContent(content.trim());
		vo.setScore(score);
		vo.setUser_no(user_no);
		vo.setUser_id(user_id);
		vo.setOrder_no(order_no);
		vo.setOrder_detail_no(order_detail_no);
		vo.setItem_no(item_no);
		vo.setExposed_status(1);

		if (review_img != null && !review_img.isEmpty()) {
			try {
				String imgUrl = s3Uploader.uploadFile(review_img);
				vo.setReview_img(imgUrl);
			} catch (IOException e) {
				model.addAttribute("error", "이미지 업로드에 실패했습니다.");
				System.out.println("리뷰 등록 요청 실패: " + System.currentTimeMillis());
				return "0";
			}
		} else {
			vo.setReview_img(null);
		}

		int result = service.post(vo);

		if (result > 0) {
			return "1";
		} else {
			return "0";
		}
	}



	@GetMapping("/update")
	public String detail2(Model model, ReviewVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("vo", service.detail(vo));
		return "/user/review/update";
	}

	@PostMapping("/updateReview")
	@ResponseBody
	public int updateReview(@RequestParam int review_no, @RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam(value = "review_img", required = false) MultipartFile review_img, HttpSession session) {
		Integer user_no = (Integer) session.getAttribute("user_no");
		ReviewVO vo = new ReviewVO();
		vo.setReview_no(review_no);
		vo.setTitle(title.trim());
		vo.setContent(content.trim());

		ReviewVO existingReview = service.detail(vo);
		String oldReviewImgUrl = existingReview.getReview_img();

		if (review_img != null && !review_img.isEmpty()) {
			try {
				String newImgUrl = s3Uploader.updateFile(oldReviewImgUrl, review_img);
				vo.setReview_img(newImgUrl);
			} catch (IOException e) {
				e.printStackTrace();
				return 0;
			}
		} else {
			vo.setReview_img(oldReviewImgUrl);
		}

		int result = service.update(vo);
		return result > 0 ? 1 : 0;
	}

	@PostMapping("/delete")
	@ResponseBody
	public int delete(@RequestParam int review_no, HttpSession session) {
		Integer user_no = (Integer) session.getAttribute("user_no");
		ReviewVO vo = new ReviewVO();
		vo.setReview_no(review_no);
		ReviewVO review = service.detail(vo);

		String reviewImgUrl = review.getReview_img();
		int result = service.delete(review_no);

		if (result > 0 && reviewImgUrl != null && !reviewImgUrl.isEmpty()) {
			try {
				s3Uploader.deleteFile(reviewImgUrl);
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}

		return result;
	}
}