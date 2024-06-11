<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>admin order list</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/datatables-simple-demo.js"></script>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
        <div id="layoutSidenav">
        	<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        	<div id="layoutSidenav_content">
        		<main>
        			<div class="container-fluid px-4">
                        <h1 class="mt-4">주문 관리</h1>
                        <div class="card mb-4">

                            
                            <div class="card-body">
                             	<!-- 리스트 정렬, 필터 검색 영역  -->
								<form method="get" name="searchForm" id="searchForm" action="/admin/order/list">
										<div class="datatable-dropdown">
											<span>주문 날짜</span>
											<input name="start_date" type="datetime-local" class="datatable-selector" <c:if test="${orderVO.start_date} != null">value=${orderVO.start_date}</c:if>>-<input name="end_date" type="datetime-local" class="datatable-selector" <c:if test="${orderVO.end_date} != null">value=${orderVO.end_date}</c:if>>
										</div>
										<div class="datatable-dropdown">
											<label>
												<select name="orderBy" class="datatable-selector">
													<option value="none" <c:if test="${empty orderVO.orderBy}">selected</c:if>>==정렬==</option>
													<option value="최신순" <c:if test="${orderVO.orderBy == '최신순'}">selected</c:if>>최신순</option>
													<option value="오래된순"<c:if test="${orderVO.orderBy == '오래된순'}">selected</c:if>>오래된순</option>
													<option value="주문금액많은순"<c:if test="${orderVO.orderBy == '주문금액많은순'}">selected</c:if>>주문금액 많은 순</option>
													<option value="주문금액적은순"<c:if test="${orderVO.orderBy == '주문금액적은순'}">selected</c:if>>주문금액 적은 순</option>
												</select>
											</label>
											<label>
												<select name="filter" class="datatable-selector">
													<option value="" <c:if test="${empty orderVO.filter}">selected</c:if>>==필터==</option>
													<option value="0" <c:if test="${orderVO.filter == 0}">selected</c:if>>취소 완료</option>
													<option value="1" <c:if test="${orderVO.filter == 1}">selected</c:if>>취소 요청</option>
													<option value="2" <c:if test="${orderVO.filter == 2}">selected</c:if>>상품준비중</option>
													<option value="3" <c:if test="${orderVO.filter == 3}">selected</c:if>>배송중</option>
													<option value="4" <c:if test="${orderVO.filter == 4}">selected</c:if>>배송완료</option>
													<option value="5" <c:if test="${orderVO.filter == 5}">selected</c:if>>구매확정</option>
												</select>
											</label>
											<div class="datatable-top">
												<input name="SearchWord" class="datatable-input" type="search" placeholder="상품명/주문한 아이디/문의 제목" <c:if test="${orderVO.searchWord} != null">value=${orderVO.searchWord}</c:if>>
												<input type="submit" value="검색" class="btn btn-primary">
											</div>
										</div>
									
							    </form>   
                           	
								
                            	
                            	<!-- 리스트 영역 -->
                            	<div class="datatable-container">
                                <table class="datatable-table">
                                    <thead>
                                        <tr>
                                       	   <th>주문 번호</th>
                                           <th>주문 일자</th>
                                           <th>주문한 유저ID</th>
                                           <th>주문 금액(수량)</th>
                                           <th>주문 상태</th>
                                        </tr>
                                    </thead>
                                    <c:if test="${empty map.list}">
			                            <tr>
			                                <td class="first" colspan="5">등록된 글이 없습니다.</td>
			                            </tr>
		                        	</c:if>
		                        	<c:forEach var="vo" items="${map.list}">
			                        	<tr>
                                           <td onclick="location.href='/admin/order/detail?order_no=${vo.order_no}'">${vo.order_no}</td>
                                           <td>${vo.payment_date}</td>
                                           <td>${vo.id}</td>
                                           <td>${vo.payment_price}(${vo.total_amount})</td>
                                           <td>${vo.order_status}</td>
			                        	</tr>
		                        	</c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- 페이지네이션-->
                            <div class="datatable-bottom">
							    <div class="datatable-info">Showing ${orderVO.page} to ${map.totalPage } of ${map.count } entries</div>
							    <nav class="datatable-pagination">
							    	<ul class="datatable-pagination-list">
							    		
							    		<c:if test="${map.isPrev }">
							    			<li class="datatable-pagination-list-item datatable-hidden datatable-disabled">
				                        		<a href="list?page=${map.startPage-1 }&start_date=${orderVO.start_date}&end_date=${orderVO.end_date}&orderBy=${orderVO.orderBy}&filter=${orderVO.filter}&SearchWord=${orderVO.SearchWord}">‹‹</a>
				                        	</li>
				                        </c:if>
				                        
				                        <c:forEach var="p" begin="${map.startPage}" end="${map.endPage}">
				                        	<c:if test="${p == orderVO.page}">
					                            <li class="datatable-pagination-list-item datatable-active">
					                            	<a href='#;' class='current'>${p}</a>
					                            </li>
				                            </c:if>
				                            <c:if test="${p != orderVO.page}">
					                            <li class="datatable-pagination-list-item datatable-hidden datatable-disabled">
					                            	<a href="list?page=${map.startPage-1 }&start_date=${orderVO.start_date}&end_date=${orderVO.end_date}&orderBy=${orderVO.orderBy}&filter=${orderVO.filter}&SearchWord=${orderVO.SearchWord}">${p}</a>
					                            </li>
				                            </c:if>
			                        	</c:forEach>

							    	</ul>
							    </nav>
							    </div>
							</div>
                        </div>
                    </div>
        		</main>
                <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
            </div>
        </div>
        
    </body>
</html>