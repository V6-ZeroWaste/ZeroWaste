package kr.co.soaff.statistics.sales;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SalesServiceImpl implements SalesService {
	@Autowired
	private SalesMapper mapper;

}
