package kr.co.soaff.qna;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QnaItemMapper {
    List<QnaVO> list(QnaVO vo);
    QnaVO detail(QnaVO vo);
    int count (QnaVO vo);
}
