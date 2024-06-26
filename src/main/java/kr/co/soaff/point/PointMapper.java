package kr.co.soaff.point;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PointMapper {
	List<PointVO> list(PointVO vo);
	int insert(PointVO vo);
	int delete(int point_no);
	int count(PointVO vo);
	int total(PointVO vo);
	List<PointVO> userList(PointVO vo);
	int userCount(PointVO vo);
}
