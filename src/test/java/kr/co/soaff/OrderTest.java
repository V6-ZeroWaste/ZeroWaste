package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.order.OrderMapper;
import kr.co.soaff.order.OrderVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class OrderTest {

	@Autowired
	OrderMapper mapper;

	@Test
	public void 검색조건없는리스트() {
		OrderVO vo = new OrderVO();
		mapper.list(vo);
	}

	@Test
	public void 필터적용리스트0() {
		OrderVO vo = new OrderVO();
		vo.setFilter(0);
		mapper.list(vo);
	}

	@Test
	public void 필터적용리스트1() {
		OrderVO vo = new OrderVO();
		vo.setFilter(1);
		mapper.list(vo);
	}

	@Test
	public void 필터적용리스트2() {
		OrderVO vo = new OrderVO();
		vo.setFilter(2);
		mapper.list(vo);
	}

	@Test
	public void 리스트검색() {
		OrderVO vo = new OrderVO();
		vo.setSearchWord("블렌더");
		mapper.list(vo);
	}

	@Test
	public void 리스트정렬() {
//		OrderVO vo = new OrderVO();
//		vo.setOrderBy("최신순");
//		mapper.list(vo);
//		vo.setOrderBy("오래된순");
//		mapper.list(vo);
//		vo.setOrderBy("주문금액많은순");
//		mapper.list(vo);
//		vo.setOrderBy("주문금액적은순");
//		mapper.list(vo);
	}

	@Test
	public void 필터검색정렬적용() {
	}

}
