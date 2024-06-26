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

    <title>soaff mypage order</title>
    <style>
    	input[type='date']::before {
		  content: attr(data-placeholder);
		  width: 100%;
		}
		input[type='date']:focus::before,
		input[type='date']:valid::before {
		  display: none;
		}
		.order-itemImg{
			max-width: 180px;
			max-height: 180px;
			margin:auto;
		}
		.order-itemImgBox{
			width:200px;
			height:200px;
			padding:10px;
		}
		
		.order-head{
			display:flex;
			justify-content: space-between;
			border-bottom:1px solid #dddddd;
			padding:10px
		}
		.search-filter>div{
			margin:10px 0px 10px 0px;
		}
		.order-status.shipping::before {
			background: #F5BE17; 
		}
    	
    </style>
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
				   			<h3 class="mb-0">Order</h3>
				   			<!-- /title -->
				   			<!-- search filter -->
				   			<div class="search-filter">
						   		<div>
						   			<input type="date" class="btn btn-outline-secondary btn-sm">
						   			&nbsp;-&nbsp; 
						   			<input type="date" class="btn btn-outline-secondary btn-sm"/>
						   		</div>
				                <div class="dorpdown">
									<select id="orderBy" name="orderBy" class="btn btn-outline-secondary btn-sm dropdown-toggle" onchange="applyCondition();">
										<option value="">전체상태</option>
										<option value="상품준비중">상품준비중</option>
										<option value="배송중">배송중</option>
										<option value="배송완료">배송완료</option>
										<option value="구매확정">구매확정</option>
										<option value="취소요청/완료">취소요청/완료</option>
									</select>
								</div>
								<div><span class="eyebrow">${map.total } entries</span></div>
				   			</div>
				   			<!-- /search filter -->
				   		</div>
				   		<div class="col-12">
				   		<!-- list -->
					   	<div class="orderList row gutter-2">
					   		<c:if test="${map.total==0}">
					   			<div class="col-12" style="text-align: center; padding:100px;">
					   					Empty
					   			</div>
					   		</c:if>
					   		<c:forEach var="vo" items="${map.list}">
								<div class="col-12">
								<div class="order">
									<div class="order-head">
										<span>Order No.${vo.order_no}</span>
							     	<span><fmt:formatDate value="${vo.payment_date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/></span>
									</div>
									<div class="row align-items-center">
										<div class="order-itemImgBox col-lg-3">
											<img class="order-itemImg" src="${vo.item_img}" alt="item-img">
											<%-- <img class="order-itemImg" src="/upload/item_img/${vo.item_img}" alt="item-img"> --%>
										</div>
										
								        <div class="col-lg-6">
								        	<h3 class="order-number">${vo.order_name}</h3>
								        	<br>
								        	<p><fmt:formatNumber value="${vo.total_item_price + 3000원}" pattern="#,###" /> 원</p>
								     		<p>총 ${vo.total_amount}개</p>	
								   		</div>
					
								        <div class="col-lg-3">
								        	<c:if test="${vo.item_amount != vo.cancel_count}">
									        	<c:if test="${vo.order_status==0}">
									        		<span class="order-status">상품준비</span><br>
									        	</c:if>
									        	<c:if test="${vo.order_status==1}">
									        		<span class="order-status shipping">배송중</span><br>
									        	</c:if>
									        	<c:if test="${vo.order_status==2}">
									        		<span class="order-status sent">배송완료</span><br>
									        	</c:if>
									        	<c:if test="${vo.order_status==3}">
									        		<span class="order-status sent">구매확정</span><br>
									        	</c:if>
									        </c:if>
									        <c:if test="${vo.cancel_count!=0 }">
									        <script>
									        	console.log(${vo.cancel_status})
									        </script>
									        	<c:if test="${vo.cancel_status==0}">
									        	<script>
									        	console.log(${vo.cancel_status})
									        	</script>
										        	<span class="order-status canceled">취소요청</span>
									        	</c:if>
												<c:if test="${vo.cancel_status==2}">
										        	<span class="order-status canceled">취소완료</span>
									        	</c:if>
								        	</c:if>
									        <br><br><br><br><br>
								        	
								        	
								        	<a href="/mypage/order/detail?order_no=${vo.order_no}" class="action eyebrow underline">View Order</a>
								   		</div>
									</div>
								</div>
							</div>
					   		</c:forEach>
					   		
				   		</div>
				   		<!-- /list -->
				   		</div>
				   	</div>
					<!-- /content -->
							
					<!-- pagination -->
			   		<div class="row">
			        	<div class="col">
			            	<ul class="pagination">
			            		<c:if test="${map.isPrev}">
			            			<li class="page-item"><a class="page-link" href="/mypage/order/list?page=1">‹‹</a></li>
			            			<li class="page-item"><a class="page-link" href="/mypage/order/list?page=${map.startPage-1}">‹</a></li>
			            		</c:if>
			            		<c:forEach var="i" begin="${map.startPage}" end="${map.endPage }">
			            			<c:if test="${map.currentPage==i}">
			            				<li class="page-item active"><a class="page-link">${i }<span class="sr-only">(current)</span></a></li>
			            			</c:if>
			            			<c:if test="${map.currentPage!=i}">
			            				<li class="page-item"><a class="page-link" href="/mypage/order/list?page=${i}">${i }</a></li>
			            			</c:if>
			            		</c:forEach>
			            		<c:if test="${map.isNext}">
			            			<li class="page-item"><a class="page-link" href="/mypage/order/list?page=${map.endPage+1}">›</a></li>
			            			<li class="page-item"><a class="page-link" href="/mypage/order/list?page=${map.totalPage}">››</a></li>
			            		</c:if>
			                </ul>
			            </div>
			        </div>
			        <!-- /pagination -->
				</div>
			</div>
		</div>
		
	</section>
    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
    