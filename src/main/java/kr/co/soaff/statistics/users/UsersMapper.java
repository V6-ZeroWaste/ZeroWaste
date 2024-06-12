package kr.co.soaff.statistics.users;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UsersMapper {

	List<UsersVO> day_user();

	List<UsersVO> day_user_delete();

	List<UsersVO> month_user();

	List<UsersVO> month_user_delete();

}
