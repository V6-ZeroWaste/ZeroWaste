package kr.co.soaff.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soaff.item.ItemVO;
import kr.co.soaff.review.ReviewVO;

@Service
public class QnaServiceImpl implements QnaService {
	@Autowired
	QnaMapper mapper;

	@Override
	public Map<String, Object> list(QnaVO vo) {
		Map<String, Object> map = new HashMap<>();
		int pageSize = 10;
		int count = mapper.count(vo);
		map.put("count", count);

		int totalPage = count / pageSize;
		if (count % pageSize > 0) {
			totalPage++;
		}
		map.put("totalPage", totalPage);

		int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;

		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		map.put("currentPage", vo.getPage());

		vo.setStartIdx((vo.getPage() - 1) * pageSize);
		List<QnaVO> list = mapper.list(vo);
		if (list != null && !list.isEmpty()) {
			for (QnaVO qnaVO : list) {
				qnaVO.setReplyState(qnaVO.getReply_date() != null ? "답변 완료" : "답변 대기");
			}
		}
		map.put("list", list);

		return map;
	}

	@Override
	public QnaVO detail(QnaVO vo) {
		QnaVO data = mapper.detail(vo);
		return data;
	}

	@Override
	public int update(QnaVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(int qna_no) {
		return mapper.delete(qna_no);
	}

	@Override
	public ItemVO write(ItemVO vo) {
		return mapper.write(vo);
	}

	@Override
	public int post(QnaVO vo) {
		vo.setTitle(vo.getTitle().trim());
		vo.setContent(vo.getContent().trim());
		vo.setType(vo.getType());
		return mapper.post(vo);
	}

}
