package kr.co.soaff.common;

import kr.co.soaff.item.CategoryVO;
import kr.co.soaff.item.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private ItemService itemService;

    @ModelAttribute
    public void addCategoriesToModel(Model model) {
        List<CategoryVO> categories = itemService.categories();
        model.addAttribute("categories", categories);
    }
}
