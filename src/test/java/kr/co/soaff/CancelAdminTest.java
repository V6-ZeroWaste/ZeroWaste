package kr.co.soaff;

import java.util.Arrays;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.order.CancelAdminMapper;
import kr.co.soaff.order.OrderAdminMapper;
import kr.co.soaff.order.OrderDetailVO;
import kr.co.soaff.order.OrderVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class CancelAdminTest {

    @Autowired
    CancelAdminMapper mapper;
    @Autowired
    OrderAdminMapper orderMapper;

// 리스트 ----------------------------------------------------------------
    @Test
    public void 리스트기본() {
    	OrderDetailVO vo = new OrderDetailVO();
        log.info( mapper.list(vo));
    }
    @Test
    public void 리스트취소필터() {
    	OrderDetailVO vo = new OrderDetailVO();
//    	vo.setFilter(1);
    	vo.setFilter(0);
        log.info( mapper.list(vo));
    }
    @Test
    public void 리스트검색어() {
    	OrderDetailVO vo = new OrderDetailVO();
    	vo.setSearchWord("액션");
        log.info( mapper.list(vo));
    }
    @Test
    public void 리스트취소필터검색어() {
    	OrderDetailVO vo = new OrderDetailVO();
    	vo.setSearchWord("블렌");
//    	vo.setSearchWord("액션 ");
    	vo.setFilter(0);
        log.info( mapper.list(vo));
    }
    
 // 상세 ----------------------------------------------------------------
    @Test
    public void 디테일() {
    	// 1. OrderDetailVO 불러와서 저장 
        OrderDetailVO odvo = new OrderDetailVO();
        odvo.setOrder_detail_no(2);
        OrderDetailVO getOdvo = mapper.detailFromOrderDetailVO(odvo);
        log.info(getOdvo);
        
        // 2. 저장된 OrderDetailVO 에 저장된 order_no 로 OrderVO 불러와서 저장
        OrderVO getOvo = mapper.detailFromOrderVO(getOdvo.getOrder_no());
        log.info(getOvo);
        
        // 3. OrderVO에 저장된내용과 OrderDetailVO에 저장된 내용으로 화면에 필요한 값 가져오기
        // 최종결제정보 
        int 총주문금액 = getOvo.getPayment_price() - getOvo.getDelivery_price() + getOvo.getPoint();
        int 적립금 = getOvo.getPoint();
        int 배송비 = getOvo.getDelivery_price();
        int 최종결제금액 = getOvo.getPayment_price();
        // 환불정보 
        String 환불수단 = getOvo.getPayment_method();
        int 환불금액 ;
        if(총주문금액 - getOvo.getRefund_price() == getOdvo.getPrice()*getOdvo.getAmount());
        
    }
    
    
    /*

    @Test
    public void approveCancel() {
        OrderDetailVO vo = new OrderDetailVO();
        vo.setOrder_detail_no(2);
        int result = mapper.approveCancel(vo);
        System.out.println("승인 결과: " + result);
    }

    @Test
    public void completeCancel() {
        OrderDetailVO vo = new OrderDetailVO();
        vo.setOrder_detail_no(2);
        int result = mapper.completeCancel(vo);
        System.out.println("취소 완료 결과: " + result);
    }

    @Test
    public void adminCancel() {
        OrderDetailVO vo = new OrderDetailVO();
        vo.setOrder_detail_no(2);
        vo.setCancel_reason_detail("관리자 요청에 의한 취소");
        int result = mapper.adminCancel(vo);
        System.out.println("관리자 취소 결과: " + result);
    }

    @Test
    public void searchCancel() {
        List<Integer> cancelStatusList = Arrays.asList(0, 1, 2);
        String searchWord = "user";
        String startRequestDate = "2024-06-04 21:00:00";
        String endRequestDate = "2024-06-30";
        String startApproveDate = null;
        String endApproveDate = null;
        String orderBy = "최신순";
        Integer filter = 0;

        List<OrderDetailVO> list = mapper.list(
            0, // startIdx
            cancelStatusList,
            searchWord,
            filter,
            startRequestDate,
            endRequestDate,
            startApproveDate,
            endApproveDate,
            orderBy
        );
        list.forEach(System.out::println);
    }

    @Test
    public void listWithoutFilter() {
        List<OrderDetailVO> list = mapper.list(
            0, // startIdx
            null, // cancelStatusList
            null, // searchWord
            null, // filter
            null, // startRequestDate
            null, // endRequestDate
            null, // startApproveDate
            null, // endApproveDate
            null  // orderBy
        );
        list.forEach(System.out::println);
    }

    @Test
    public void listWithTypeOnly() {
        List<OrderDetailVO> list = mapper.list(
            0, // startIdx
            null, // cancelStatusList
            null, // searchWord
            1, // filter
            null, // startRequestDate
            null, // endRequestDate
            null, // startApproveDate
            null, // endApproveDate
            null  // orderBy
        );
        list.forEach(System.out::println);
    }

    @Test
    public void count() {
        OrderDetailVO vo = new OrderDetailVO();
        vo.setSearchWord("user");
        vo.setCancelStatusList(Arrays.asList(0, 1, 2));
        vo.setStartRequestDate("2024-06-01 00:00:00");
        vo.setEndRequestDate("2024-06-30 23:59:59");
        int result = mapper.count(vo);
        System.out.println("검색된 취소 요청 수: " + result);
    }
    */
}
