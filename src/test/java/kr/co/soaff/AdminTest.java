package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.admin.AdminMapper;
import kr.co.soaff.admin.AdminVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration //@ContextConfiguration 다 읽어서 넣어줌

public class AdminTest {
	@Autowired
	AdminMapper mapper;
	
	@Test
	public void login() {
		AdminVO vo = new AdminVO();
		vo.setId("admin1");
		vo.setPw("admin1234");
		log.info(mapper.login(vo));
	}
	

}
