package kr.co.soaff.statistics.users;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UsersMapper {

	List<UsersVO> users_list(UsersVO vo);

	List<UsersVO> leave_list(UsersVO vo);

	int count(UsersVO vo);

}
