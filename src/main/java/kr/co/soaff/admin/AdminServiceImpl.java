package kr.co.soaff.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminMapper mapper;
	
	@Override
	public AdminVO login(AdminVO vo) {
		return mapper.login(vo);
	}

}
