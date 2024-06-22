package kr.co.soaff.item;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.soaff.qna.QnaVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soaff.review.ReviewVO;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	ItemService itemService;

	@GetMapping("/list")
	public String item(Model model, ItemVO vo, @RequestParam(required = false) Integer category_no) {
		if(category_no!=null && !category_no.equals(0)){
			vo.setFilter(String.valueOf(category_no));
			vo.setCategory_name(itemService.getCategoryName(category_no));
		}
		model.addAttribute("map", itemService.list(vo));
		model.addAttribute("item", vo);
		return "user/item/list";
	}

	@GetMapping("/getItemList")
	@ResponseBody
	public Map<String, Object> getItemList(ItemVO vo) {
		return itemService.list(vo);
	};

	@GetMapping("/detail")
	public String detail(Model model, ItemVO vo) {
		if(itemService.detail(vo)==null){
			return "user/include/404";
		}else{
			model.addAttribute("item", itemService.detail(vo));
			return "user/item/detail";
		}
	}

	@GetMapping("/getReviewList")
	@ResponseBody
	public Map<String, Object> getReviewList(ReviewVO vo) {
        return itemService.reviewList(vo);
	}

	@GetMapping("/getQnaList")
	@ResponseBody
	public Map<String, Object> getQnaList(QnaVO vo) {
		Map<String, Object> map = itemService.qnaList(vo);
		return map;
	}

	public String getFormattedQuestionDate(Timestamp time) {
		Date questionDate = new Date(time.getTime());
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		return formatter.format(questionDate);
	}
}
