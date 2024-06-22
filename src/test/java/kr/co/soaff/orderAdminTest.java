package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.order.OrderAdminMapper;
import kr.co.soaff.order.OrderVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class orderAdminTest {

	@Autowired
	OrderAdminMapper mapper;

	@Test
	public void list(OrderVO vo) {
		log.info(mapper.list(vo));
	}

}
