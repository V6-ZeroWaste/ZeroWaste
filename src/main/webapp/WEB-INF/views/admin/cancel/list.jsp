<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>주문 취소 리스트</title>
<link href="${pageContext.request.contextPath}/admin/css/styles.css"
	rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/admin/js/scripts.js"></script>
<style>
h1 {
	margin-top: 25px;
}

.page_navigation {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
}

.pagination {
	display: flex;
	list-style: none;
	padding: 0;
}

.pagination li {
	margin: 0 5px;
}

.pagination a {
	text-decoration: none;
	color: #007bff;
}

.pagination .active a {
	font-weight: bold;
	color: #000;
}

.option {
	display: flex;
	align-items: center;
	margin-bottom: 40px;
	justify-content: space-between;
}

.option .calendar {
	
}

.option .filter-group, .option .calendar {
	display: flex;
	align-items: center;
}

.option input[type="date"], .option .calendar-box {
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	padding: 0.375rem 0.75rem;
}

.option .search {
	display: flex;
	align-items: center;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	padding: 0.375rem 0.75rem;
}

.option .search input {
	border: none;
}

.filter-group input[type="submit"] {
	background-color: #007bff;
	color: white;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	padding: 0.375rem 0.75rem;
	cursor: pointer;
	font-size: 1rem;
}

.option .search i {
	color: #6c757d;
}

