package kr.co.soaff.cancel;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CancelAdminMapper {
	List<CancelAdminListVO> list(CancelAdminListVO vo);

	CancelAdminDetailVO detailFromOrderDetailVO(int order_detail_no);

	CancelAdminOrderVO detailFromOrderVO(int order_no);

	int count(CancelAdminListVO vo);

	int countOrderItems(int order_no);

	int approveCancel(CancelAdminDetailVO vo);

	int refuseCancel(CancelAdminDetailVO vo);

	int completeCancel(CancelAdminDetailVO vo);

	int adminCancel(CancelAdminDetailVO vo);
	
	int requestCancel(CancelAdminDetailVO vo);
}
