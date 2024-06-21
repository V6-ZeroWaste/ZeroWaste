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
public class orderTest {

	@Autowired
	OrderMapper mapper;

	@Test
	public void info() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
		log.info(mapper.info(vo));
	}

	@Test
	public void point() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
		log.info(mapper.point(vo));
	}

	@Test
	public void cartList() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
		int[] arr = { 6 };
		vo.setCheckedCartNo(arr);
		log.info(mapper.cartList(vo));
	}

	@Test
	public void cartCount() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
		int[] arr = { 6 };
		vo.setCheckedCartNo(arr);
		log.info(mapper.cartCount(vo));
	}

}
