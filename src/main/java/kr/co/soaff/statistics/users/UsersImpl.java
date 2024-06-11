package kr.co.soaff.statistics.users;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsersImpl implements UsersService {
	@Autowired
	private UsersMapper mapper;

}
