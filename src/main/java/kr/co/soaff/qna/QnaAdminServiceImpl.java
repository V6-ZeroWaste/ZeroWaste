package kr.co.soaff.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaAdminServiceImpl implements QnaAdminService {
    @Autowired
    private QnaAdminMapper mapper;

    @Override
    public Map<String, Object> list(QnaVO vo) {
        int startIdx = (vo.getPage()-1) * 20;
        vo.setStartIdx(startIdx);
        List<QnaVO> list = mapper.list(vo);
        int count = mapper.count(vo);
        int totalPage = count / 20;
        if (count % 20 > 0) totalPage++;
        
        Map<String, Object> map = new HashMap<>();
        map.put("total", count);
        map.put("totalPage", totalPage);
        map.put("list", list);

        int endPage = (int) (Math.ceil(vo.getPage() / 15.0) * 15);
        int startPage = endPage - 14;
        if (endPage > totalPage) endPage = totalPage;
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;
        map.put("endPage", endPage);
        map.put("startPage", startPage);
        map.put("prev", prev);
        map.put("next", next);

        return map;
    }

    @Override
    public QnaVO detail(int qna_no) {
        return mapper.detail(qna_no);
    }

    @Override
    public int deleteContent(int qna_no) {
        return mapper.deleteContent(qna_no);
    }

    @Override
    public int updateReply(QnaVO vo) {
        return mapper.updateReply(vo);
    }

    @Override
    public int deleteReply(int qna_no) {
        return mapper.deleteReply(qna_no);
    }
}
