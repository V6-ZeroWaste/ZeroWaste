package kr.co.train;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.train.member.MemberMapper;
import kr.co.train.member.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration //@ContextConfiguration 다 읽어서 넣어줌
public class MemberTest {
	@Autowired
	MemberMapper mapper;
	@Test
	public void regist() {
		MemberVO vo = new MemberVO();
		vo.setEmail("test@gmail.com");
		vo.setPwd("test1234");
		vo.setName("테스트");
		mapper.regist(vo);
	}

	@Test
	public void emailCheck() {
		MemberVO vo = new MemberVO();
		int r= mapper.emailCheck("test2@gamil.com");
		log.info(r+"");
	}


	@Test
	public void login() {
		MemberVO vo = new MemberVO();
		vo.setEmail("test@email.com");
		vo.setPwd("test1234");
		log.info(mapper.login(vo));
	}
	
}
