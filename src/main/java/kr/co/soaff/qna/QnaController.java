package kr.co.soaff.qna;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
	public String index(Model model, QnaVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("map", service.list(vo));
		return "/user/qna/list";
	}

	@GetMapping("/getList")
	@ResponseBody
	public Map<String, Object> listAjax(QnaVO vo, HttpSession session) {
		Integer user_no = (Integer) session.getAttribute("user_no");
		if (user_no == null) {
			return null;
		}
		vo.setUser_no(user_no);
		vo.setPageSize(10);
		Map<String, Object> map = service.list(vo);

		List<QnaVO> qnaList = (List<QnaVO>) map.get("list");
		if (qnaList.size() != 0) {
			for (QnaVO qnaVO : qnaList) {
				qnaVO.setReplyState(qnaVO.getReply_date() != null ? "답변 완료" : "답변 대기");

				String typeString = "";
				if (qnaVO.getType() == 0) {
					typeString = "교환/환불문의";
				} else if (qnaVO.getType() == 1) {
					typeString = "상품상세문의";
				}
				qnaVO.setTypeString(typeString);
			}
		}
		return map;
	}

	@GetMapping("/detail")
	public String detail(Model model, QnaVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("vo", service.detail(vo));
		return "/user/qna/detail";
	}

	@GetMapping("/update")
	public String detail2(Model model, QnaVO vo, HttpSession session) {
		vo.setUser_no((int) session.getAttribute("user_no"));
		model.addAttribute("vo", service.detail(vo));
		return "/user/qna/update";
	}

	@PostMapping("/updateQna")
	@ResponseBody
	public int updateQna(@RequestParam int qna_no, @RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam(value = "qna_img", required = false) MultipartFile qna_img, HttpSession session) {
		Integer user_no = (Integer) session.getAttribute("user_no");
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
	public int delete(@RequestParam int qna_no, HttpSession session) {
		Integer user_no = (Integer) session.getAttribute("user_no");
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

	@GetMapping("/post")
	public String write(Model model, @RequestParam int item_no) {
		ItemVO itemVo = new ItemVO();
		itemVo.setItem_no(item_no);
		ItemVO itemInfo = service.write(itemVo);

		QnaVO qnaVo = new QnaVO();
		qnaVo.setItem_no(item_no);
		qnaVo.setItem_name(itemInfo.getName());
		qnaVo.setItem_img(itemInfo.getItem_img());

		model.addAttribute("qnaVo", qnaVo);
		model.addAttribute("itemVo", itemInfo);
		return "/user/qna/post";
	}

	@PostMapping("/postQna")
	@ResponseBody
	public String post(@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam(value = "qna_img", required = false) MultipartFile qna_img,
			@RequestParam("item_no") int item_no, @RequestParam("type") String type, Model model, HttpSession session) {

		Integer user_no = (Integer) session.getAttribute("user_no");
		String user_id = (String) session.getAttribute("user_id");

		QnaVO vo = new QnaVO();
		vo.setTitle(title.trim());
		vo.setContent(content.trim());
		vo.setUser_no(user_no);
		vo.setUser_id(user_id);
		vo.setItem_no(item_no);
		if (type.equals("교환/환불문의")) {
			vo.setType(0);
		} else if (type.equals("상품상세문의")) {
			vo.setType(1);
		}

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
	//asdasdasdasdasdasdasdasd

}