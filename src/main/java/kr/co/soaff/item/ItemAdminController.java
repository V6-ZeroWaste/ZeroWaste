package kr.co.soaff.item;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ItemAdminController {

	@Autowired
	private ItemAdminService service;

	@GetMapping("/admin/item/index")
	public String index(Model model, HttpServletRequest request, ItemVO vo) {
		model.addAttribute("map", service.index(vo));
		request.setAttribute("item", vo);
		String[] categories = service.categories();
		request.setAttribute("categories", categories);
		return "admin/item/index";
	}

	@GetMapping("/admin/item/detail")
	public String detail(HttpServletRequest request, ItemVO vo) {
		ItemVO item = service.detail(vo);
		String[] categories = service.categories();
		request.setAttribute("item", item);
		request.setAttribute("categories", categories);
		return "admin/item/detail";
	}

	@GetMapping("/admin/item/regist")
	public String regist(HttpServletRequest request, ItemVO vo) {
		String[] categories = service.categories();
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
		return "redirect:index";
	}

	@PostMapping("/admin/item/update")
	public String upadteItem(HttpServletRequest request, ItemVO vo, @RequestParam("file") MultipartFile detail)
			throws IOException {
		System.out.println(vo);
		service.update(vo, detail, request);
		ItemVO vo2 = service.detail(vo);
		return "redirect:detail?item_no=" + vo.getItem_no();
	}

	@PostMapping("/admin/item/delete")
	public String delete(HttpServletRequest request, int itemNo) throws IOException {
		ItemVO tmp = new ItemVO();
		tmp.setItem_no(itemNo);
		ItemVO vo = service.detail(tmp);
		service.delete(vo, request);
		return "redirect:index";
	}

	@PostMapping("/admin/item/deleteImg")
	public String deleteImg(HttpServletRequest request, int itemNo) throws IOException {
		ItemVO tmp = new ItemVO();
		tmp.setItem_no(itemNo);
		ItemVO vo = service.detail(tmp);
		service.deleteImg(vo, request);
		return "redirect:detail?item_no=" + vo.getItem_no();
	}

}
