package kr.co.soaff.qna;

import java.util.Map;

public interface QnaService {
    Map<String, Object> list(QnaVO vo);
    QnaVO detail(QnaVO vo);
    int deleteContent(int qna_no);
    int updateReply(QnaVO vo);
    int deleteReply(int qna_no);
}
