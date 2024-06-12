package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.statistics.users.UsersMapper;
import kr.co.soaff.statistics.users.UsersVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class usersTest {

	@Autowired
	UsersMapper mapper;

	@Test
	public void leaveList() {

		UsersVO vo = new UsersVO();
		vo.setStart_date("2024-05-01");
		vo.setEnd_date("2024-09-01");
		vo.setFilter("일별");
		log.info(mapper.leave_list(vo).toString());

	}

	@Test
	public void usersList() {

		UsersVO vo = new UsersVO();
		vo.setStart_date("2024-05-01");
		vo.setEnd_date("2024-09-01");
		vo.setFilter("일별");
		log.info(mapper.users_list(vo).toString());

	}

	@Test
	public void count() {

		UsersVO vo = new UsersVO();
		vo.setStart_date("2024-05-01");
		vo.setEnd_date("2024-09-01");
		vo.setFilter("일별");
		log.info(mapper.count(vo));

	}
}
