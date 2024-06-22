package kr.co.soaff.cancel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soaff.item.ItemMapper;
import kr.co.soaff.order.OrderDetailVO;
import kr.co.soaff.order.OrderMapper;

@Service
public class CancelServiceImpl implements CancelService {
	@Autowired
	private CancelAdminMapper cancelMapper;
	private OrderMapper orderMapper;

	@Override
	public boolean requestCancel(CancelAdminDetailVO vo) {
		return cancelMapper.requestCancel(vo)==0?false:true;
	}



}
