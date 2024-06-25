package kr.co.soaff.point;

import java.util.Map;

public interface PointService {
	int total(PointVO vo); // 보유한 총 적립금
	Map<String, Object> list(PointVO vo); 
	boolean insert(PointVO vo);
	boolean delete(int point_no);
	Map<String, Object> userList(PointVO vo);
} 
