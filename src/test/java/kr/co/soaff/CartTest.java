package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.cart.CartMapper;
import kr.co.soaff.cart.CartVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class CartTest {

	@Autowired
	CartMapper mapper;

	@Test
	public void list() {
		CartVO vo = new CartVO();
		vo.setUser_no(1);
		log.info(mapper.list(vo));
	}

	@Test
	public void update() {
		CartVO vo = new CartVO();
		vo.setUser_no(1);
		vo.setCart_no(3);
		vo.setAmount(2);
		mapper.updateAmount(vo);
		log.info(mapper.list(vo));

	}

	@Test
	public void del() {
		CartVO vo = new CartVO();
		vo.setUser_no(1);
		vo.setCart_no(1);
		vo.setAmount(2);
		mapper.delete(vo);
		log.info(mapper.list(vo));

	}

}
