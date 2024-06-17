package kr.co.soaff.statistics.sales;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SalesMapper {
	List<SalesVO> list(SalesVO vo);

	int count(SalesVO vo);
}
