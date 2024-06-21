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
	public String index(Model model, ItemVO vo) {
		model.addAttribute("map", service.index(vo));
		model.addAttribute("item", vo);
		return "admin/item/list";
	}

	@GetMapping("/admin/item/getList")
	@ResponseBody
	public Map<String, Object> listAjax(ItemVO vo) {
        return service.index(vo);
	}

	@GetMapping("/admin/item/detail")
	public String detail(Model model, ItemVO vo) {
		ItemVO item = service.detail(vo);
		model.addAttribute("item", item);
		return "admin/item/detail";
	}

	@GetMapping("/admin/item/regist")
	public String regist() {
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
	public String deleteImg(int itemNo){
		String msg = "";
		ItemVO tmp = new ItemVO();
		tmp.setItem_no(itemNo);
		ItemVO vo = service.detail(tmp);
		if (service.deleteImg(vo) != 0) {
			msg = "삭제 완료";
		} else {
			msg = "삭제 실패";
		}
		return msg;
	}

	@PostMapping(value = "/admin/item/deleteNewImg", produces = "application/tex; charset=utf8")
	@ResponseBody
	public String deleteNewImg(String imgUrl) throws IOException {
		service.deleteNewImg(imgUrl);
		return "삭제 완료";
	}

	@GetMapping("/admin/item/category")
	public String category() throws IOException {
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

	@PostMapping("/admin/item/uploadItemImg")
	@ResponseBody
	public String uploadItemImgAjax(@RequestParam("file") MultipartFile file)  {
		return service.uploadItemImgAjax(file);
	};

}
