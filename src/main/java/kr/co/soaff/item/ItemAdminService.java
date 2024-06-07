package kr.co.soaff.item;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface ItemAdminService {

	List<ItemVO> list(ItemVO vo);

	ItemVO detail(ItemVO vo);

	int insert(ItemVO vo, MultipartFile file, HttpServletRequest request);

	int update(ItemVO vo, MultipartFile file, HttpServletRequest request);

	int delete(ItemVO vo, HttpServletRequest request);

	public int deleteImg(ItemVO vo, HttpServletRequest request);

	public Map<String, Object> index(ItemVO vo);

	int count(ItemVO vo);

	public String[] categories();
}
