package kr.co.soaff.statistics.items;

import lombok.Data;

@Data
public class ItemsVO {
	private int item_no;		// 상품 번호
	private String name;		// 상품명 
	private int order;			// 주문량 = 판매량 + 반품량 개수
	private int sales;			// 판매량
	private int cancel;			// 반품량
	private double cancel_rate;	// 반품률
	private int revenue; 		// 총 매출액 
	
	private String orderBy;		// 정렬 기준
	private String startDate;	// 날짜 필터 (시작날짜)
	private String endDate;		// 날짜 필터 (종료날짜)
	private String searchWord;	// 검색어
	private int page = 1;		// 선택 페이지
	private int startIdx; 		// 시작 인덱스
	private int entries = 0; 	// 한 페이지에 보일 개수. 0이면 전체를 보겠다는 뜻
}
