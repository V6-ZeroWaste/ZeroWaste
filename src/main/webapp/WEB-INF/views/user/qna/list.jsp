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
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
img {
	max-height: 50px;
	max-width: 50px;
}

tr {
	height: 65px;
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
			startDate : $('#start_Date').val().trim(),
			endDate : $('#end_Date').val().trim(),
			page : page,
		}

		$
				.ajax({
					type : "GET", // method type
					url : "/user/qna/getList", // 요청할 url
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
	<main>
		<div class="container-fluid px-4">
			<h1 class="mt-4">상품 리뷰 관리</h1>
			<div class="card mb-4">
				<!-- <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                DataTable Example
                            </div> -->

				<div class="card-body">
					<!-- 리스트 정렬, 필터 검색 영역  -->
					<div>
						<div class="datatable-dropdown" style="margin-bottom: 20px">
							<span>작성 날짜</span> <input id="start_Date" name="start_Date"
								type="date" class="datatable-selector"
								onchange="applyCondition();">- <input id="endDate"
								name="endDate" type="date" class="datatable-selector"
								onchange="applyCondition();">
						</div>
					</div>
					<p>
						<span><strong>총 ${map.total}개</strong> |
							${qnaVO.page}/${map.totalPage}페이지</span>
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
									<th>문의일자</th>
									<th>답변상태</th>
								</tr>
							</thead>
							<tbody id="printList">
								<c:forEach var="list" items="${map.list}">
										<tr
											style="cursor: pointer;">
											<td>${list.qna_img)}</td>
											<td>${list.item_name}</td>
											<td>${list.title}</td>
											<td>${list.user_id}</td>
											<td><fmt:formatDate value="${list.question_date}"
													pattern="yyyy-MM-dd" /></td>
											<td>${list.replyState}</td>
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
	</main>

</body>
</html>
