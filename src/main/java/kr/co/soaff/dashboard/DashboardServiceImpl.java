package kr.co.soaff.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DashboardServiceImpl implements DashboardService {
	@Autowired
	private DashboardMapper mapper;

}
