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
        model.addAttribute("map", service.list(vo));
        return "admin/qna/list";
    }
    
    @GetMapping("/admin/qna/list.do")
    @ResponseBody
    public Map<String, Object> listAjax(QnaVO vo){
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<QnaVO> qnaList = (List<QnaVO>) map.get("list");
		System.out.println(qnaList.toString());
		if (qnaList.size() == 0) {
			printList = "<td class='first' colspan='8' style='text-align: center;'>등록된 글이 없습니다.</td>";
		} 
		for(QnaVO QnaVO: qnaList) {
			printList += "<tr onclick=\"location.href='/admin/qna/detail?qna_no="+ QnaVO.getQna_no() + "'\">";
       		printList += "<td>" + QnaVO.getQna_no() + "</td>";
       		printList += "<td>" + QnaVO.getName() + "</td>";
       		printList += "<td>" + (QnaVO.getType() ==0 ? "교환/환불 문의" : "상품 상세 문의" ) + "</td>";
       		printList += "<td>" + QnaVO.getTitle() + "</td>";
       		printList += "<td>" + QnaVO.getUser_id() + "</td>";
       		printList += "<td>" + QnaVO.getQuestion_date() + "</td>";  
       		
       		if(QnaVO.getReply_date() != null) {
       			QnaVO.setReplyState("답변 완료"); 
       			printList += "<td>" + QnaVO.getReplyState() + "</td>";
       		}
       		else {
       			QnaVO.setReplyState("답변 대기");
       			printList += "<td>" + QnaVO.getReplyState() + "</td>";
       		}
       		
       		printList += "</tr>";
		}
		map.put("printList", printList);
		return map;
	}

    @GetMapping("/admin/qna/detail")
    public String detail(Model model, @RequestParam int qna_no) {
        QnaVO detailVO = service.detail(qna_no);
        if(detailVO.getReply_date() != null) {
        	detailVO.setReplyState("답변 완료"); 
        
   		}
   		else {
   			detailVO.setReplyState("답변 대기");
   		}
    	model.addAttribute("vo", detailVO);
        return "admin/qna/detail";
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
