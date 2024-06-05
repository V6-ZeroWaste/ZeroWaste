package kr.co.soaff.item;

import java.util.List;

public interface ItemAdminService {

	List<ItemVO> list(ItemVO vo);

	ItemVO detail(ItemVO vo);

	int insert(ItemVO vo);

	int update(ItemVO vo);

	int delete(int item_no);

	int count(ItemVO vo);
}
