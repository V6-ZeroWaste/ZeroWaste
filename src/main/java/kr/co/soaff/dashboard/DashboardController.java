package kr.co.soaff.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {
	@Autowired
	private DashboardService service;

	@GetMapping(value = { "/admin/dashboard/index", "/admin" })
	public String index(Model model) {

		model.addAttribute("vo", service.count());

		return "/admin/dashboard/index";
	}

}
