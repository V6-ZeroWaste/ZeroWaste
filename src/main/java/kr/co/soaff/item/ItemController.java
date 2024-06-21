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
		Map<String, Object> map = itemService.list(vo);
		String printList = "";
		List<ItemVO> itemList = (List<ItemVO>) map.get("items");
		DecimalFormat format = new DecimalFormat("###,###");
		for (ItemVO item : itemList) {
			printList += "<div class='col-6 col-lg-3'>";
			printList += "<div class='product'>";
			printList += "<figure class='product-image'>";
			printList += "<a href='detail?item_no=" + item.getItem_no() + "'>";
			printList += "<img src='" + item.getItem_img() + "' alt='Image'>";
			printList += "</a>";
			printList += "</figure>";
			printList += "<div class='product-meta'>";
			printList += "<h3 class='product-title'><a href='detail?item_no=" + item.getItem_no() + "'>"
					+ item.getName();
			if (item.getDiscount_rate() != 0) {
				printList += "&nbsp;&nbsp;<span class='text-red text-sm-center'>"+ item.getDiscount_rate() +"%</span>";
			}
			printList += "</a></h3>";
			printList += "<div class='product-price'>";
			if (item.getDiscount_rate() != 0) {
				printList += "<span><s class='text-muted'>" + format.format(item.getPrice()) + "원 </s>&nbsp</span>";
			}
			printList += "<span>" + format.format(item.getDiscounted_price()) + "원</span>";
			printList += "</div>";
			printList += "</div>";
			printList += "</div>";
			printList += "</div>";
		}
		map.put("printList", printList);
		return map;
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
