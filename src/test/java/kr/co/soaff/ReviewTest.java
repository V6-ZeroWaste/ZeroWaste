package kr.co.soaff;

import java.sql.Timestamp;
import java.util.Calendar;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.review.ReviewAdminMapper;
import kr.co.soaff.review.ReviewVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class ReviewTest {

	@Autowired
	ReviewAdminMapper mapper;

// 리스트 & 카운트 ----------------------------------------------------------------------------------------
// 테스트내용 
// [완료] 검색어 
// [완료] 날짜 start만
// [완료] 날짜 end만 
// [완료] 날짜 start-end
// [완료] 검색어 + 날짜 start만
// [완료] 검색어 + 날짜 end만 
// [완료] 검색어 + 날짜 start-end
	@Test
	public void list() {
		ReviewVO vo = new ReviewVO();

		// 검색어 적용
		vo.setSearchWord("4");
//		vo.setSearchWord("리뷰");

		// 날짜 적용
		Calendar calendar = Calendar.getInstance();
		// 시작 시간은 00:00:00
		calendar.set(2024, Calendar.JUNE, 3, 0, 0, 0);
		long timeInMillis = calendar.getTimeInMillis();
		Timestamp timestamp = new Timestamp(timeInMillis);
		Calendar calendar2 = Calendar.getInstance();
		calendar2.set(2024, Calendar.JUNE, 6, 23, 59, 59);
		long timeInMillis2 = calendar2.getTimeInMillis();
		Timestamp timestamp2 = new Timestamp(timeInMillis2);

//		vo.setStartDate(timestamp); // 시작날짜
//		vo.setEndDate(timestamp2); // 종료날

		// 정렬적용
		vo.setOrderBy("최신순");
		vo.setOrderBy("오래된순");
		vo.setOrderBy("평점높은순");
//		vo.setOrderBy("평점낮은순");

		log.info(mapper.list(vo));
		System.out.println(mapper.count(vo));
	}

// 상세 ----------------------------------------------------------------------------------------
	@Test
	public void 상세() {
		ReviewVO vo = new ReviewVO();
		vo.setReview_no(10);
		ReviewVO tmp = mapper.detail(vo);
		log.info(tmp);
	}

// 상태 변경 ----------------------------------------------------------------------------------------

	@Test
	public void 수정삭제() {
		ReviewVO vo = new ReviewVO();
		vo.setReview_no(11);
		vo.setExposed_status(1);
		log.info(mapper.updateStatus(vo));
	}

}
