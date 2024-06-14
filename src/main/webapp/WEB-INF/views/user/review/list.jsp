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

    <title>Reviews</title>
    <style>
		.search-filter>div{
			margin:10px 0px 10px 0px;
		}
		.review-info{
			position: relative;
		    padding-left: 1.25rem;
		    font-size: 0.875rem;
		}
		.col-12{
			margin-bottom: 10px;
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
	<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/user/include/mypageInfo.jsp" %>
	<section class="pt-5">
    	<div class="container">
    		<div class="row gutter-4 justify-content-between">
				<%@ include file="/WEB-INF/views/user/include/mypageNav.jsp" %>
				<div class="col-lg-9">
		            
		              <!-- <div class="col"> -->
		                
    
    <!-- content -->
		<div class="row">
    	<div class="col-12">
    		<!-- title -->
   			<h3 class="mb-0">리뷰</h3>
   			<!-- /title -->
   			<!-- search filter -->
   			<div class="search-filter">
		   		<div>
		   			<input type="date" class="btn btn-outline-secondary btn-sm">
		   			&nbsp;-&nbsp; 
		   			<input type="date" class="btn btn-outline-secondary btn-sm"/>
		   		</div>
				<div><span class="eyebrow">
 <span><strong>총 ${map.total}개</strong> |
                                    ${reviewVO.page}/${map.totalPage}페이지</span>

</span></div>
   			</div>
   			<!-- /search filter -->
   		</div>
   		
   		<!-- list -->
	   	<!-- <div class="reviewList row gutter-2"> -->
	   		
	   		<!-- review card -->
	   		<div class="col-12">
              <div class="order">
                <div class="row align-items-center">
                  <div class="col-lg-2 order-preview justify-content-center">
                  	<!-- 상품이미지 -->
                  	<a href="product-1.html" title="Fawn Wool / Natural Mammoth Chair" data-toggle="tooltip" data-placement="top">
                  		<img src="/user/images/demo/product-1.jpg" alt="Fawn Wool / Natural Mammoth Chair">
                  	</a>
                  </div>
                ㅏ
                  <div class="col-lg-4">
                  
                  
                    <h3 class="order-number">${list.item_name}</h3>
                  </div>
                  <div class="col-lg-4">
                    <span class="review-info"><fmt:formatDate value="${list.regist_date}"
                                                   pattern="yyyy-MM-dd" /></span>
                    <br>
                    <span class="review-info">${list.title}</span>
                    <br>
                    <span class="review-info">⭐️⭐️⭐️⭐️">
                    </span>
                  </div>
                  <div class="col-lg-2">
                    <a href="#!" class="action eyebrow underline">View Detail</a>
                  </div>
                </div>
              </div>
            </div>
            <!-- /review card -->
            
			<!-- review card -->
	   		<div class="col-12">
              <div class="order">
                <div class="row align-items-center">
                  <div class="col-lg-2 order-preview justify-content-center">
                  	<!-- 상품이미지 -->
                  	<a href="product-1.html" title="Fawn Wool / Natural Mammoth Chair" data-toggle="tooltip" data-placement="top">
                  		<img src="/user/images/demo/product-1.jpg" alt="Fawn Wool / Natural Mammoth Chair">
                  	</a>
                  </div>
                  <div class="col-lg-4">
                    <h3 class="order-number">Item name</h3>
                  </div>
                  <div class="col-lg-4">
                    <span class="review-info">2023-11-11 12:00:12</span>
                    <br>
                    <span class="review-info">review title</span>
                    <br>
                    <span class="review-info">⭐️⭐️⭐️⭐️</span>
                  </div>
                  <div class="col-lg-2">
                    <a href="#!" class="action eyebrow underline">View Detail</a>
                  </div>
                </div>
              </div>
            </div>
            <!-- /review card -->
	   		

	   		
   		</div>
   		<!-- /list -->
 
							
						
					
					
					<!-- pagination -->
			   		<div class="row">
			        	<div class="col">
			            	<ul class="pagination">
			                	<li class="page-item active"><a class="page-link" href="#!">1 <span class="sr-only">(current)</span></a></li>
			                    <li class="page-item" aria-current="page"><a class="page-link" href="#!">2</a></li>
			                    <li class="page-item"><a class="page-link" href="#!">3</a></li>
			                    <li class="page-item"><a class="page-link" href="#!">4</a></li>
			                </ul>
			            </div>
			        </div>
			        </div>
			        <!-- /pagination -->
				</div>
				<!-- /content -->
			</div>
			<!-- </div> -->
		
	</section>
    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>  