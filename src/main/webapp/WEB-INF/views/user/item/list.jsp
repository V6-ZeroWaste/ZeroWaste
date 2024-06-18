<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css" />
    <link rel="stylesheet" href="/user/css/style.css" />
	  <script>

		  let page = 1;
		  window.onload=function(){
			  getList();
		  }
		  function applyCondition(){
			  page = 1;
			  getList();
		  }
		  function changePage(obj){
			  page = obj.getAttribute("data-page");
			  getList();
		  }

		  function getList(){
			  var data = {
				  searchWord: $('#searchWord').val(),
				  orderBy: $('#orderBy').val(),
				  // filter: $('#filter').val(),
                  filter: '${item.filter}',
				  page: page,

			  }
              console.log(data.filter);
			  $.ajax({
				  type: "GET", // method type
				  url: "/item/getItemList", // 요청할 url
				  data: data, // 전송할 데이터
				  dataType: "json", // 응답 받을 데이터 type
				  success : function(resp){
					  console.log("성공");
					  // 데이터 리스트 출력
					  $("#printList").html(resp.printList);

					  // 페이지네이션 출력
					  // 총 개수
					  $(".datatable-info").html("("+resp.total+"개)");
					  // 페이지네이션
					  let printPage = "";
					  if(resp.isPrev){
						  printPage += '<li class="datatable-pagination-list-item page-item">';
						  printPage += '<a data-page="1" class="datatable-pagination-list-item-link page-link" onclick="changePage(this);">‹‹</a></li>';
						  printPage += '<li class="datatable-pagination-list-item page-item">';
						  printPage += '<a data-page="'+(resp.startPage-1)+'" class="datatable-pagination-list-item-link page-link" onclick="changePage(this);">‹</a></li>';
					  }
					  for(i = resp.startPage; i<=resp.endPage; i++){
						  printPage += '<li class="datatable-pagination-list-item page-item'+(i==page? ' datatable-active' : '')+'">';
						  printPage += '<a data-page="'+ i +'" class="datatable-pagination-list-item-link page-link" onclick="changePage(this);">'+i+'</a></li>';
					  }
					  if(resp.isNext){
						  printPage += '<li class="datatable-pagination-list-item page-item">';
						  printPage += '<a data-page="'+(resp.endPage+1)+'" class="datatable-pagination-list-item-link page-link" onclick="changePage(this);">‹‹</a></li>';
						  printPage += '<li class="datatable-pagination-list-item page-item">';
						  printPage += '<a data-page="'+resp.totalPage+'" class="datatable-pagination-list-item-link page-link" onclick="changePage(this);">‹</a></li>';
					  }
					  console.log(printPage);
					  $(".datatable-pagination-list").html(printPage);



				  },
				  error:function (data, textStatus) {
					  console.log("실패");
					  $('#fail').html("관리자에게 문의하세요.") // 서버오류
					  console.log('error', data, textStatus);
				  }
			  })

		  }
	  </script>
    <title>soaff</title>
  </head>
    <body>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
        <!-- hero -->
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/main_test1.png)">
                </div>
                <div class="container">
                    <div class="row align-items-center vh-100">
                        <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
                            <h1 class="display-1 mt-1 mb-3 font-weight-light">SOAFF BEST Item <b class="d-block">Greener24</b>
                            </h1>
                            <a href="listing-full.html" class="btn btn-sm btn-white btn-action">Shop Now <span
                                    class="icon-arrow-right"></span></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/background-2.jpg)">
                </div>
                <div class="container">
                    <div class="row align-items-end align-items-center vh-100">
                        <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
                            <h1 class="display-1 mb-2 font-weight-light">Brand New <b>Sunglasses</b></h1>
                            <a href="listing-full.html" class="btn btn-sm btn-white btn-action">Shop Now <span
                                    class="icon-arrow-right"></span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="swiper-footer">
            <div class="container">
                <div class="row align-items-center mb-5">
                    <div class="col-lg-6">
                        <div class="swiper-pagination"></div>
                    </div>
                    <div class="col-lg-6 text-right">
                        <div class="swiper-navigation">
                            <div class="swiper-button-prev"></div>
                            <div class="swiper-button-next"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<!-- latest products -->
	<section>
		<div class="container">
			<div class="row">
                <div class="col text-center">
                    <c:if test="${item.category_name == null || item.category_name == ''}">
                        <h2>ALL</h2>
                    </c:if>
                    <c:if test="${item.category_name != null && item.category_name != ''}">
                        <h2>${item.category_name}</h2>
                    </c:if>
                </div>
			</div>
            <div class="datatable-dropdown row align-items-center">
                <div class="col-md-8">
                    <label>
                        <select name="orderBy" id="orderBy" class="datatable-selector form-control-sm" onchange="applyCondition();">
                            <option value="신규상품순" <c:if test="${param.orderBy == '신규상품순'}">selected</c:if>>신규상품순</option>
                            <option value="오래된상품순" <c:if test="${param.orderBy == '오래된상품순'}">selected</c:if>>오래된상품순</option>
                            <option value="인기상품순" <c:if test="${param.orderBy == '인기상품순'}">selected</c:if>>인기상품순</option>
                            <option value="할인율높은순" <c:if test="${param.orderBy == '할인율높은순'}">selected</c:if>>할인율높은순</option>
                            <option value="할인율낮은순" <c:if test="${param.orderBy == '할인율낮은순'}">selected</c:if>>할인율낮은순</option>
                            <option value="높은가격순" <c:if test="${param.orderBy == '높은가격순'}">selected</c:if>>높은가격순</option>
                            <option value="낮은가격순" <c:if test="${param.orderBy == '낮은가격순'}">selected</c:if>>낮은가격순</option>
                        </select>
                    </label>
