package kr.co.soaff.user;

import java.util.Map;

public interface UserAdminService {
	Map<String, Object> list(UserVO vo);
	UserVO detail(UserVO vo);
	boolean update(UserVO vo);
}
