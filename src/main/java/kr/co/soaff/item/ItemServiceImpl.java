package kr.co.soaff.item;

import kr.co.soaff.review.ReviewAdminMapper;
import kr.co.soaff.review.ReviewUserMapper;
import kr.co.soaff.review.ReviewVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ItemServiceImpl implements ItemService{
    @Autowired
    ItemMapper itemMapper;

    @Autowired
    ReviewUserMapper reviewUserMapper;

    @Override
    public Map<String, Object> list(ItemVO vo) {
        Map<String, Object> map = new HashMap<String, Object>();

        int totalCount = itemMapper.count(vo); // 총 게시물 수
        int totalPage = totalCount / 12;
        if (totalCount % 12 > 0)
            totalPage++;

        // 시작인덱스
        int startIdx = (vo.getPage() - 1) * 12;
        vo.setStartIdx(startIdx); // sql문에 파라미터로 넣어줌
        List<ItemVO> list = itemMapper.list(vo); // 목록

        // 페이징처리
        int endPage = (int) (Math.ceil(vo.getPage() / 10.0) * 10); // 끝페이지
        int startPage = endPage - 9; // 시작페이지

        if (endPage > totalPage)
            endPage = totalPage;
        boolean prev = startPage > 1;
        boolean next = endPage < totalPage;

        map.put("total", totalCount);
        map.put("totalPage", totalPage);
        map.put("items", list); // 모델에 직접 넣어줘도 됨

        map.put("endPage", endPage);
        map.put("startPage", startPage);
        map.put("prev", prev);
        map.put("next", next);
        return map;
    }

    @Override
    public ItemVO detail(ItemVO vo) {
        return itemMapper.detail(vo);
    }

    @Override
    public int count(ItemVO vo) {
        return itemMapper.count(vo);
    }

    public List<CategoryVO> categories() {
        return itemMapper.categories();
    }
}
