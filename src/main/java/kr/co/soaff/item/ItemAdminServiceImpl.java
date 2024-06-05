package kr.co.soaff.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ItemAdminServiceImpl implements ItemAdminService {

	@Autowired
	private ItemAdminMapper mapper;

	@Override
	public List<ItemVO> list(ItemVO vo) {
		return mapper.list(vo);
	}

	@Override
	public ItemVO detail(ItemVO vo) {
		return mapper.detail(vo);
	}

	@Override
	public int insert(ItemVO vo) {
		// TODO 상품 추가 시 할인률 등 가격 변동사항 반영
		return mapper.insert(vo);
	}

	@Override
	public int update(ItemVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(int item_no) {
		return mapper.delete(item_no);
	}

	@Override
	public int count(ItemVO vo) {
		return mapper.count(vo);
	}

}
