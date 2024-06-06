package kr.co.soaff.order;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CancelAdminMapper {
    List<OrderDetailVO> list(OrderDetailVO vo);
    int count(OrderDetailVO vo);
    int approveCancel(OrderDetailVO vo);
    int refuseCancel(OrderDetailVO vo);
    int completeCancel(OrderDetailVO vo);
    int adminCancel(OrderDetailVO vo);
}
