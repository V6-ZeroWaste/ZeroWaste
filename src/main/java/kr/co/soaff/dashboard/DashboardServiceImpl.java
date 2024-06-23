package kr.co.soaff.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DashboardServiceImpl implements DashboardService {
	@Autowired
	private DashboardMapper mapper;

	@Override

	public DashboardVO count() {

		DashboardVO vo = new DashboardVO();
		vo.setCancelCount(mapper.cancelCount());
		vo.setQnaCount(mapper.qnaCount());
		vo.setDeliveryCount(mapper.deliveryCount());
		vo.setTodayOrderCount(mapper.todayOrderCount());
		vo.setTodaySalse(mapper.todaySalse());

		return vo;
	}

}
