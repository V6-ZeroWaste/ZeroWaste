package kr.co.soaff;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.order.OrderMapper;
import kr.co.soaff.order.OrderVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class orderTest {

	@Autowired
	OrderMapper mapper;

	@Test
	public void info() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
		log.info(mapper.info(vo));
	}

	@Test
	public void point() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
		log.info(mapper.point(vo));
	}

	@Test
	public void cartList() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
		int[] arr = { 6 };
		vo.setCheckedCartNo(arr);
		log.info(mapper.cartList(vo));
	}

	@Test
	public void cartCount() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
		int[] arr = { 6 };
		vo.setCheckedCartNo(arr);
		log.info(mapper.cartCount(vo));
	}

	@Test
	public void updateDb() {
		OrderVO vo = new OrderVO();
		vo.setUser_no(1);
//		vo.setPayment_date("2024-06-22");
		vo.setPoint(-50);
		vo.setPayment_id("5836-1719015301044");
		vo.setPayment_price(300);
		vo.setPayment_method("card");
		vo.setOrder_status(2);
		vo.setOrder_name("스마트워치 외 1건");
		vo.setReceiver_name("이봉욱");
		vo.setZipcode("22002");
		vo.setReceiver_name("홍길동");
		vo.setAddr("인천 연수구 송도동");
		vo.setAddr_detail("101동 101호");
		vo.setReceiver_tel("010-2222-2222");
		vo.setDelivery_request("문앞에 두세요");
		vo.setDelivery_price(3000);
		vo.setBuyer_name("홍길동");
		vo.setBuyer_email("v6@gmail.com");
		vo.setBuyer_tel("010-3333-3333");
		vo.setDelivery_status(0);
		vo.setPointPlusContent("스마트워치 외 1건 주문건 적립");
		vo.setPointContent("스마트워치 외 1건 주문시 적립금 사용");
		vo.setPointPlus(200);

		log.info(mapper.orderInsert(vo));
		log.info(mapper.pointMinus(vo));
		log.info(mapper.pointPlus(vo));

	}

}
