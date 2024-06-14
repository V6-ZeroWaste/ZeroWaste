<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
<link rel="stylesheet" href="/user/css/vendor.css" />
<link rel="stylesheet" href="/user/css/style.css" />

<title>soaff</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/admin/css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/admin/js/datatables-simple-demo.js"></script>
<script src="${pageContext.request.contextPath}/admin/js/scripts.js"></script>
<style>
img {
	max-height: 50px;
	max-width: 50px;
}

tr {
	height: 65px;
}

.rating i {
	color: #FFD700;
}
</style>
<script type="text/javascript">
	let page = 1;
	window.onload = function() {
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
		var data = {
			startDate : $('#startDate').val().trim(),
			endDate : $('#endDate').val().trim(),
			page : page,
		}

		$
				.ajax({
					type : "GET", // method type
					url : "/user/review/getList", // 요청할 url
					data : data, // 전송할 데이터
					dataType : "json", // 응답 받을 데이터 type
					success : function(resp) {
						// 데이터 리스트 출력
						$("#printList").html(resp.printList);

						// 페이지네이션 출력
						// 총 개수
						$(".datatable-info").html(
								"Showing "
										+ ((page - 1) * 20 + 1)
										+ " to "
										+ (page * 20 <= resp.total ? page * 20
												: resp.total) + " of "
										+ resp.total + " entries");
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
						for (i = resp.startPage; i <= resp.endPage; i++) {
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
									+ '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
							printPage += '<li class="datatable-pagination-list-item">';
							printPage += '<a data-page="'
									+ resp.totalPage
									+ '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
						}
						$(".datatable-pagination-list").html(printPage);

					},
					error : function(data, textStatus) {
						$('#fail').html("관리자에게 문의하세요.") // 서버오류
						console.log('error', data, textStatus);
					}
				})

	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/user/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/user/include/mypageInfo.jsp"%>
	<section class="pt-5">
		<div class="container">
			<div class="row gutter-4 justify-content-between">
				<%@ include file="/WEB-INF/views/user/include/mypageNav.jsp"%>
				<div class="col-lg-9">
					<div class="row">
						<div class="col">


							<div class="container-fluid px-4">
								<h1 class="mt-4">리뷰</h1>
								<div class="card mb-4">

									<div class="card-body">
										<!-- 리스트 정렬, 필터 검색 영역  -->
										<div>
											<div class="datatable-dropdown" style="margin-bottom: 20px">
												<span>작성 날짜</span> <input id="startDate" name="startDate"
													type="date" class="datatable-selector"
													onchange="applyCondition();">- <input id="endDate"
													name="endDate" type="date" class="datatable-selector"
													onchange="applyCondition();">
											</div>
										</div>
										<p>
											<span><strong>총 ${map.total}개</strong> |
												${reviewVO.page}/${map.totalPage}페이지</span>
										</p>
										<!-- 리스트 영역 -->
										<div class="datatable-container">
											<table class="datatable-table">
												<thead>
													<tr>
														<th>상품이미지</th>
														<th>상품명</th>
														<th>제목</th>
														<th>작성자</th>
														<th>리뷰일자</th>
														<th>평점</th>
													</tr>
												</thead>
												<tbody id="printList">
													<c:forEach var="list" items="${map.list}">
														<tr style="cursor: pointer;">
															<td>${list.review_img}</td>
															<td>${list.item_name}</td>
															<td>${list.title}</td>
															<td>${list.user_id}</td>
															<td><fmt:formatDate value="${list.regist_date}"
																	pattern="yyyy-MM-dd" /></td>
															<td>
																<p class="rating">
																	<c:forEach var="i" begin="1" end="${list.score}">
																		<i class="fas fa-star"></i>
																	</c:forEach>
																</p>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										<!-- 페이지네이션 영역 -->
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

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/user/include/footer.jsp"%>
</body>
</html>















