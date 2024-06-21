package kr.co.soaff.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserSignUpMapper {
	int idCheck(UserVO vo);
}
