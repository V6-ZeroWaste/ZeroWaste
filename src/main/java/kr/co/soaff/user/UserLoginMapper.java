package kr.co.soaff.user;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserLoginMapper {
	UserVO login(UserVO vo);
}
