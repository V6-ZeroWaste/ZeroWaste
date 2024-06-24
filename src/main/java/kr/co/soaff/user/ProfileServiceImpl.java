package kr.co.soaff.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProfileServiceImpl implements ProfileService {
	@Autowired
	ProfileMapper mapper;

	@Override
	public int updateInfo(UserVO vo) {
		return mapper.updateInfo(vo);
	}

	@Override
	public UserVO getInfo(int user_no) {
		return mapper.getInfo(user_no);
	}

	@Override
	public int deleteCheck(UserVO vo) {
		return mapper.deleteCheck(vo);
	}

	@Override
	public int delete(UserVO vo) {
		return mapper.delete(vo);
	}
}