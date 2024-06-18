package kr.co.soaff.review;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReviewItemMapper {
    List<ReviewVO> list(ReviewVO vo);
    int count (ReviewVO vo);
    Double avgScore (ReviewVO vo);
}
