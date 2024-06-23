package kr.co.train;


import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.train.member.MemberMapper;
import kr.co.train.member.MemberVO;
import kr.co.train.reply.ReplyMapper;
import kr.co.train.reply.ReplyVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {config.MvcConfig.class})
@WebAppConfiguration //@ContextConfiguration 다 읽어서 넣어줌
public class ReplyTest {
	@Autowired
	ReplyMapper mapper;
	@Test
	public void insert() { // 테스트 데이터 100개 넣
//		for(int i = 0; i<100; i++) {
//			ReplyVO vo = new ReplyVO();
//			vo.setTitle("제목"+i);
//			vo.setContent("테스트"+i);
//			mapper.insert(vo);
//			mapper.updateGno(vo.getNo());
//		}
		ReplyVO vo = new ReplyVO();
		vo.setTitle("제목"+103);
		vo.setContent("테스트"+103);
		int r = mapper.insert(vo);
		System.out.println(r+"   "+ vo.getNo());
		mapper.updateGno(vo.getNo());
	}
	@Test
	public void reply() {
		ReplyVO vo = new ReplyVO();
		// 브라우저에 저장될 부모 게시글 데이터...
		vo.setGno(100);
		vo.setOno(0);
		vo.setNested(0);
		// 유저가 작성하고 넘긴 데이터 
		vo.setTitle("100번의 답변");
		vo.setContent("100번의 답변. 테스트입니다.");
		// ono 수정 
		vo.setOno(vo.getOno()+1);
		vo.setNested(vo.getNested()+1);
		// insert
		mapper.insert(vo);
	}
	
	@Test
	public void list() {
		ReplyVO vo = new ReplyVO();
		vo.setSearchType("all");
		vo.setSearchWord("1");
		List<ReplyVO> list = mapper.list(vo);
		
//		for(ReplyVO v : list) {
//			System.out.println(v.toString());
//		}
		list.stream().forEach(v-> System.out.println(v.toString()));
	}
	
}
