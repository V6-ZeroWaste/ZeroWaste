package kr.co.soaff.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class QnaAdminController {

    @Autowired
    private QnaAdminService service;

    @GetMapping("/admin/qna/list")
    public String list(Model model, QnaVO vo) {
        if (service.list(vo) == null) {
            return "admin/include/404";
        }
        model.addAttribute("map", service.list(vo));
        System.out.println(service.list(vo));
        return "admin/qna/list";
    }

    @GetMapping("/admin/qna/list.do")
    @ResponseBody
    public Map<String, Object> listAjax(QnaVO vo){
        return  service.list(vo);
    }

    @GetMapping("/admin/qna/detail")
    public String detail(Model model, @RequestParam int qna_no) {
        QnaVO detailVO = service.detail(qna_no);
       if (detailVO == null) {
           return "admin/include/404";
       }
       else {
           if (detailVO.getReply_date() != null) {
               detailVO.setReplyState("답변 완료");
           } else {
               detailVO.setReplyState("답변 대기");
           }
           model.addAttribute("vo", detailVO);
           return "admin/qna/detail";
       }
    }

    @PostMapping("/qna/deleteContent")
    @ResponseBody
    public int deleteContent(@RequestParam int qna_no) {
        int result = service.deleteContent(qna_no);
        return result > 0 ? 1 : 0;
    }

    @PostMapping("/qna/updateReply")
    @ResponseBody
    public int updateReply(@RequestParam int qna_no, @RequestParam String reply) {
        QnaVO vo = new QnaVO();
        vo.setQna_no(qna_no);
        vo.setReply(reply);
        int result = service.updateReply(vo);
        return result > 0 ? 1 : 0;
    }

    @PostMapping("/qna/deleteReply")
    @ResponseBody
    public int deleteReply(@RequestParam int qna_no) {
        int result = service.deleteReply(qna_no);
        return result > 0 ? 1 : 0;
    }
}
