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

<title>mypage Qna List</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
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

<style>
.search-filter>div {
	margin: 10px 0px 10px 0px;
}

.qna-info {
	position: relative;
	padding-left: 1.25rem;
	font-size: 0.875rem;
}

.col-12 {
	margin-bottom: 10px;
}
</style>
<script type="text/javascript">
	let page = 1;
	window.onload = function() {
		getList();
	}
	
	function redirectToDetail(qnaNo){
		window.location.href='/mypage/qna/detail?qna_no='+qnaNo;
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
			searchWord : $('#searchWord').val(),
			orderBy : $('#orderBy').val(),
			filter : $('#filter').val(),
			start_date : $('#start_date').val(),
			end_date : $('#end_date').val(),
			page : page,
		}

		$
				.ajax({
					type : "GET", // method type
					url : "/mypage/qna/getList", // 요청할 url
					data : data, // 전송할 데이터
					dataType : "json", // 응답 받을 데이터 type
					success : function(resp) {
						let printList = "";
						if (resp.list.length == 0) {
							printList = "<td class='first' colspan='6' style='text-align: center;'>등록된 글이 없습니다.</td>";
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
					},
					error : function(data, textStatus) {
						$('#fail').html("관리자에게 문의하세요.");
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
						<div class="col-12">
							<h3 class="mb-0">Qna</h3>
							<!-- search filter -->
							<div class="search-filter">
								<div>
									<input type="date" class="btn btn-outline-secondary btn-sm">
									&nbsp;-&nbsp; <input type="date"
										class="btn btn-outline-secondary btn-sm">
								</div>
								<div class="d-flex align-items-center justify-content-between">
									<div>
										<label> <select id="orderBy" name="orderBy"
											class="datatable-selector" onchange="applyCondition();">
												<option value="">===정렬===</option>
												<option value="최신순">최신순</option>
												<option value="오래된순">오래된순</option>
										</select>
										</label> <label> <select id="filter" name="filter"
											class="datatable-selector" onchange="applyCondition();">
												<option value="">==필터==</option>
												<option value="답변대기">답변대기</option>
												<option value="답변완료">답변완료</option>
										</select>
										</label>
									</div>
									<div class="d-flex align-items-center">
										<input id="searchWord" name="searchWord"
											class="datatable-input ml-2" type="search"
											placeholder="상품명/문의 제목"
											onkeyup="if(window.event.keyCode==13){applyCondition();}"
											style="width: 280px"> <input type="button" value="검색"
											class="btn btn-primary ml-2" onclick="applyCondition()">
									</div>
								</div>
								<div>
									<span><strong>총 ${map.count}개</strong></span>
								</div>
							</div>
						</div>

						<!-- list -->
						<div class="col-12">
							<c:forEach var="list" items="${map.list}">
								<!-- review card -->
								<div class="col-12">
									<div class="order">
										<div class="row align-items-center">
											<div class="col-lg-2 order-preview justify-content-center">
												<!-- 상품이미지 -->
												<a href="product-1.html"
													title="Fawn Wool / Natural Mammoth Chair"
													data-toggle="tooltip" data-placement="top"> <img
													src="${list.qna_img }"
													alt="Fawn Wool / Natural Mammoth Chair">
												</a>
											</div>
											<div class="col-lg-4">
												<h3 class="order-number">${list.item_name}</h3>
											</div>
											<div class="col-lg-4">
												<span class="qna-info">${list.question_date }</span> <br>
												<span class="qna-info">${list.title } </span> <br> <span
													class="qna-info">${list.replyState }</span>
											</div>
											<div class="col-lg-2">
												<a href="#!" class="action eyebrow underline" onclick="redirectToDetail(${list.qna_no})">View
													Detail</a>
											</div>
										</div>
									</div>
								</div>
								</c:forEach>
								</div>
								</div>
								</div>
								
						<!-- /list -->
						
						<!-- pagination -->
						<div class="row">
							<div class="col">
								<ul class="pagination">
									<li class="page-item active"><a class="page-link"
										href="#!">1 <span class="sr-only">(current)</span></a></li>
									<li class="page-item" aria-current="page"><a
										class="page-link" href="#!">2</a></li>
									<li class="page-item"><a class="page-link" href="#!">3</a></li>
									<li class="page-item"><a class="page-link" href="#!">4</a></li>
								</ul>
							</div>
						</div>
						<!-- /pagination -->
					</div>
					<!-- /content -->
				</div>
			</div>
		</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/user/include/footer.jsp"%>
</body>
</html>
