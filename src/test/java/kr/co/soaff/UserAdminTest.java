package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.admin.AdminMapper;
import kr.co.soaff.admin.AdminVO;
import kr.co.soaff.user.UserAdminMapper;
import kr.co.soaff.user.UserVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration //@ContextConfiguration 다 읽어서 넣어줌

public class UserAdminTest {
	@Autowired
	UserAdminMapper mapper;
	
	@Test
	public void list() {
		UserVO vo = new UserVO();
		vo.setOrderBy("date_desc");
		vo.setPage(1);
		vo.setSearchWord("1");
		log.info(mapper.list(vo));
	}
	@Test
	public void count() {
		UserVO vo = new UserVO();
		vo.setOrderBy("date_desc");
		vo.setPage(1);
		vo.setSearchWord("1");
		log.info(mapper.count(vo));
	}
	@Test
	public void detail() {
		UserVO vo = new UserVO();
		vo.setUser_no(1);
		log.info(mapper.detail(vo));
	}
	@Test
	public void update() {
		UserVO vo = new UserVO();
		vo.setUser_no(1);
		vo.setZipcode("111-111");
		vo.setAddr("서울시 영등포구");
		vo.setAddr_detail("103호");
		vo.setTel("010-1111-1111");
		log.info(mapper.update(vo));
	}
	

}
