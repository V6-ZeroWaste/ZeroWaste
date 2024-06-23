package kr.co.soaff.qna;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soaff.item.ItemVO;
import util.S3Uploader;

@Controller
@RequestMapping("/mypage/qna")
public class QnaController {
	@Autowired
	private QnaService service;

	@Autowired
	private S3Uploader s3Uploader;

	@GetMapping("/list")
	public String index(Model model, QnaVO vo) {
		model.addAttribute("map", service.list(vo));
		return "/user/qna/list";
	}

	@GetMapping("/getList")
	@ResponseBody
	public Map<String, Object> listAjax(QnaVO vo) {
		Map<String, Object> map = service.list(vo);
		String printList = "";
		List<QnaVO> qnaList = (List<QnaVO>) map.get("list");
		if (qnaList.size() == 0) {
			printList = "<td class='first' colspan='5' style='text-align: center;'>등록된 글이 없습니다.</td>";
		}
		for (QnaVO qnaVO : qnaList) {
			printList += "<tr onclick=\"location.href='/user/qna/detail?qna_no=" + qnaVO.getQna_no() + "'\">";
			printList += "<td>" + (qnaVO.getQna_img() == null ? "" : ("<img src='" + qnaVO.getQna_img() + "'/>"))
					+ "</td>";
			printList += "<td>" + qnaVO.getItem_name() + "</td>";
			printList += "<td>" + qnaVO.getTitle() + "</td>";
			printList += "<td>" + qnaVO.getUser_id() + "</td>";
			printList += "<td>" + qnaVO.getQuestion_date() + "</td>";


			if (qnaVO.getReply_date() != null) {
				qnaVO.setReplyState("답변 완료");
				printList += "<td>" + qnaVO.getReplyState() + "</td>";
			} else {
				qnaVO.setReplyState("답변 대기");
				printList += "<td>" + qnaVO.getReplyState() + "</td>";
			}

			printList += "</tr>";
		}
		map.put("printList", printList);
		return map;
	}

	@GetMapping("/detail")
	public String detail(Model model, QnaVO vo) {
		model.addAttribute("vo", service.detail(vo));
		return "/user/qna/detail";
	}

	@GetMapping("/update")
	public String detail2(Model model, QnaVO vo) {
		model.addAttribute("vo", service.detail(vo));
		return "/user/qna/update";
	}

	@PostMapping("/updateQna")
	@ResponseBody
	public int updateQna(@RequestParam int qna_no, @RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam(value = "qna_img", required = false) MultipartFile qna_img) {
		QnaVO vo = new QnaVO();
		vo.setQna_no(qna_no);
		vo.setTitle(title);
		vo.setContent(content);

		QnaVO existingQna = service.detail(vo);
		String oldQnaImgUrl = existingQna.getQna_img();

		if (qna_img != null && !qna_img.isEmpty()) {
			try {
				String newImgUrl = s3Uploader.updateFile(oldQnaImgUrl, qna_img);
				vo.setQna_img(newImgUrl);
			} catch (IOException e) {
				e.printStackTrace();
				return 0;
			}
		} else {
			vo.setQna_img(oldQnaImgUrl);
		}
		int result = service.update(vo);
		return result > 0 ? 1 : 0;
	}

	@PostMapping("/delete")
	@ResponseBody
	public int delete(@RequestParam int qna_no) {
		QnaVO vo = new QnaVO();
		vo.setQna_no(qna_no);
		QnaVO qna = service.detail(vo);

		String qnaImgUrl = qna.getQna_img();
		int result = service.delete(qna_no);
		if (result > 0 && qnaImgUrl != null && !qnaImgUrl.isEmpty()) {
			try {
				s3Uploader.deleteFile(qnaImgUrl);
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}

		return result;
	}

//	@GetMapping("/post")
//	public String write(Model model, @RequestParam int item_no) {
//		ItemVO vo = new ItemVO();
//		model.addAttribute("vo", service.write(vo));
//		return "/user/qna/post";
//	}
	
	@GetMapping("/post")
	public String write(Model model, @RequestParam int item_no) {
	    ItemVO vo = service.write(item_no); // 서비스에서 item 정보를 가져오는 메서드 호출
	    model.addAttribute("vo", vo);
	    return "/user/qna/post";
	}


	@PostMapping("/postQna")
	@ResponseBody
	public String post(@RequestParam("title") String title, @RequestParam("content") String content,
	                   @RequestParam(value = "qna_img", required = false) MultipartFile qna_img,
	                   @RequestParam("item_no") int item_no, Model model) {

	    // 전달된 파라미터 값 로그 출력
	    System.out.println("Received item_no: " + item_no);

	    int user_no = 1;
	    String user_id = "user01";
	    QnaVO vo = new QnaVO();
	    vo.setTitle(title.trim());
	    vo.setContent(content.trim());
	    vo.setUser_no(user_no);
	    vo.setUser_id(user_id);
	    vo.setItem_no(item_no);

	    if (qna_img != null && !qna_img.isEmpty()) {
	        try {
	            String imgUrl = s3Uploader.uploadFile(qna_img);
	            vo.setQna_img(imgUrl);
	        } catch (IOException e) {
	            model.addAttribute("error", "이미지 업로드에 실패했습니다.");
	            System.out.println("문의 등록 요청 실패: " + System.currentTimeMillis());
	            return "0";
	        }
	    } else {
	        vo.setQna_img(null);
	    }

	    int result = service.post(vo);

	    if (result > 0) {
	        return "1";
	    } else {
	        return "0";
	    }
	}

}