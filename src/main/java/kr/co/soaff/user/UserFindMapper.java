package kr.co.soaff.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserFindMapper {
	UserVO idFindCheck(UserVO vo);
	UserVO pwFindCheck(UserVO vo);
	int pwNewCheck(UserVO vo);
	int pwNewInsert(UserVO vo);
}
