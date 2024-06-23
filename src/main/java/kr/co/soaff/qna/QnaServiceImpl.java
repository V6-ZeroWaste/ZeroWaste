package kr.co.soaff.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soaff.item.ItemVO;

@Service
public class QnaServiceImpl implements QnaService {
	@Autowired
	QnaMapper mapper;

	@Override
	public Map<String, Object> list(QnaVO vo) {
	    int count = mapper.count(vo);
	    int totalPage = count / 20;
	    if (count % 20 > 0) totalPage++;
	    List<QnaVO> list = mapper.list(vo); // 목록

	    Map<String, Object> map = new HashMap<>();
	    map.put("count", count);
	    map.put("totalPage", totalPage);
	    map.put("list", list);

	    int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10);
	    int startPage = endPage - 9;
	    if (endPage > totalPage) endPage = totalPage;
	    boolean isPrev = startPage > 1;
	    boolean isNext = endPage < totalPage;
	    map.put("endPage", endPage);
	    map.put("startPage", startPage);
	    map.put("isPrev", isPrev);
	    map.put("isNext", isNext);
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
	public ItemVO write(int item_no) {
		return mapper.write(item_no);
	}
	
	@Override
	public int post(QnaVO vo) {
		vo.setTitle(vo.getTitle().trim());
	    vo.setContent(vo.getContent().trim());
		return mapper.post(vo);
	}
		
}
