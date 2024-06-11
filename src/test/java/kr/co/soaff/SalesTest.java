package kr.co.soaff;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.statistics.sales.SalesMapper;
import kr.co.soaff.statistics.sales.SalesVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class SalesTest {
	@Autowired
	SalesMapper mapper;

	@Test
	public void list() {
		SalesVO vo = new SalesVO();
		vo.setStart_date("2024-06-05");
		List<SalesVO> vos = mapper.list(vo);
		for (SalesVO voTmp : vos) {
			System.out.println(voTmp);
		}
	}
}
