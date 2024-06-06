package kr.co.soaff.item;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ItemAdminMapper {
	List<ItemVO> list(ItemVO vo);

	ItemVO detail(ItemVO vo);

	int insert(ItemVO vo);

	int update(ItemVO vo);

	int delete(int item_no);

	int count(ItemVO vo);
}
