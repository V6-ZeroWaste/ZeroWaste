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
			padding-top:100px
		}
		.order-status.shipping::before {
			background: #F5BE17; 
		}
		tr{
			border-bottom: solid lightgray 0.5px;
		}
		th{
			width: 200px;
		}
		td{
			align-content:center;
		}
    	
    </style>
    <script>
    	function orderConfirm(no){
    		if(confirm("구매확정 시 되돌릴 수 없습니다. 구매확정 하시겠습니까?")){
                $.ajax({
                    url : "/mypage/order/detail/confirm",
                    type : "POST",
                    data : JSON.stringify({
                    	order_detail_no : no,
                    	order_no : ${order.order_no
                    		}
                    	}),
                    dataType: "text",
                    contentType: "application/json; charset=UTF-8",
                    success : function(response){
                        alert(response);
                        window.location.reload();
                    },
                    error: function(xhr, status, error){
                        console.log(error)
                    }
                });
            }
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
		            
		                
    
    <!-- content -->
	<div class="row">
    	<div class="col-12">
    		<!-- title -->
    		<div  style="display:flex;justify-content: space-between;">
	   			<h3 class="mb-0">Order Detail</h3>
	   			<button class="btn btn-primary" onclick="location.href='/mypage/order/list'">go list</button>
   			</div>
   			<!-- /title -->
   			<!-- Order Info -->
   			<div class="order-head">
						<span>Order No.${order.order_no }</span>
				     	<span><fmt:formatDate value="${order.payment_date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/></span>
			</div>
			<!-- Order Info -->
   		</div>
   		<!-- item info area -->
   		<div class="col-12">
   		<div class="itemInfo area">
   			<h4 class="mb-0">Item Info</h4>
	   		<table class="table table-borderless">
	                      <tbody>
 	                      	<c:forEach var="vo" items="${list}">
	                      		<tr>
	                      			<td>
	                      				<%-- <a href="/item/detail?item_no=${vo.item_no}"><img class="order-itemImg" src="/upload/item_img/${vo.item_img}" alt="item-img"></a> --%>
	                      				<img class="order-itemImg" src="${vo.item_img}" alt="item-img">
	                      			</td>
	                      			<td>
			                          	<strong>${vo.item_name}</strong><br>
			                          	<span>${vo.packing_status == 1? "포장 (+2,000원)" : "" }&nbsp;&nbsp;<span><br>
			                          	<span>${vo.amount} 개</span>
			                        </td>
			                        <td><fmt:formatNumber value="${(vo.packing_status==1? vo.price+2000:vo.price)*vo.amount }" pattern="#,###" /> 원</td>
			                        <c:if test="${vo.cancel_status != null}">
			                        	<td><span class="order-status canceled">${vo.cancel_status == 0 ? '취소요청' : '취소완료'}</span></td>
			                        	<td><button type="button" class="btn btn-outline-danger" onclick="location.href='/order/cancel/info?order_detail_no=${vo.order_detail_no}'">취소상세</button></td>
			                        </c:if>
			                        <c:if test="${vo.cancel_status == null}">
			                        	<c:if test="${vo.confirm_date == null }">
			                        		
			                        		<c:if test="${order.delivery_status == 0}">
					                        	<td><span class="order-status">상품준비중</span></td>
					                         	<td><button type="button" class="btn btn-danger" onclick="location.href='/order/cancel/form?order_detail_no=${vo.order_detail_no}'">주문취소</button></td>
			                        		</c:if>
			                        		<c:if test="${order.delivery_status == 1}">
			                        			<td><span class="order-status shipping">배송중</span></td>
	                          					<td><button type="button" class="btn btn-primary" onclick="orderConfirm(${vo.order_detail_no});">구매확정</button></td>
			                        		</c:if>
			                        		<c:if test="${order.delivery_status == 2}">
	                          					<td><span class="order-status sent">배송완료</span></td>
	                          					<td><button type="button" class="btn btn-primary" onclick="orderConfirm(${vo.order_detail_no});">구매확정</button></td>
			                        		</c:if>
			                        	</c:if>
			                        	<c:if test="${vo.confirm_date != null }">
			                        		<td><span class="order-status sent">구매확정</span></td>
			                        		<td>
				                        		<c:if test="${vo.review_no == null}">
				                        			<button type="button" class="btn btn-primary"  onclick="location.href='/mypage/review/post?order_detail_no=${vo.order_detail_no}&item_no=${vo.item_no}'">리뷰작성</button>
				                        		</c:if>
				                        		<c:if test="${vo.review_no != null}">
				                        			<button type="button" class="btn btn-outline-primary" onclick="location.href='/mypage/review/detail?review_no=${vo.review_no}'">리뷰상세</button>
				                        		</c:if>
			                        		</td>
			                        	</c:if>
			                        </c:if>
			                        
	                      		</tr>
	                      		
	                      	</c:forEach>
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
	                      		<td>${order.receiver_name}</td>
	                        </tr>
	                      	<tr>
	                      		<th>연락처</th>
	                      		<td>${order.receiver_tel}</td>
	                        </tr>
	                      	<tr>
	                      		<th>배송지 주소</th>
	                      		<td>
	                      			${order.zipcode}
	                      			<br>${order.addr}
	                      			<br>${order.addr_detail}
	                      		</td>
	                        </tr>
	                      	<tr>
	                      		<th>배송 메시지</th>
	                      		<td>${order.delivery_request }</td>
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
	                      		<td><fmt:formatNumber value="${order.payment_price +order.point - order.delivery_price}" pattern="#,###" /> 원</td>
	                        </tr>
	                      	<tr>
	                      		<th>배송비</th>
	                      		<td><fmt:formatNumber value="${order.delivery_price }" pattern="#,###" /> 원</td>
	                        </tr>
	                      	<tr>
	                      		<th>적립금 사용</th>
	                      		<td><fmt:formatNumber value="${order.point }" pattern="#,###" /> 원</td>
	                        </tr>
	                      	<tr>
	                      		<th>최종 결제 금액</th>
	                      		<td>
	                      			<strong><fmt:formatNumber value="${order.payment_price}" pattern="#,###" /> 원</strong>
	                      			<br><span>예상 적립금 <fmt:formatNumber value="${Math.floor((order.payment_price-order.refund_price - (order.payment_price == order.refund_price ? 0 : 3000)) *0.03)}" pattern="#,###" /> 원</span>
	                      		</td>
	                        </tr>
	                      	<tr>
	                      		<th>결제 수단</th>
	                      		<td>${order.payment_method}</td>
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
    