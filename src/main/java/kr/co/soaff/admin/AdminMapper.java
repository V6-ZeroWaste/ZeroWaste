package kr.co.soaff.admin;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	AdminVO login(AdminVO vo);
}
