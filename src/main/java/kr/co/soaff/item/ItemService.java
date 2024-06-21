package kr.co.soaff.item;

import kr.co.soaff.qna.QnaVO;
import kr.co.soaff.review.ReviewVO;

import java.util.List;
import java.util.Map;

public interface ItemService {
    Map<String, Object> list(ItemVO vo);
    ItemVO detail(ItemVO vo);
    int count(ItemVO vo);
    List<CategoryVO> categories();
    Map<String, Object> reviewList(ReviewVO vo);
    String getCategoryName(int category_no);
    Map<String, Object> qnaList(QnaVO vo);
}
