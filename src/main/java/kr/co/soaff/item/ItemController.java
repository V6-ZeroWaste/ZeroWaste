package kr.co.soaff.item;

import java.util.List;
import java.util.Map;

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
		}
		vo.setCategory_name(itemService.getCategoryName(category_no));
		model.addAttribute("map", itemService.list(vo));
		model.addAttribute("item", vo);
		model.addAttribute("categories", itemService.categories());
		return "user/item/list";
	}

	@GetMapping("/getItemList")
	@ResponseBody
	public Map<String, Object> getItemList(Model model, ItemVO vo) {
		Map<String, Object> map = itemService.list(vo);
		String printList = "";
		List<ItemVO> itemList = (List<ItemVO>) map.get("items");
		for (ItemVO item : itemList) {
			printList += "<div class='col-6 col-lg-3'>";
			printList += "<div class='product'>";
			printList += "<figure class='product-image'>";
			printList += "<a href='detail?item_no=" + item.getItem_no() + "'>";
			printList += "<img src='/upload/item_img/" + item.getItem_img() + "' alt='Image'>";
			printList += "</a>";
			printList += "</figure>";
			printList += "<div class='product-meta'>";
			printList += "<h3 class='product-title'><a href='detail?item_no=" + item.getItem_no() + "'>"
					+ item.getName() + "</a></h3>";
			printList += "<div class='product-price'>";
			if (item.getDiscount_rate() != 0) {
				printList += "<span><s class='text-muted'>" + item.getPrice() + "원 </s>&nbsp</span>";
			}
			printList += "<span>" + item.getDiscounted_price() + "원</span>";
			printList += "<span class='product-action'>";
			printList += "<a href='#!'>Add to cart</a>";
			printList += "</span>";
			printList += "</div>";
			printList += "</div>";
			printList += "</div>";
			printList += "</div>";
		}
		map.put("printList", printList);
		model.addAttribute("categories", itemService.categories());
		return map;
	};

	@GetMapping("/detail")
	public String detail(Model model, ItemVO vo) {
		model.addAttribute("item", itemService.detail(vo));
		return "user/item/detail";
	}

	@GetMapping("/getReviewList")
	@ResponseBody
	public Map<String, Object> getReviewList(ReviewVO vo) {
		Map<String, Object> map = itemService.reviewList(vo);
		List<ReviewVO> reviewList = (List<ReviewVO>) map.get("reviews");
		String printList = "";
		if (!reviewList.isEmpty()) {
			for (ReviewVO review : reviewList) {
				printList += "<div class='row gutter-2 gutter-lg-4 mb-0'>";
				printList += "<div class='col-md-12 d-flex justify-content-center align-items-center text-center' style='width: 100%;'>";
				printList += "<div class='accordion accordion-minimal' id='review-" + review.getReview_no()
						+ "' style='width: 100%; margin: 0;'>";
				printList += "<div class='card'>";
				printList += "<div class='card-header' id='review-heading-" + review.getReview_no() + "'>";
				printList += "<h5 class='mb-0'>";
				printList += "<button class='btn btn-link' type='button' data-toggle='collapse' data-target='#review-detail-"
						+ review.getReview_no() + "' aria-expanded='false' aria-controls='review-detail-"
						+ review.getReview_no() + "' style='padding-bottom: 0;'>";
				printList += "<div class='row w-100 align-items-center'>";
				printList += "<div class='col-2'>";
				printList += "<span class='rating'>";
				for (int i = 0; i < review.getScore(); i++) {
					printList += "⭐";
				}
				printList += "</span>";
				if (review.getReview_img() != null && review.getReview_img().isEmpty()) {
					printList += "<span class='photo-status'>\uD83D\uDDBC\uFE0F\uFE0F</span>";
				}
				printList += "</div>";
				printList += "<div class='col-6 review-title' >";
				printList += review.getTitle();
				printList += "</div>";
				printList += "<div class='col-2 user-id'>";
				printList += review.getUser_id();
				printList += "</div>";
				printList += "<div class='col-2 date'>";
				printList += review.getRegist_date();
				printList += "</div>";
				printList += "</div>";
				printList += "</button>";
				printList += "</h5>";
				printList += "</div>";
				printList += "<div id='review-detail-" + review.getReview_no()
						+ "' class='collapse' aria-labelledby='review-heading-" + review.getReview_no()
						+ "' data-parent='#review-" + review.getReview_no() + "' style='background: #fafafa;'>";
				printList += "<div class='card-body text-left content-box'>";
				if (review.getReview_img() != null && review.getReview_img().isEmpty()) {
					printList += "<img src='/upload/review_img/" + review.getReview_img() + "'>";
				}
				printList += "<p>" + review.getContent() + "</p>";
				printList += "</div>";
				printList += "</div>";
				printList += "</div>";
				printList += "</div>";
				printList += "</div>";
				printList += "</div>";
			}
		} else {
			printList += "<div class='row gutter-2 gutter-lg-4 mb-0'>";
			printList += "<div class='col-md-12 d-flex justify-content-center align-items-center text-center' style='width: 100%;'>";
			printList += "아직 작성된 리뷰가 없습니다.";
			printList += "</div>";
			printList += "</div>";
		}

		map.put("printList", printList);
		return map;
	}
}
