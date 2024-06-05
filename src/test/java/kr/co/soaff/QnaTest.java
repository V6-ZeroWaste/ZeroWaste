package kr.co.soaff;

import java.sql.Timestamp;
import java.util.Calendar;

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
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class QnaTest {

	@Autowired
	QnaMapper mapper;

	@Test
	public void list() {
		QnaVO vo = new QnaVO();
		mapper.list(vo);
	}

// 필터 ----------------------------------------------------------------------------------------
	@Test
	public void 답변안함() {
		QnaVO vo = new QnaVO();
		vo.setFilter("답변안함");
		mapper.list(vo);
	}

	@Test
	public void 답변함() {
		QnaVO vo = new QnaVO();
		vo.setFilter("답변함");
		mapper.list(vo);
	}

	@Test
	public void nullAnswerList() {
		QnaVO vo = new QnaVO();
		vo.setFilter(null);
		mapper.list(vo);
	}
// 검색어----------------------------------------------------------------------------------------

	@Test
	public void 검색() {
		QnaVO vo = new QnaVO();
		vo.setSearchWord("블렌더");
		mapper.list(vo);
	}

// 달력----------------------------------------------------------------------------------------

	@Test
	public void 시작날짜만() {
		QnaVO vo = new QnaVO();
		Calendar calendar = Calendar.getInstance();
		// 시작 시간은 00:00:00
		calendar.set(2023, Calendar.MAY, 3, 0, 0, 0);
		long timeInMillis = calendar.getTimeInMillis();
		Timestamp timestamp = new Timestamp(timeInMillis);
		System.out.println("=========================================");
		System.out.println(timestamp);
		System.out.println("=========================================");
		vo.setStartDate(timestamp);
		mapper.list(vo);
	}

	@Test
	public void 종료날짜만() {
		QnaVO vo = new QnaVO();
		Calendar calendar = Calendar.getInstance();
		// 종료 시간은 23:59:59
		calendar.set(2023, Calendar.MAY, 4, 23, 59, 59);
		long timeInMillis = calendar.getTimeInMillis();
		Timestamp timestamp = new Timestamp(timeInMillis);
		System.out.println("=========================================");
		System.out.println(timestamp);
		System.out.println("=========================================");
		vo.setEndDate(timestamp);
		mapper.list(vo);
	}

	@Test
	public void 둘다적용() {
		QnaVO vo = new QnaVO();
		//
		Calendar calendar1 = Calendar.getInstance();
		calendar1.set(2023, Calendar.MAY, 3, 0, 0, 0);
		long timeInMillis1 = calendar1.getTimeInMillis();
		Timestamp timestamp1 = new Timestamp(timeInMillis1);
		//
		Calendar calendar2 = Calendar.getInstance();
		calendar2.set(2023, Calendar.MAY, 4, 23, 59, 59);
		long timeInMillis2 = calendar2.getTimeInMillis();
		Timestamp timestamp2 = new Timestamp(timeInMillis2);
		//
		vo.setStartDate(timestamp1);
		vo.setEndDate(timestamp2);
		mapper.list(vo);
	}

// 필터 + 검색 ----------------------------------------------------------------------------------------
	@Test
	public void 필터검색() {
		QnaVO vo = new QnaVO();
		vo.setFilter("답변안함");
		vo.setSearchWord("블렌더");
		mapper.list(vo);
	}

// 검색 + 달력 ----------------------------------------------------------------------------------------

	@Test
	public void 검색달력() {
		QnaVO vo = new QnaVO();
		vo.setSearchWord("블렌더");
		Calendar calendar1 = Calendar.getInstance();
		calendar1.set(2023, Calendar.MAY, 1, 0, 0, 0);
		long timeInMillis1 = calendar1.getTimeInMillis();
		Timestamp timestamp1 = new Timestamp(timeInMillis1);

		Calendar calendar2 = Calendar.getInstance();
		calendar2.set(2023, Calendar.MAY, 4, 23, 59, 59);
		long timeInMillis2 = calendar2.getTimeInMillis();
		Timestamp timestamp2 = new Timestamp(timeInMillis2);

		vo.setStartDate(timestamp1);
		vo.setEndDate(timestamp2);
		mapper.list(vo);
	}
// 필터 + 달력 ----------------------------------------------------------------------------------------

	@Test
	public void 필터달력() {
		QnaVO vo = new QnaVO();
		vo.setFilter("답변안함");
		Calendar calendar1 = Calendar.getInstance();
		calendar1.set(2023, Calendar.MAY, 1, 0, 0, 0);
		long timeInMillis1 = calendar1.getTimeInMillis();
		Timestamp timestamp1 = new Timestamp(timeInMillis1);

		Calendar calendar2 = Calendar.getInstance();
		calendar2.set(2023, Calendar.MAY, 4, 23, 59, 59);
		long timeInMillis2 = calendar2.getTimeInMillis();
		Timestamp timestamp2 = new Timestamp(timeInMillis2);

		vo.setStartDate(timestamp1);
		vo.setEndDate(timestamp2);
		mapper.list(vo);
	}
// 검색 +필터 + 검색어 ----------------------------------------------------------------------------------------

	@Test
	public void 검색필터달력() {
		QnaVO vo = new QnaVO();
		vo.setFilter("답변안함");
		vo.setSearchWord("책상");
		Calendar calendar1 = Calendar.getInstance();
		calendar1.set(2023, Calendar.MAY, 1, 0, 0, 0);
		long timeInMillis1 = calendar1.getTimeInMillis();
		Timestamp timestamp1 = new Timestamp(timeInMillis1);

		Calendar calendar2 = Calendar.getInstance();
		calendar2.set(2023, Calendar.MAY, 4, 23, 59, 59);
		long timeInMillis2 = calendar2.getTimeInMillis();
		Timestamp timestamp2 = new Timestamp(timeInMillis2);

		vo.setStartDate(timestamp1);
		vo.setEndDate(timestamp2);
		mapper.list(vo);
	}

// 상세 ----------------------------------------------------------------------------------------
	@Test
	public void 상세() {
		QnaVO vo = new QnaVO();
		vo.setQna_no(1);
		QnaVO tmp = mapper.detail(vo);
		log.info(tmp);
	}

// 문의삭제 ----------------------------------------------------------------------------------------
	@Test
	public void 문의삭제() {
		QnaVO vo = new QnaVO();
		mapper.deleteContent(12);

	}

// 삭제수정 ----------------------------------------------------------------------------------------

	@Test
	public void 수정삭제() {
		QnaVO vo = new QnaVO();

	}
// 삭제수정 ----------------------------------------------------------------------------------------

// 카운트 ----------------------------------------------------------------------------------------
	@Test
	public void 카운트() {
		QnaVO vo = new QnaVO();
		mapper.count(vo);
		log.info(vo);
	}

}
