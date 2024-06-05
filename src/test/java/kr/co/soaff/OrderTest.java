package kr.co.soaff;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.order.OrderAdminMapper;
import kr.co.soaff.order.OrderDetailVO;
import kr.co.soaff.order.OrderVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class OrderTest {

	@Autowired
	OrderAdminMapper mapper;

	@Test
	public void 검색조건없는리스트() {
		OrderVO vo = new OrderVO();
		mapper.list(vo);
		log.info(mapper.count(vo));
	}

	@Test
	public void 필터적용리스트0() {
		OrderVO vo = new OrderVO();
		vo.setFilter(0);
		mapper.list(vo);
		log.info(mapper.count(vo));
	}

	@Test
	public void 필터적용리스트1() {
		OrderVO vo = new OrderVO();
		vo.setFilter(1);
		mapper.list(vo);
	}

	@Test
	public void 필터적용리스트2() {
		OrderVO vo = new OrderVO();
		vo.setFilter(2);
		mapper.list(vo);
	}

	@Test
	public void 리스트검색() {
		OrderVO vo = new OrderVO();
		vo.setSearchWord("블렌더");
		mapper.list(vo);
	}

	@Test
	public void 최신순정렬() {
		OrderVO vo = new OrderVO();
		vo.setOrderBy("최신순");
		mapper.list(vo);
	}

	@Test
	public void 오래된순() {
		OrderVO vo = new OrderVO();
		vo.setOrderBy("오래된순");
		mapper.list(vo);

	}

	@Test
	public void 주문금액많은순() {
		OrderVO vo = new OrderVO();
		vo.setOrderBy("주문금액많은순");
		mapper.list(vo);

	}

	@Test
	public void 주문금액적은순() {
		OrderVO vo = new OrderVO();
		vo.setOrderBy("주문금액적은순");
		mapper.list(vo);

	}

	// 필터정렬검색
	@Test
	public void filterSearchOrder() {
		OrderVO vo = new OrderVO();
		vo.setOrderBy("주문금액적은순");
//		vo.setFilter(1);
		vo.setStart_date(convertStringToTimestamp("2024-06-04 00:00:00", "yyyy-MM-dd HH:mm:ss"));
//		vo.setEnd_date(convertStringToTimestamp("2024-06-06 00:00:00", "yyyy-MM-dd HH:mm:ss"));
//		vo.setSearchWord("블렌더");
		log.info(mapper.list(vo));
		log.info(mapper.count(vo));
	}

	// 주문상세페이지
	@Test
	public void OrderDetailPage() {
		OrderVO vo = new OrderVO();
		OrderDetailVO voDetail = new OrderDetailVO();
		vo.setOrder_no(1);
		voDetail.setOrder_no(1);
		log.info(mapper.detailFromOrderVO(vo));
		log.info(mapper.detailFromOrderDetailVO(voDetail));
	}

	// 배송정보 업데이트
	@Test
	public void updateDeliveryState() {
		OrderVO vo = new OrderVO();
		OrderDetailVO voDetail = new OrderDetailVO();
		voDetail.setOrder_no(1);
		vo.setOrder_no(1);
		vo.setDelivery_status(2);
		log.info(mapper.updateDeliveryStatus(vo));
		log.info(mapper.detailFromOrderVO(vo));
	}

	public static Timestamp convertStringToTimestamp(String dateTime, String format) {
		if (dateTime == null)
			return null;

		try {
			Date date = new SimpleDateFormat(format).parse(dateTime);
			return new Timestamp(date.getTime());
		} catch (Exception e) {
			return null;
		}
	}

}
