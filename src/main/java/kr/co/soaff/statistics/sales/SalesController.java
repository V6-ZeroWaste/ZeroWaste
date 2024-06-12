package kr.co.soaff.statistics.sales;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/statistics/sales")
public class SalesController {
	@Autowired
	private SalesService service;

	@GetMapping("/index")
	public String list(Model model, HttpServletRequest request, SalesVO vo) {
		model.addAttribute("map", service.list(vo));
		model.addAttribute("vo", vo);
		return "/admin/statistics/sales";
	}

	@GetMapping("/getList")
	@ResponseBody
	public Map<String, Object> listAjax(SalesVO vo, Model model) {
		System.out.println(vo.getStart_date());
		System.out.println(vo.getEnd_date());
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<SalesVO> list = (List<SalesVO>) map.get("list");
		for (SalesVO sales : list) {
			printList += "<tr class='itemRow'>";
			printList += "<td class=\"col-sales-date\">" + sales.getDate() + "</td>";
			printList += "<td class=\"col-sales-sales\">" + sales.getSales() + "</td>";
			printList += "</tr>";
		}
		map.put("printList", printList);
		model.addAttribute("map", service.list(vo));
		return map;
	}

}
