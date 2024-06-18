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
	<!-- 상태,적립금, 내용, 주문번호, 적용일시 -->
    <title>Point</title>
    <style>
    	input[type='date']::before {
		  content: attr(data-placeholder);
		  width: 100%;
		}
		input[type='date']:focus::before,
		input[type='date']:valid::before {
		  display: none;
		}
		table>th{
			text-align: center;
		}
		.pointAccum{
			color: blue;
		}
		.pointConsume{
			color: red;
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
	<div class="row gutter-4">
    	<div class="col-12">
    		<!-- title -->
   			<h3 class="mb-0">Point</h3>
   			<!-- /title -->
   			<!-- search filter -->
   			<div class="search-filter">
		   		<div>
		   			<input type="date" class="btn btn-outline-secondary btn-sm">
		   			&nbsp;-&nbsp; 
		   			<input type="date" class="btn btn-outline-secondary btn-sm"/>
		   		</div>
				<div><span class="eyebrow">8 entries</span></div>
   			</div>
   			<!-- /search filter -->
   		</div>
   		<!-- list -->
	   	<div class="pointList col-12">
	   		
	   		<table class="table">
	   			<thead>
	   				<tr>
						<th>상태</th>
						<th>적립</th>
						<th>내용</th>
						<th>주문번호</th>
						<th>적용일</th>
					</tr>
	   			</thead>
	   				<tr>
	   					<td class="pointAccum">적립</td>
	   					<td class="pointAccum">+ 1000</td>
	   					<td>적립 사유 및 사용 내용</td>
	   					<td>123</td>
	   					<td>2023-11-12 11:00:12</td>
	   				</tr>
	   				
	   				<tr>
	   					<td class="pointConsume">사용</td>
	   					<td class="pointConsume">- 1000</td>
	   					<td>적립 사유 및 사용 내용</td>
	   					<td>111</td>
	   					<td>2023-11-12 11:00:12</td>
	   				</tr>

	   			<tbody>
	   			</tbody>
	   		
	   		</table>
	   		
				
			
	   		
	   		
	   		
	   		
	   		
				
	   		
	   		
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
    