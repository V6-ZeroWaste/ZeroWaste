package kr.co.soaff.item;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ItemAdminController {

	@Autowired
	private ItemAdminService service;

	@GetMapping("/admin/item/list")
	public String index(Model model, HttpServletRequest request, ItemVO vo) {
		model.addAttribute("map", service.index(vo));
		request.setAttribute("item", vo);
		List<CategoryVO> categories = service.categories();
		request.setAttribute("categories", categories);
		return "admin/item/list";
	}

	@GetMapping("/admin/item/getList")
	@ResponseBody
	public Map<String, Object> listAjax(HttpServletRequest request, ItemVO vo) {
		Map<String, Object> map = service.index(vo);
		String printList = "";
		List<ItemVO> itemList = (List<ItemVO>) map.get("items");
		for (ItemVO item : itemList) {
			printList += "<tr class='itemRow' onclick=\"location.href='/admin/item/detail?item_no=" + item.getItem_no()
					+ "'\">";
			printList += "<td class=\"col-item-no\">" + item.getItem_no() + "</td>";

			printList += "<td class=\"col-item-img\">";
			printList += "<div class='img-container'>";
			printList += "<img src='/upload/item_img/" + item.getItem_img() + "' class='fixed-size-img'/>";
			printList += "</div>";
			printList += "</td>";

			printList += "<td class=\"col-item-name\">" + item.getName() + "</td>";
			printList += "<td class=\"col-item-price\">" + item.getPrice() + "</td>";

			printList += "<td class=\"col-item-discount\">";
			printList += item.getDiscounted_price();
			printList += item.getDiscount_rate() == 0 ? "(-)" : "(" + item.getDiscount_rate() + "%)";
			printList += "</td>";

			printList += "<td class=\"col-item-category\">" + item.getCategory_name() + "</td>";
			printList += "<td class=\"col-item-amount\">" + item.getAmount() + "</td>";

			printList += "<td class=\"col-item-exposed\">";
			printList += item.isExposed_status() ? "O" : "X";
			printList += "</td>";
			printList += "</tr>";
		}

		List<CategoryVO> categories = service.categories();
		request.setAttribute("categories", categories);
		map.put("printList", printList);
		return map;
	}

	@GetMapping("/admin/item/detail")
	public String detail(HttpServletRequest request, ItemVO vo) {
		System.out.println(vo);
		ItemVO item = service.detail(vo);
		List<CategoryVO> categories = service.categories();
		request.setAttribute("item", item);
		request.setAttribute("categories", categories);
		return "admin/item/detail";
	}

	@GetMapping("/admin/item/regist")
	public String regist(HttpServletRequest request, ItemVO vo) {
		List<CategoryVO> categories = service.categories();
		request.setAttribute("categories", categories);
		return "admin/item/regist";
	}

	@PostMapping("/admin/item/regist")
	public String registItem(HttpServletRequest request, ItemVO vo, @RequestParam("file") MultipartFile detail)
			throws IOException {
		int result = service.insert(vo, detail, request);
		if (result == 0) {
			return "redirect:detail?item_no=" + vo.getItem_no();
		}
		return "redirect:list";
	}

	@PostMapping("/admin/item/update")
	public String upadteItem(HttpServletRequest request, ItemVO vo, @RequestParam("file") MultipartFile detail)
			throws IOException {
		service.update(vo, detail, request);
		ItemVO vo2 = service.detail(vo);
		return "redirect:detail?item_no=" + vo.getItem_no();
	}

	@PostMapping(value = "/admin/item/delete", produces = "application/tex; charset=utf8")
	@ResponseBody
	public String delete(HttpServletRequest request, int itemNo) throws IOException {
		String msg = "";
		ItemVO tmp = new ItemVO();
		tmp.setItem_no(itemNo);
		ItemVO vo = service.detail(tmp);
		if (service.delete(vo, request) != 0) {
			msg = "삭제 완료";
		} else {
			msg = "삭제 실패";
		}
		return msg;
	}

	@PostMapping(value = "/admin/item/deleteImg", produces = "application/tex; charset=utf8")
	@ResponseBody
	public String deleteImg(HttpServletRequest request, int itemNo) throws IOException {
		String msg = "";
		ItemVO tmp = new ItemVO();
		tmp.setItem_no(itemNo);
		ItemVO vo = service.detail(tmp);
		if (service.deleteImg(vo, request) != 0) {
			msg = "삭제 완료";
		} else {
			msg = "삭제 실패";
		}
		return msg;
	}

	@GetMapping("/admin/item/category")
	public String category(Model model) throws IOException {
		List<CategoryVO> categories = service.categories();
		model.addAttribute("categories", categories);
		return "admin/item/category";
	}

	@PostMapping(value = "/admin/item/category/fix", produces = "application/tex; charset=utf8")
	@ResponseBody
	public String fixCategory(@RequestBody CategoryVO vo) throws IOException {
		String msg = "";
		if (service.updateCategory(vo) != 0) {
			msg = "수정 완료";
		} else {
			msg = "수정 실패";
		}
		return msg;
	}

	@PostMapping(value = "/admin/item/category/delete", produces = "application/tex; charset=utf8")
	@ResponseBody
	public String deleteCategory(@RequestBody CategoryVO vo) throws IOException {
		String msg = "";
		if (service.deleteCategory(vo.getCategory_no()) != 0) {
			msg = "삭제 완료";
		} else {
			msg = "삭제 실패";
		}
		return msg;
	}

	@PostMapping(value = "/admin/item/category/insert", produces = "application/tex; charset=utf8")
	@ResponseBody
	public String insertCategory(@RequestBody CategoryVO vo) throws IOException {
		String msg = "";
		if (service.insertCategory(vo) != 0) {
			msg = "추가 완료";
		} else {
			msg = "추가 실패";
		}
		return msg;
	}

}
