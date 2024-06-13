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

    <title>Order</title>
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
						<option value="">주문상태</option>
						<option value="상품준비중">상품준비중</option>
						<option value="배송중">배송중</option>
						<option value="배송완료">배송완료</option>
						<option value="구매확정">구매확정</option>
						<option value="취소요청/완료">취소요청/완료</option>
					</select>
				</div>
				<div><span class="eyebrow">8 entries</span></div>
   			</div>
   			<!-- /search filter -->
   		</div>
   		<!-- list -->
	   	<div class="orderList row gutter-2">
	   		
	   		
	   		<div class="col-12">
				<div class="order">
					<div class="order-head">
						<span>Order No.165342</span>
				     	<span>2021-12-19 12:11:11</span>
					</div>
					<div class="row align-items-center">
						<div class="order-itemImgBox col-lg-3">
							<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
						</div>
						
				        <div class="col-lg-6">
				        	<h3 class="order-number">황새픽비누 외 3개</h3>
				        	<br>
				        	<p>9,500 원</p>
				     		<p>총 8개</p>	
				        	
				   		</div>
	
				        <div class="col-lg-3">
				        	
				        	<span class="order-status ">상품준비중<br></span>
				        		<!-- <span class="order-status sent">배송완료</span> -->
				     		<span class="order-status canceled">최소요청</span>
				        	<br><br><br>
				        	
				        	<a href="#!" class="action eyebrow underline">View Order</a>
				   		</div>
					</div>
				</div>
			</div>
				
			<div class="col-12">	
				<div class="order">
					<div class="order-head">
						<span>Order No.165342</span>
				     	<span>2021-12-19 12:11:11</span>
					</div>
					<div class="row align-items-center">
						<div class="order-itemImgBox col-lg-3">
							<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
						</div>
						
				        <div class="col-lg-6">
				        	<h3 class="order-number">황새픽비누 외 3개</h3>
				        	<br>
				        	<p>9,500 원</p>
				     		<p>총 8개</p>	
				        	
				   		</div>
	
				        <div class="col-lg-3">
				        	
				        	
				        	<span class="order-status sent">배송완료</span>
				     		<br>
				        	<br><br><br>
				        	
				        	<a href="#!" class="action eyebrow underline">View Order</a>
				   		</div>
					</div>
				</div>
	   		</div>
	   		
	   		
	   		
	   		
	   		
				
	   		
	   		
   		</div>
   		<!-- /list -->
   	</div>
	<!-- /content -->
							
						
					
					
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
			        <!-- /pagination -->
				</div>
			</div>
		</div>
		
	</section>
    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
    