<%--                    <label>--%>
<%--                        <select name="filter" id="filter" class="datatable-selector form-control-sm" onchange="applyCondition();">--%>
<%--                            <option value="">모든 카테고리</option>--%>
<%--                            <c:forEach var="category" items="${categories}">--%>
<%--                                <c:if test="${param.filter == category.category_no}">--%>
<%--                                    <option value="${category.category_no}" selected>${category.name}</option>--%>
<%--                                </c:if>--%>
<%--                                <c:if test="${param.filter != category.category_no}">--%>
<%--                                    <option value="${category.category_no}">${category.name}</option>--%>
<%--                                </c:if>--%>
<%--                            </c:forEach>--%>
<%--                        </select>--%>
<%--                    </label>--%>
                    <label class="text-sm-center datatable-info">
                         <!-- 리스트에 보이는 부분 말고 검색된 상품의 모든 개수 -->
                    </label>
                </div>
				<div class="col-md-1"></div>
                <!-- search-container 를 searchWord가 있을 때만 보이도록 수정 스크립트로 search-container 영역 [].css("display", "none"); / block -->
                <div class="col-md-3 d-flex justify-content-end">
                    <div class="form-inline search-container">
                        <input name="searchWord" id="searchWord" class="form-control form-control-sm " type="search"
                               value="${item.searchWord != null ? item.searchWord : ''}" placeholder="검색어 입력" onkeydown="if(event.key === 'Enter') applyCondition();" >
                        <input type="button" value="검색" class="btn btn-primary btn-sm" onclick="applyCondition();" >
                    </div>
                </div>
            </div>
			<div class="row gutter-2 gutter-md-3" id="printList"> <!-- printList -->
			</div>
			<div class="row">
				<div class="col text-center">
                    <!-- 페이지 네이션 영역 -->
                    <nav class="datatable-pagination">
                        <ul class="datatable-pagination-list pagination justify-content-center">
                        </ul>
                    </nav>
				</div>
			</div>
		</div>
	</section>

    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>