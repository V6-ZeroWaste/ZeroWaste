package kr.co.soaff.qna;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class QnaController {

    @Autowired
    private QnaService service;

    @GetMapping("/qna/index")
    public String index(Model model, QnaVO vo) {
        model.addAttribute("map", service.list(vo));
        return "qna/index";
    }

    @GetMapping("/qna/detail")
    public String detail(Model model, @RequestParam int qna_no) {
        QnaVO vo = new QnaVO();
        vo.setQna_no(qna_no);
        model.addAttribute("vo", service.detail(vo));
        return "qna/detail";
    }

    @PostMapping("/qna/deleteContent")
    @ResponseBody
    public String deleteContent(@RequestParam int qna_no) {
        int result = service.deleteContent(qna_no);
        return result > 0 ? "success" : "failure";
    }

    @PostMapping("/qna/updateReply")
    @ResponseBody
    public String updateReply(@RequestParam int qna_no, @RequestParam String reply) {
        QnaVO vo = new QnaVO();
        vo.setQna_no(qna_no);
        vo.setReply(reply);
        int result = service.updateReply(vo);
        return result > 0 ? "success" : "failure";
    }

    @PostMapping("/qna/deleteReply")
    @ResponseBody
    public String deleteReply(@RequestParam int qna_no) {
        int result = service.deleteReply(qna_no);
        return result > 0 ? "success" : "failure";
    }
}
