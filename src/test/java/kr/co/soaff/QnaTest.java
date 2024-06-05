package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;


import kr.co.soaff.qna.QnaMapper;
import kr.co.soaff.qna.QnaVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration
public class QnaTest  {

	@Autowired
	QnaMapper mapper;
	
	@Test
	public void list() {
		QnaVO vo = new QnaVO();
		
	}


	public void detail(QnaVO vo) {
	

	}


	public void deleteContent(int qna_no) {


	}


	public void deleteAndUpdateReply(QnaVO vo) {

	
	}


	public void count(QnaVO vo) {


	}

}
