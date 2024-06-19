package kr.co.soaff.dashboard;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DashboardMapper {

	int cancelCount();

	int qnaCount();

	int deliveryCount();

	int todaySalse();

	int todayOrderCount();

}
