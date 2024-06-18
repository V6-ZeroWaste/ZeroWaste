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
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
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
<script src="/admin/js/datatables-simple-demo.js"></script>
<script src="${pageContext.request.contextPath}/admin/js/scripts.js"></script>
<script type="text/javascript">
	let page = 1;
	let filter = null;
	
	window.onload = function() {
		const urlParams = new URLSearchParams(window.location.search);
		filter = urlParams.get('filter');
		if (filter !== null) {
			$('#filter').val(filter);
		} else {
			$('#filter').val("");  // 전체보기 시 필터를 빈 문자열로 설정
		}
		getList();
	}
	
	function applyCondition() {
		page = 1;
		getList();
	}
	function changePage(obj) {
		page = obj.getAttribute("data-page");
		getList();
	}
	function getList() {
		var filterValue = $('#filter').val();
		var data = {
			searchWord : $('#searchWord').val(),
			orderBy : $('#orderBy').val(),
			filter : filterValue !== "" ? parseInt(filterValue) : null, 
			startRequestDate : $('#startRequestDate').val(),
			endRequestDate : $('#endRequestDate').val(),
			startApproveDate : $('#startApproveDate').val(),
			endApproveDate : $('#endApproveDate').val(),
			page : page,
		}

		$
				.ajax({
					method : "GET",
					url : "/admin/cancel/getList",
					data : data,
					dataType : "json",
					success : function(resp) {
						let printList = "";
						if (resp.list.length == 0) {
							printList = "<td class='first' colspan='5' style='text-align: center;'>등록된 글이 없습니다.</td>";
						}

						$("#printList").html(resp.printList);
						$(".datatable-info").html(
								"Showing "
										+ ((page - 1) * 20 + 1)
										+ " to "
										+ (page * 20 <= resp.count ? page * 20
												: resp.count) + " of "
										+ resp.count + " entries");

						// 페이지네이션
						let printPage = "";
						if (resp.isPrev) {
							printPage += '<li class="datatable-pagination-list-item">';
							printPage += '<a data-page="1" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
							printPage += '<li class="datatable-pagination-list-item">';
							printPage += '<a data-page="'
									+ (resp.startPage - 1)
									+ '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
						}
						for (let i = resp.startPage; i <= resp.endPage; i++) {
							printPage += '<li class="datatable-pagination-list-item'
									+ (i == page ? ' datatable-active' : '')
									+ '">';
							printPage += '<a data-page="'
									+ i
									+ '" class="datatable-pagination-list-item-link" onclick="changePage(this);">'
									+ i + '</a></li>';
						}
						if (resp.isNext) {
							printPage += '<li class="datatable-pagination-list-item">';
							printPage += '<a data-page="'
									+ (resp.endPage + 1)
									+ '" class="datatable-pagination-list-item-link" onclick="changePage(this);">››</a></li>';
							printPage += '<li class="datatable-pagination-list-item">';
							printPage += '<a data-page="'
									+ resp.totalPage
									+ '" class="datatable-pagination-list-item-link" onclick="changePage(this);">›</a></li>';
						}
						$(".datatable-pagination-list").html(printPage);
						
						const newUrl = '/admin/cancel/list?filter=' + data.filter;
						history.pushState(null, '', newUrl);
					},
					error : function(data, textStatus) {
						$('#fail').html("관리자에게 문의하세요.");
						console.log('error', data, textStatus);
					}
				})
	}
</script>

</head>
<%@ include file="/WEB-INF/views/admin/include/header.jsp"%>
<div id="layoutSidenav">
	<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp"%>
	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid px-4">
				<h1 class="mt-4">취소 관리</h1>
				<div class="card mb-4">

					<div class="card-body">
						<!-- 리스트 정렬, 필터 검색 영역  -->
						<div class="datatable-dropdown" style="margin-bottom: 20px">
							<span>취소 날짜</span> <input type="date" name="startRequestDate"
								id="startRequestDate" placeholder="YYYY-MM-DD"
								value="${cancelAdminListVO.startRequestDate}"> <input
								type="date" name="endRequestDate" id="endRequestDate"
								placeholder="YYYY-MM-DD"
								value="${cancelAdminListVO.endRequestDate}">
						</div>
						<div class="datatable-top">
							<div class="datatable-dropdown">
								<label> <select id="orderBy" name="orderBy"
									class="datatable-selector" onchange="applyCondition();">
										<option value="" hidden>정렬</option>
										<option value="최신순"
											<c:if test="${cancelAdminListVO.orderBy == '최신순'}">selected</c:if>>최신순</option>
										<option value="오래된순"
											<c:if test="${cancelAdminListVO.orderBy == '오래된순'}">selected</c:if>>오래된순</option>
								</select>
								</label> <label> <select id="filter" name="filter"
									class="datatable-selector" onchange="applyCondition();">
										<option value="">전체보기</option>
										<option value="0">취소 요청</option>
										<option value="1">취소 승인</option>
										<option value="3">취소 거절</option>
										<option value="2">취소 완료</option>
								</select>
								</label>
							</div>
							<div class="row align-items-center">
								<div class="col-md-9">
									<input id="searchWord" name="searchWord"
										class="datatable-input" type="search"
										placeholder="주문번호/구매자명/상품명"
										<c:if test="${orderVO.searchWord} != null">value=${orderVO.searchWord}</c:if>
										onkeyup="if(window.event.keyCode==13){applyCondition();}"
										style="width: 250px">
								</div>

								<div class="col-md-1">
									<input type="button" value="검색" class="btn btn-primary"
										onclick="applyCondition()">
								</div>
							</div>

						</div>

						<!-- 리스트 영역 -->
						<div class="datatable-container">
							<table class="datatable-table">
								<thead>
									<tr>
										<th>주문 번호</th>
										<th>주문 상세번호</th>
										<th>상품명</th>
										<th>구매자명</th>
										<th>수량</th>
										<th>상품 금액</th>
										<th>취소 요청 날짜</th>
										<th>취소 완료 날짜</th>
										<th>취소 상태</th>
									</tr>
								</thead>
								<tbody id="printList">

								</tbody>

							</table>
						</div>

						<!-- 페이지네이션-->
						<div class="datatable-bottom">
							<div class="datatable-info"></div>
							<nav class="datatable-pagination">
								<ul class="datatable-pagination-list">
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</main>
		<%@ include file="/WEB-INF/views/admin//include/footer.jsp"%>
	</div>
</div>

</body>
</html>
