package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.item.ItemAdminMapper;
import kr.co.soaff.item.ItemVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class ItemTest {

	@Autowired
	ItemAdminMapper mapper;

	@Test
	public void list() {
		ItemVO vo = new ItemVO();
		// 필터, 검색 x -> 성공
//		mapper.list(vo);
//
//		// 카테고리 필터 -> 성공
//		vo.setFilter("비누");
//		mapper.list(vo);
//
////		 검색 단어
////		vo.setSearchWord("비누");
////		mapper.list(vo);
//		// 재고량 많은 순
//		vo.setOrderBy("재고량많은순");
//		mapper.list(vo);
////		 재고량 적은 순
//		vo.setOrderBy("재고량적은순");
//		mapper.list(vo);
////		 등록 일자 순
//		vo.setOrderBy("등록일자순");
//		mapper.list(vo);
//		// 등록 일자 순
//		vo.setOrderBy("등록일자역순");
//		mapper.list(vo);

		// 제목 및 번호 검색
//		vo.setSearchWord("28");
		mapper.list(vo);
	}

	@Test
	public void detail() {
		ItemVO vo = new ItemVO();
		vo.setItem_no(2);
		ItemVO vo2 = mapper.detail(vo);
	}

	@Test
	public void insert() {
//		for (int i = 0; i < 30; i++) {
//			ItemVO vo = new ItemVO();
//			vo.setCategory_name("세안");
//			vo.setName("비누" + i);
//			vo.setDescription("비누" + i);
//			vo.setPrice(10000);
//			vo.setDiscount_rate(10);
//			vo.setDiscounted_price(vo.getPrice() * (1 - (vo.getDiscount_rate() / 100)));
//			vo.setAmount(i);
//			vo.setDetail("비누입니다");
//			// 아이템 이미지 들어가야할 자리
//			vo.setExposed_status(true);
//			vo.setPackable_option(true);
//			vo.setPacking_price(1000);
//			int status = mapper.insert(vo);
//
//			log.info(vo);
//	}

	}

	@Test
	public void update() {
		ItemVO tmp = new ItemVO();
		tmp.setItem_no(3);
		ItemVO vo = mapper.detail(tmp);

	}

	@Test
	public void delete() {
		mapper.delete(28);
	}

	@Test
	public void count() {
		ItemVO vo = new ItemVO();
		mapper.count(vo);
	}
}
