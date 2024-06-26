package kr.co.soaff.qna;

import java.util.Map;

public interface QnaAdminService {
    Map<String, Object> list(QnaVO vo);
    QnaVO detail(int qna_no);
    int deleteContent(int qna_no);
    int updateReply(QnaVO vo);
    int deleteReply(int qna_no);
}
