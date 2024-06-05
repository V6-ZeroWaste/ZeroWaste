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
    int refuseCancel(OrderDetailVO orderDetailVO);
    int adminCancel(OrderDetailVO orderDetailVO);
    List<OrderDetailVO> list(OrderDetailVO orderDetailVO);
    OrderDetailVO detailFromOrderDetailVO(OrderDetailVO orderDetailVO);
    OrderVO detailFromOrderVO(int orderNo);
    
}
