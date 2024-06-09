package kr.co.soaff.review;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	@GetMapping("/review/index")
	public String index(Model model, ReviewVO vo) {
		model.addAttribute("map", service.list(vo));
		return "review/index";
	}
	
	@GetMapping("/review/detail")
	public String reply(Model model,@RequestParam int review_no) {
		ReviewVO vo = new ReviewVO();
		vo.setReview_no(review_no);
		model.addAttribute("vo", service.detail(vo));
		return "/review/detail";
	}
	
	@PostMapping("/review/updateStatus")
    @ResponseBody
    public String updateStatus(@RequestParam int review_no, @RequestParam int exposed_status) {
        ReviewVO vo = new ReviewVO();
        vo.setReview_no(review_no);
        vo.setExposed_status(exposed_status);
        int result = service.updateStatus(vo);
        return result > 0 ? "성공" : "실패";
    }
	
	
}
