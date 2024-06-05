package kr.co.soaff.order;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CancelAdminMapper {
    OrderDetailVO getCancelById(@Param("order_detail_no") int order_detail_no);
    int count(OrderDetailVO vo);
    int approveCancel(OrderDetailVO orderDetailVO);
    int completeCancel(OrderDetailVO orderDetailVO);
    int adminCancel(OrderDetailVO orderDetailVO);
    List<OrderDetailVO> list(
        @Param("startIdx") int startIdx,
        @Param("cancelStatusList") List<Integer> cancelStatusList,
        @Param("searchWord") String searchWord,
        @Param("filter") Integer filter,
        @Param("startRequestDate") String startRequestDate,
        @Param("endRequestDate") String endRequestDate,
        @Param("startApproveDate") String startApproveDate,
        @Param("endApproveDate") String endApproveDate,
        @Param("orderBy") String orderBy
    );
}
