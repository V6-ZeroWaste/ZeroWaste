package kr.co.soaff.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface ReviewUserMapper {
	List<ReviewVO> list(ReviewVO vo);
	int count (ReviewVO vo);
}
