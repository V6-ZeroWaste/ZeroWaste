package kr.co.soaff;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.order.CancelAdminMapper;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class CancelAdminTest {

	@Autowired
	CancelAdminMapper mapper;

//    @Test
//    public void list() {
//        OrderDetailVO vo = new OrderDetailVO();
//        log.info(mapper.list(vo));
//    }
//
//    @Test
//    public void approveCancel() {
//        OrderDetailVO vo = new OrderDetailVO();
//        vo.setOrder_detail_no(2);
//        int result = mapper.approveCancel(vo);
//        System.out.println("승인 결과: " + result);
//    }
//    
//    @Test
//    public void refuseCancel() {
//    	OrderDetailVO vo = new OrderDetailVO();
//    	vo.setOrder_detail_no(4);
//    	int result = mapper.refuseCancel(vo);
//    	System.out.println("취소: " + result);
//    }
//    @Test
//    public void completeCancel() {
//        OrderDetailVO vo = new OrderDetailVO();
//        vo.setOrder_detail_no(2);
//        int result = mapper.completeCancel(vo);
//        System.out.println("취소 완료 결과: " + result);
//    }
//
//    @Test
//    public void adminCancel() {
//        OrderDetailVO vo = new OrderDetailVO();
//        vo.setOrder_detail_no(2);
//        vo.setCancel_reason_detail("관리자 요청에 의한 취소");
//        int result = mapper.adminCancel(vo);
//        System.out.println("관리자 취소 결과: " + result);
//    }
//
//    @Test
//    public void count() {
//        OrderDetailVO vo = new OrderDetailVO();
//        vo.setSearchWord("user");
//        vo.setCancelStatusList(Arrays.asList(0, 1, 2));
//        vo.setStartRequestDate("2024-06-01 00:00:00");
//        vo.setEndRequestDate("2024-06-30 23:59:59");
//        int result = mapper.count(vo);
//        System.out.println("검색된 취소 요청 수: " + result);
//    }
}
