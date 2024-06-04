package kr.co.soaff.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserAdminMapper {
	List<UserVO> list(UserVO vo);
	int count(UserVO vo);
	UserVO detail(UserVO vo);
	int update(UserVO vo);
}
