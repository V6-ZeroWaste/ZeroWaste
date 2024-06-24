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

<title>soaff mypage Review</title>
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

.review-info {
	position: relative;
	padding-left: 1.25rem;
	font-size: 0.875rem;
}

.col-12 {
	margin-bottom: 10px;
}

.order {
	height: 100px;
}

.pagination .page-item.active .page-link {
	border: 2px solid #000; 
	font-weight: bold; 
}

.disable-link {
	pointer-events: none;
}
</style>
<script type="text/javascript">
   let page = 1;
   window.onload = function() {
	    getList();
	    $('#searchButton').on('click', applyCondition); 
	};

   function redirectToDetail(reviewNo) {
      window.location.href = '/mypage/review/detail?review_no=' + reviewNo;
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
	        startDate: $('#startDate').val().trim(),
	        endDate: $('#endDate').val().trim(),
	        page: page
	    }

	    $.ajax({
	        type: "GET",
	        url: "/mypage/review/getList",
	        data: data,
	        dataType: "json",
	        success: function(resp) {
	            $("#printList").html(resp.printList);
	            
	            // 페이지네이션 출력
	            $(".datatable-info").html(
	                "Showing " +
	                ((page - 1) * 10 + 1) +
	                " to " +
	                (page * 10 <= resp.total ? page * 10 : resp.total) +
	                " of " +
	                resp.total + " entries"
	            );

	            let printPage = "";
	            if (resp.isPrev) {
	                printPage += '<li class="datatable-pagination-list-item">';
	                printPage += '<a data-page="1" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
	                printPage += '<li class="datatable-pagination-list-item">';
	                printPage += '<a data-page="' + (resp.startPage - 1) + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
	            }
	            for (let i = resp.startPage; i <= resp.endPage; i++) {
	                printPage += '<li class="datatable-pagination-list-item' + (i == page ? ' datatable-active' : '') + '">';
	                printPage += '<a data-page="' + i + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">' + i + '</a></li>';
	            }
	            if (resp.isNext) {
	                printPage += '<li class="datatable-pagination-list-item">';
	                printPage += '<a data-page="' + (resp.endPage + 1) + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">›</a></li>';
	                printPage += '<li class="datatable-pagination-list-item">';
	                printPage += '<a data-page="' + resp.totalPage + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">››</a></li>';
	            }
	            $(".datatable-pagination-list").html(printPage);
	            
	        },
	        error: function(data, textStatus) {
	            $('#fail').html("관리자에게 문의하세요."); // 서버 오류
	            console.log('error', data, textStatus);
	        }
	    });
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
							<!-- title -->
							<h3 class="mb-0">Review</h3>
							<!-- /title -->
							<!-- search filter -->
							<div class="search-filter">
								<div>
									<input type="date" id="startDate"
										class="btn btn-outline-secondary btn-sm">
									&nbsp;-&nbsp; <input type="date" id="endDate"
										class="btn btn-outline-secondary btn-sm" />
										<button id="searchButton" class="btn btn-primary btn-sm">검색</button>
								</div>
								<div>
									<div>
										<span class="eyebrow">${map.total } entries</span>
									</div>
								</div>
								
								
							</div>
							<!-- /search filter -->
						</div>

						<!-- list -->
						<div class="col-12">
							<c:forEach var="list" items="${map.list}">
								<div class="col-12">
									<div class="order">
										<div class="row align-items-center">
											<div class="col-lg-2 order-preview justify-content-center">
												<!-- 상품이미지 -->
												<a href="product-1.html"
													title="${list.item_name }"  class="disable-link"
													data-toggle="tooltip" data-placement="top"> <img
													src="${list.item_img}">
												</a>
											</div>
											<div class="col-lg-4">
												<h3 class="order-number">${list.item_name}</h3>
											</div>
											<div class="col-lg-4">
												<span class="review-info"><fmt:formatDate
														value="${list.regist_date}" pattern="yyyy-MM-dd" /></span> <br>
												<span class="review-info">${list.title}</span> <br> <span
													class="review-info"> <c:forEach var="i" begin="1"
														end="${list.score}">
                                                ⭐️
                                             </c:forEach>
												</span>
											</div>
											<div class="col-lg-2">
												<a href="#!" class="action eyebrow underline"
													onclick="redirectToDetail(${list.review_no})">View
													Detail</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<!-- /list -->

					<!-- pagination -->
					<div class="row">
						<div class="col-auto">
							<ul class="pagination">
								<c:if test="${map.isPrev}">
									<li class="page-item"><a class="page-link"
										href="/mypage/review/list?page=1">‹‹</a></li>
									<li class="page-item"><a class="page-link"
										href="/mypage/review/list?page=${map.startPage-1}">‹</a></li>
								</c:if>
								<c:forEach var="i" begin="${map.startPage}"
									end="${map.endPage }">
									<c:if test="${map.currentPage==i}">
										<li class="page-item active"><a class="page-link">${i }<span
												class="sr-only">(current)</span></a></li>
									</c:if>
									<c:if test="${map.currentPage!=i}">
										<li class="page-item"><a class="page-link"
											href="/mypage/review/list?page=${i}">${i }</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${map.isNext}">
									<li class="page-item"><a class="page-link"
										href="/mypage/review/list?page=${map.endPage+1}">›</a></li>
									<li class="page-item"><a class="page-link"
										href="/mypage/review/list?page=${map.totalPage}">››</a></li>
								</c:if>
							</ul>
						</div>
					</div>
					<!-- /pagination -->
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/user/include/footer.jsp"%>
</body>
</html>
