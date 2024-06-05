package kr.co.soaff.item;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
	public int insert(ItemVO vo, MultipartFile file, HttpServletRequest request) {
		// TODO 상품 추가 시 할인률 등 가격 변동사항 반영
		String org = file.getOriginalFilename();
		String ext = org.substring(org.lastIndexOf("."));
		String real = System.currentTimeMillis() + ext;
		String path = request.getRealPath("/upload/board/") + real;

		try {
			file.transferTo(new File(path));
		} catch (Exception e) {
		}

		vo.setItem_img(real);

		vo.setDiscounted_price(vo.getPrice() * (1 - (vo.getDiscount_rate() / 100)));

		int r = mapper.insert(vo);
		return r;
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
