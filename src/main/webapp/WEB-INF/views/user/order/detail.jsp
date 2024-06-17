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

    <title>Order Detail</title>
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
			max-width: 80px;
			max-height: 80px;
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
			padding:10px;
			margin-top:20px;
		}
		.search-filter>div{
			margin:10px 0px 10px 0px;
		}
		.area{
			padding-top:50px
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
		            
		                
    
    <!-- content -->
	<div class="row">
    	<div class="col-12">
    		<!-- title -->
    		<div  style="display:flex;justify-content: space-between;">
	   			<h3 class="mb-0">Order Detail</h3>
	   			<button class="btn btn-primary" onclick="history.back()">go list</button>
   			</div>
   			<!-- /title -->
   			<!-- Order Info -->
   			<div class="order-head">
						<span>Order No.165342</span>
				     	<span>2021-12-19 12:11:11</span>
			</div>
			<!-- Order Info -->
   		</div>
   		<!-- item info area -->
   		<div class="col-12">
   		<div class="itemInfo area">
   			<h4 class="mb-0">Item Info</h4>
	   		<table class="table table-borderless">
	                      <tbody>
	                      	<tr>
	                          <td>
	                          	<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
	                          </td>
	                          <td>
	                          	<strong>황새 추천 비누</strong><br>
	                          	<span>3 개</span>
	                          </td>
	                          <td>30,000 원</td>
	                          <td><span class="order-status canceled">취소요청</span></td>
	                          <td><button type="button" class="btn btn-outline-danger">취소상세</button></td>
	                        </tr>
	                        
	                        
	                        
	                      	<tr>
	                          <td>
	                          	<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
	                          </td>
	                          <td>
	                          	<strong>황새 추천 비누</strong><br>
	                          	<span>3 개</span>
	                          </td>
	                          <td>30,000 원</td>
	                          <td><span class="order-status canceled">취소승인</span></td>
	                          <td><button type="button" class="btn btn-outline-danger">취소상세</button></td>
	                        </tr>
	                        
	                        
	                        
	                        
	                      	<tr>
	                          <td>
	                          	<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
	                          </td>
	                          <td>
	                          	<strong>황새 추천 비누</strong><br>
	                          	<span>3 개</span>
	                          </td>
	                          <td>30,000 원</td>
	                          <td><span class="order-status">상품준비중</span></td>
	                          <td><button type="button" class="btn btn-danger">주문취소</button></td>
	                        </tr>	                        
	                        
	                        
	                        
	                      	<tr>
	                          <td>
	                          	<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
	                          </td>
	                          <td>
	                          	<strong>황새 추천 비누</strong><br>
	                          	<span>3 개</span>
	                          </td>
	                          <td>30,000 원</td>
	                          <td><span class="order-status shipping">배송중</span></td>
	                          <td><button type="button" class="btn btn-primary">구매확정</button></td>
	                        </tr>	                        
	                        
	                        
	                        
	                      	<tr>
	                          <td>
	                          	<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
	                          </td>
	                          <td>
	                          	<strong>황새 추천 비누</strong><br>
	                          	<span>3 개</span>
	                          </td>
	                          <td>30,000 원</td>
	                          <td><span class="order-status sent">배송완료</span></td>
	                          <td><button type="button" class="btn btn-primary">구매확정</button></td>
	                        </tr>	                        
	                        
	                        
	                        
	                      	<tr>
	                          <td>
	                          	<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
	                          </td>
	                          <td>
	                          	<strong>황새 추천 비누</strong><br>
	                          	<span>3 개</span>
	                          </td>
	                          <td>30,000 원</td>
	                          <td><span class="order-status sent">구매확정</span></td>
	                          <td><button type="button" class="btn btn-primary">리뷰작성</button></td>
	                        </tr>	                        
	                        
	                        
	                        
	                      	<tr>
	                          <td>
	                          	<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
	                          </td>
	                          <td>
	                          	<strong>황새 추천 비누</strong><br>
	                          	<span>3 개</span>
	                          </td>
	                          <td>30,000 원</td>
	                          <td><span class="order-status sent">구매확정</span></td>
	                          <td><button type="button" class="btn btn-outline-primary">리뷰상세</button></td>
	                        </tr>
	                      </tbody>
	                    </table>
	   		</div>
	   	</div>
   		<!-- /item info area -->
   		
   		<!--  Delivery info area -->
   		<div class="col-12">
   		<div class="itemInfo area">
   			<h4 class="mb-0">Delivery Info</h4>
	   		<table class="table table-borderless">
	                      <tbody>
	                      	<tr>
	                      		<th>이름</th>
	                      		<td>user name</td>
	                        </tr>
	                      	<tr>
	                      		<th>연락처</th>
	                      		<td>010-1234-1234<td>
	                        </tr>
	                      	<tr>
	                      		<th>배송지 주소</th>
	                      		<td>
	                      			000-000
	                      			<br>서울특별시 마포구 양화로 180
	                      			<br>123동 1234호
	                      		</td>
	                        </tr>
	                      	<tr>
	                      		<th>배송 메시지</th>
	                      		<td>부재중이면 문 앞에 놔주세여</td>
	                        </tr>
	                      </tbody>
	                    </table>
	   		</div>
	   	</div>
   		<!-- /Delivery info area -->
   		
   		<!--  payment info area -->
   		<div class="col-12">
   		<div class="itemInfo area">
   			<h4 class="mb-0">Payment Info</h4>
	   		<table class="table table-borderless">
	                      <tbody>
	                      	<tr>
	                      		<th>상품 합계</th>
	                      		<td>180,000 원</td>
	                        </tr>
	                      	<tr>
	                      		<th>배송비</th>
	                      		<td>3,000 원<td>
	                        </tr>
	                      	<tr>
	                      		<th>적립금 사용</th>
	                      		<td>1,000 원</td>
	                        </tr>
	                      	<tr>
	                      		<th>최종 결제 금액</th>
	                      		<td>
	                      			<strong>182,000 원</strong>
	                      			<br><span>예상 적립금 182원</span>
	                      		</td>
	                        </tr>
	                      	<tr>
	                      		<th>결제 수단</th>
	                      		<td>카카오페이</td>
	                        </tr>
	                      </tbody>
	                    </table>
	   		</div>
	   	</div>
   		<!-- /payment info area -->
   		
   		
   		
   	</div>
	<!-- /content -->
						
						
						
				</div>
			</div>
		</div>
		
	</section>
    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
    