.option .calendar .calendar-box {
	background-color: #e9ecef;
	text-align: center;
}
</style>
</head>
<body"sb-nav-fixed">
	<!-- header -->
	<%@ include file="/WEB-INF/views/admin/include/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="cancelListPage">
					<h1>
						<b>취소 관리
					</h1>
					<div class="option">
						<form method="get" name="searchForm" action="/admin/cancel/list">
							<div class="filter-group">
								<select name="orderBy" id="orderBySelect">
									<option value="" hidden>정렬</option>
									<option value="최신순"
										<c:if test="${cancelAdminListVO.orderBy == '최신순'}">selected</c:if>>요청
										날짜 최신순</option>
									<option value="오래된순"
										<c:if test="${cancelAdminListVO.orderBy == '오래된순'}">selected</c:if>>요청
										날짜 오래된 순</option>
								</select> <select name="filter" id="filterSelect">
									<option value="" hidden>필터</option>
									<option value="0"
										<c:if test="${cancelAdminListVO.filter == 0}">selected</c:if>>취소
										요청</option>
									<option value="1"
										<c:if test="${cancelAdminListVO.filter == 1}">selected</c:if>>취소
										승인</option>
									<option value="3"
										<c:if test="${cancelAdminListVO.filter == 3}">selected</c:if>>취소
										거절</option>
									<option value="2"
										<c:if test="${cancelAdminListVO.filter == 2}">selected</c:if>>취소
										완료</option>
								</select>
								<div class="search">
									<i class="fas fa-search"></i> <input type="text"
										name="searchWord" placeholder="주문no/유저ID/상품명"
										value="${cancelAdminListVO.searchWord}">
								</div>
								<input type="submit" value="검색">
								<div class="calendar">
									<input type="date" name="startRequestDate"
										id="startRequestDate" placeholder="YYYY-MM-DD"
										value="${cancelAdminListVO.startRequestDate}">
									<div class="calendar-box">-</div>
									<input type="date" name="endRequestDate" id="endRequestDate"
										placeholder="YYYY-MM-DD"
										value="${cancelAdminListVO.endRequestDate}">
								</div>

								<input type="hidden" name="page"
									value="${cancelAdminListVO.page}">
							</div>
						</form>
					</div>
					<p>
						<span><strong>총 ${map.count}개</strong> |
							${cancelAdminListVO.page}/${map.totalPage}페이지</span>
					</p>
					<div class="list_page">
						<div class="list_content">
							<table id="datatablesSimple" class="table table-striped">
								<thead>
									<tr>
										<th>주문 번호</th>
										<th>상품명</th>
										<th>구매자명</th>
										<th>수량</th>
										<th>상품 금액</th>
										<th>취소 요청 날짜</th>
										<th>취소 완료 날짜</th>
										<th>취소 상태</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="list" items="${map.list}">
										<tr
											onclick="location.href='/admin/cancel/${list.order_detail_no}'"
											style="cursor: pointer;">
											<td>${list.order_no}</td>
											<td>${list.item_name}</td>
											<td>${list.user_id}</td>
											<td>${list.amount}</td>
											<td>${list.price}</td>
											<td><fmt:formatDate value="${list.cancel_request_date}"
													pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td><fmt:formatDate value="${list.cancel_approve_date}"
													pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td><c:choose>
													<c:when test="${list.cancel_status == 0}">취소 요청</c:when>
													<c:when test="${list.cancel_status == 1}">취소 승인</c:when>
													<c:when test="${list.cancel_status == 2}">취소 완료</c:when>
													<c:when test="${list.cancel_status == 3}">취소 거절</c:when>
												</c:choose></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="page_navigation">
						<ul class="pagination">
							<c:if test="${map.isPrev}">
								<li><a
									href="list?page=${map.startPage-1}&startRequestDate=${cancelAdminListVO.startRequestDate}&endRequestDate=${cancelAdminListVO.endRequestDate}&startApproveDate=${cancelAdminListVO.startApproveDate}&endApproveDate=${cancelAdminListVO.endApproveDate}&orderBy=${cancelAdminListVO.orderBy}&filter=${cancelAdminListVO.filter}&searchWord=${cancelAdminListVO.searchWord}">‹‹</a></li>
							</c:if>
							<c:forEach var="p" begin="${map.startPage}" end="${map.endPage}">
								<c:choose>
									<c:when test="${p == cancelAdminListVO.page}">
										<li class="active"><a href='#;' class='current'>${p}</a></li>
									</c:when>
									<c:otherwise>
										<li><a
											href="list?page=${p}&startRequestDate=${cancelAdminListVO.startRequestDate}&endRequestDate=${cancelAdminListVO.endRequestDate}&startApproveDate=${cancelAdminListVO.startApproveDate}&endApproveDate=${cancelAdminListVO.endApproveDate}&orderBy=${cancelAdminListVO.orderBy}&filter=${cancelAdminListVO.filter}&searchWord=${cancelAdminListVO.searchWord}">${p}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${map.isNext}">
								<li><a
									href="list?page=${map.endPage+1}&startRequestDate=${cancelAdminListVO.startRequestDate}&endRequestDate=${cancelAdminListVO.endRequestDate}&startApproveDate=${cancelAdminListVO.startApproveDate}&endApproveDate=${cancelAdminListVO.endApproveDate}&orderBy=${cancelAdminListVO.orderBy}&filter=${cancelAdminListVO.filter}&searchWord=${cancelAdminListVO.searchWord}">››</a></li>
							</c:if>
						</ul>
					</div>


				</div>
			</main>
			<%@ include file="/WEB-INF/views/admin/include/footer.jsp"%>
		</div>
	</div>
	<script>
		$(document)
				.ready(
						function() {
							$("#prevPage")
									.on(
											"click",
											function(event) {
												event.preventDefault();
												let currentPage = $
												{
													cancelAdminListVO.page
												}
												;
												if (currentPage > 1) {
													window.location.href = '?page='
															+ (currentPage - 1)
															+ '&searchWord=${cancelAdminListVO.searchWord}&filter=${cancelAdminListVO.filter}&startRequestDate='
															+ $(
																	"#startRequestDate")
																	.val()
															+ '&endRequestDate='
															+ $(
																	"#endRequestDate")
																	.val()
															+ '&startApproveDate='
															+ $(
																	"#startApproveDate")
																	.val()
															+ '&endApproveDate='
															+ $(
																	"#endApproveDate")
																	.val()
															+ '&orderBy=${cancelAdminListVO.orderBy}';
												}
											});

							$("#nextPage")
									.on(
											"click",
											function(event) {
												event.preventDefault();
												let currentPage = $
												{
													cancelAdminListVO.page
												}
												;
												let totalPage = $
												{
													map.totalPage
												}
												;
												if (currentPage < totalPage) {
													window.location.href = '?page='
															+ (currentPage + 1)
															+ '&searchWord=${cancelAdminListVO.searchWord}&filter=${cancelAdminListVO.filter}&startRequestDate='
															+ $(
																	"#startRequestDate")
																	.val()
															+ '&endRequestDate='
															+ $(
																	"#endRequestDate")
																	.val()
															+ '&startApproveDate='
															+ $(
																	"#startApproveDate")
																	.val()
															+ '&endApproveDate='
															+ $(
																	"#endApproveDate")
																	.val()
															+ '&orderBy=${cancelAdminListVO.orderBy}';
												}
											});

							$("#filterSelect")
									.on(
											"change",
											function() {
												var selectedFilter = $(this)
														.val();
												var startDateInput = $("#startRequestDate");
												var endDateInput = $("#endRequestDate");
												if (selectedFilter === "2") {
													$(".calendar-box").text(
															"취소 완료");
													startDateInput.attr("name",
															"startApproveDate");
													endDateInput.attr("name",
															"endApproveDate");
													startDateInput
															.val("${cancelAdminListVO.startApproveDate}");
													endDateInput
															.val("${cancelAdminListVO.endApproveDate}");
												} else {
													$(".calendar-box").text(
															"취소 요청");
													startDateInput.attr("name",
															"startRequestDate");
													endDateInput.attr("name",
															"endRequestDate");
													startDateInput
															.val("${cancelAdminListVO.startRequestDate}");
													endDateInput
															.val("${cancelAdminListVO.endRequestDate}");
												}
											});

							$("#filterSelect").trigger("change");
						});
	</script>
</body>
</html>
