package kr.co.soaff.item;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface ItemAdminService {

	List<ItemVO> list(ItemVO vo);

	ItemVO detail(ItemVO vo);

	int insert(ItemVO vo, MultipartFile file, HttpServletRequest request);

	int update(ItemVO vo);

	int delete(int item_no);

	int count(ItemVO vo);
}
