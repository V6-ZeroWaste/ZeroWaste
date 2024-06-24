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

<title>soaff mypage QnA</title>

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

.disable-link {
	pointer-events: none;
}

.search-filter .search-container {
	display: flex;
	align-items: center;
	gap: 10px;
}

.search-filter .search-container input[type="search"] {
	height: 36px;
	border-radius: 4px;
	border: 1px solid #ced4da;
	padding: 0 10px;
}

.search-filter .search-container .btn-search {
	height: 30px;
	border-radius: 4px;
	border: none;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
}
</style>
<script type="text/javascript">
	let page = 1;
	let filter = null;
	
	window.onload = function() {
		const urlParams = new URLSearchParams(window.location.search);
		filter = urlParams.get('filter');
		if (filter !== null && filter !== "") {
			$('#filter').val(filter);
		} else {
			$('#filter').val("");
		}
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
	    var orderByValue = $('#orderBy').val();
	    var filterValue = $('#filter').val();
	    if (orderByValue === "") {
	        orderByValue = null;
	    }

	    var data = {
	        searchWord : $('#searchWord').val(),
	        orderBy : orderByValue,
	        filter : filterValue !== "" ? filterValue : null, 
	        start_date : $('#start_date').val(),
	        end_date : $('#end_date').val(),
	        page : page,
	    }

	    $.ajax({
	        type : "GET",
	        url : "/mypage/qna/getList",
	        data : data,
	        dataType : "json",
	        success : function(resp) {
	            let printList = "";
	            if (resp.list.length == 0) {
	                printList = "<td class='first' colspan='10' style='text-align: center;'>등록된 글이 없습니다.</td>";
	            } else {
	                resp.list.forEach(function(qna) {
	                    printList += `
	                        <tr onclick="location.href='/mypage/qna/detail?qna_no=${qna.qna_no}'">
	                        <td><c:if test="${qna.qna_img != null && qna.qna_img != ''}"><img src="${qna.qna_img}"/></c:if></td>

	                            <td>${qna.item_name}</td>
	                            <td>${qna.title}</td>
	                            <td>${qna.typeString}</td>
	                            <td>${qna.user_id}</td>
	                            <td>${qna.question_date}</td>
	                            <td>${qna.replyState}</td>
	                        </tr>`;
	                });
	            }

	            $("#printList").html(printList);
	            $(".datatable-info").html(
	                `Showing ${(page - 1) * 10 + 1} to ${(page * 10 <= resp.count ? page * 10 : resp.count)} of ${resp.count} entries`
	            );

	            // 페이지네이션 업데이트
	            let printPage = "";
	            if (resp.isPrev) {
	                printPage += '<li class="datatable-pagination-list-item">';
	                printPage += '<a data-page="1" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
	                printPage += '<li class="datatable-pagination-list-item">';
	                printPage += '<a data-page="' + (resp.startPage - 1) + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
	            }
	            for (let i = resp.startPage; i <= resp.endPage; i++) {
	                printPage += `<li class="datatable-pagination-list-item${i == page ? ' datatable-active' : ''}">
	                    <a data-page="${i}" class="datatable-pagination-list-item-link" onclick="changePage(this);">${i}</a></li>`;
	            }
	            if (resp.isNext) {
	                printPage += '<li class="datatable-pagination-list-item">';
	                printPage += '<a data-page="' + (resp.endPage + 1) + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">››</a></li>';
	                printPage += '<li class="datatable-pagination-list-item">';
	                printPage += '<a data-page="' + resp.totalPage + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">›</a></li>';
	            }
	            $(".datatable-pagination-list").html(printPage);

	            const newUrl = '/mypage/qna/list?filter=' + (data.filter !== null ? data.filter : '');
	            history.pushState(null, '', newUrl);
	        },
	        error : function(data, textStatus) {
	            $('#fail').html("관리자에게 문의하세요.");
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
							<h3 class="mb-0">QnA</h3>
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
												<option value="" hidden>정렬</option>
												<option value="최신순"
													<c:if test="${qnaVO.orderBy == '최신순'}">selected</c:if>>최신순</option>
												<option value="오래된순"
													<c:if test="${qnaVO.orderBy == '오래된순'}">selected</c:if>>오래된순</option>
										</select>
										</label> <label> <select id="filter" name="filter"
											class="datatable-selector" onchange="applyCondition();">
												<option value="">전체보기</option>
												<option value="답변대기">답변대기</option>
												<option value="답변완료">답변완료</option>
										</select>
										</label>
									</div>
									<div class="search-container">
										<input id="searchWord" name="searchWord"
											class="datatable-input" type="search" placeholder="상품명/문의 제목"
											<c:if test="${qnaVO.searchWord} != null">value=${qnaVO.searchWord}</c:if>
											onkeyup="if(window.event.keyCode==13){applyCondition();}"
											style="width: 250px"> <input type="button" value="검색"
											class="btn btn-primary" onclick="applyCondition()">
									</div>
								</div>
								<div>
									<span class="eyebrow">${map.count } entries</span>
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
												<a href="product-1.html" title="${list.item_name }"
													class="disable-link" data-toggle="tooltip"
													data-placement="top"> <img src="${list.item_img}">
												</a>
											</div>
											<div class="col-lg-4">
												<h3 class="order-number">${list.item_name}</h3>
											</div>
											<div class="col-lg-4">
												<span class="qna-info">${list.question_date}</span> <br>
												<span class="qna-info">${list.title}</span> <br> <span
													class="qna-info">${list.replyState}</span>
											</div>
											<div class="col-lg-2">
												<a href="#!" class="action eyebrow underline"
													onclick="redirectToDetail(${list.qna_no})">View Detail</a>
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
						<div class="col">
							<ul class="pagination">
								<c:if test="${map.isPrev}">
									<li class="page-item"><a class="page-link"
										href="/mypage/qna/list?page=1">‹‹</a></li>
									<li class="page-item"><a class="page-link"
										href="/mypage/qna/list?page=${map.startPage-1}">‹</a></li>
								</c:if>
								<c:forEach var="i" begin="${map.startPage}"
									end="${map.endPage }">
									<c:if test="${map.currentPage==i}">
										<li class="page-item active"><a class="page-link">${i }<span
												class="sr-only">(current)</span></a></li>
									</c:if>
									<c:if test="${map.currentPage!=i}">
										<li class="page-item"><a class="page-link"
											href="/mypage/qna/list?page=${i}">${i }</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${map.isNext}">
									<li class="page-item"><a class="page-link"
										href="/mypage/qna/list?page=${map.endPage+1}">›</a></li>
									<li class="page-item"><a class="page-link"
										href="/mypage/qna/list?page=${map.totalPage}">››</a></li>
								</c:if>
							</ul>
						</div>
					</div>
					<!-- /pagination -->
				</div>
				<!-- /content -->
			</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/user/include/footer.jsp"%>
</body>
</html>
