package kr.co.soaff.statistics.items;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ItemsMapper {
	List<ItemsVO> list(ItemsVO vo);
	int count (ItemsVO vo);
}
