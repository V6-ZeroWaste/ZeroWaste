package kr.co.soaff.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProfileMapper {
	int updateInfo(UserVO vo);
	UserVO getInfo(int user_no);
	int deleteCheck(UserVO vo);
	int delete(UserVO vo);
}
