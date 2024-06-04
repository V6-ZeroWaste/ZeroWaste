package kr.co.soaff;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.admin.AdminMapper;
import kr.co.soaff.admin.AdminVO;
import kr.co.soaff.point.PointMapper;
import kr.co.soaff.point.PointVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration //@ContextConfiguration 다 읽어서 넣어줌

public class PointTest {
	@Autowired
	PointMapper mapper;
	
	
	
	@Test
	public void list() {
		PointVO vo = new PointVO();
		vo.setUser_no(1);
		log.info(mapper.list(vo));
	}
	@Test
	public void insert() {
		PointVO vo = new PointVO();
		vo.setContent("세현쓰 보나쓰");
		vo.setPoint(1000);
		vo.setUser_no(2);
		log.info(mapper.insert(vo));
	}
	@Test
	public void delete() {
		log.info(mapper.delete(4));
	}
	@Test
	public void count() {
		PointVO vo = new PointVO();
		vo.setUser_no(1);
		log.info(mapper.count(vo));
	}
	@Test
	public void total() {
		PointVO vo = new PointVO();
		vo.setUser_no(1);
		log.info(mapper.total(vo));
	}
	

}
