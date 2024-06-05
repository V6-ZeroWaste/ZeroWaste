package co.kr.soaff;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.soaff.order.CancelAdminMapper;
import kr.co.soaff.order.OrderDetailVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { config.MvcConfig.class })
@WebAppConfiguration
public class CancelAdminTest {

   @Autowired
   CancelAdminMapper mapper;
   
   @Test
   public void list() {
       List<OrderDetailVO> list = mapper.list(
           20, // startIdx
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

   // 취소 상세 조회 테스트
   @Test
   public void getCancelById() {
      OrderDetailVO vo = mapper.getCancelById(2);
      System.out.println(vo);
   }

   // 취소 승인 테스트
   @Test
   public void approveCancel() {
      OrderDetailVO vo = new OrderDetailVO();
      vo.setOrder_detail_no(2);
      int result = mapper.approveCancel(vo);
      System.out.println("승인 결과: " + result);
   }

   // 취소 완료 테스트
   @Test
   public void completeCancel() {
      OrderDetailVO vo = new OrderDetailVO();
      vo.setOrder_detail_no(2);
      int result = mapper.completeCancel(vo);
      System.out.println("취소 완료 결과: " + result);
   }

   // 관리자 강제 취소 테스트
   @Test
   public void adminCancel() {
      OrderDetailVO vo = new OrderDetailVO();
      vo.setOrder_detail_no(2);
      vo.setCancel_reason_detail("관리자 요청에 의한 취소");
      int result = mapper.adminCancel(vo);
      System.out.println("관리자 취소 결과: " + result);
   }

   // 검색 및 필터링 리스트 테스트
   @Test
   public void searchCancel() {
      List<Integer> cancelStatusList = Arrays.asList(0, 1, 2);
      String searchWord = "user";
      String startRequestDate = "2024-01-01";
      String endRequestDate = "2024-06-30";
      String startApproveDate = null;
      String endApproveDate = null;
      String orderBy = "최신순"; // 정렬 기준 변경
      Integer filter = 2; // 필터 값 추가

      List<OrderDetailVO> list = mapper.list(
         0, // startIdx
         cancelStatusList, searchWord, filter, // 필터 값 전달
         startRequestDate, endRequestDate, startApproveDate, endApproveDate, orderBy
      );
      list.stream().forEach(v -> System.out.println(v));
   }

   // 필터 없이 리스트 테스트
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
      list.stream().forEach(v -> System.out.println(v));
   }

   // 특정 타입만으로 리스트 테스트
   @Test
   public void listWithTypeOnly() {
      List<OrderDetailVO> list = mapper.list(
         0, // startIdx
         null, // cancelStatusList
         null, // searchWord
         2, // filter
         null, // startRequestDate
         null, // endRequestDate
         null, // startApproveDate
         null, // endApproveDate
         null  // orderBy
      );
      list.stream().forEach(v -> System.out.println(v));
   }
}
