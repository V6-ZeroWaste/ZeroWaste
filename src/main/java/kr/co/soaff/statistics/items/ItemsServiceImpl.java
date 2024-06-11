package kr.co.soaff.statistics.items;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ItemsServiceImpl implements ItemsService {
	@Autowired
	private ItemsMapper mapper;

}
