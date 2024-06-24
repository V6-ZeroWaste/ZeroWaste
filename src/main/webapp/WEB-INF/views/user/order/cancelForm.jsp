<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css"/>
    <link rel="stylesheet" href="/user/css/style.css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <title>soaff mypage</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>

    <style>
		.review-info{
			position: relative;
		    padding-left: 1.25rem;
		    font-size: 0.875rem;
		}
		.col-12{
			margin-bottom: 10px;
		}
		
		th{
			width: 170px;
		}
	
		.item-img{
		max-height: 99.98px;
		}
    	
    </style>
    <c:if test="${type == 'form'}">
    	<script>
    	function submit() {
            if (confirm("취소 요청을 하시겠습니까?")) {
                $.ajax({
                    url: '/order/cancel/form',
                    method: 'post',
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({
                        "cancel_reason_detail": $("#cancel_reason_detail").val(),
                        "cancel_reason_type": document.querySelector('input[name="cancelType"]:checked').value,
                        "order_detail_no": ${detail.order_detail_no}
                    }),
                    async: false,
                    success: function (res) {
                        if (res) {
                           	alert("취소 요청 완료");
                           	location.href="/order/cancel/info?order_detail_no=${detail.order_detail_no}"
                        } else {
                        	alert("취소 요청 실패");
                            
                        }
                    }
                });
            }
        }
    	</script>
    	</c:if>
  </head>
    <body>
    
    
    
    
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/user/include/mypageInfo.jsp" %>
	<section class="pt-5">
    	<div class="container">
    		<div class="row gutter-4 justify-content-between">
				<%@ include file="/WEB-INF/views/user/include/mypageNav.jsp" %>
				<div class="col-lg-9">
		            <div class="row">
		              <div class="col">
		                
    
    <!-- content -->
    <div>
    
    <!-- content -->
	<div class="row">
		<!-- title -->
    	<div class="col-12" style="display:flex;justify-content: space-between;">
   			<h3 class="mb-0">Cancel</h3>
   			<button class="btn btn-primary" onclick="location.href='/mypage/order/detail?order_no=${order.order_no}'">go order</button>
   		</div>
   		<!-- /title -->
   		
	   	
	   		<!-- item info card -->
	   		<div class="col-12">
              <div style="border: 1px solid #dddddd;">
                <div class="row align-items-center" style="min-height:100px">
                  <div class="col-lg-2 order-preview justify-content-center">
                  	<!-- 상품이미지 -->
                  	<a href="product-1.html" title="Fawn Wool / Natural Mammoth Chair" data-toggle="tooltip" data-placement="top">
                  		<img class="item-img" src="${detail.item_img}" alt="item-img">
                  	</a>
                  </div>
                  <div class="col-8">
                    <h3 class="order-number">${detail.item_name}</h3>
                  </div>
                  <div class="col-2">
                  	<!-- 상품 바로가기 링크 -->
                    <a href="/item/detail?item_no=${detail.item_no}" target="_blank" class="action eyebrow underline">View Item</a>
                  </div>
                </div>
              </div>
            </div>
            <!-- /item info card -->
            
            <!-- review detail card -->
         	<div class="col-12">
         		<div  style="border: 1px solid #dddddd;">
                    <table class="table table-borderless">
                      <tbody>
                      	<!-- 취소 사유 -->
                      	<tr>
                      		<th colspan="2"><h4 class="mb-0">Cancel Info</h4></th>
                      	</tr>
                        <tr>
	                      	<c:if test="${detail.cancel_status != null}">
	                      		<th>신청 날짜</th>
	                        	<td><fmt:formatDate value="${detail.cancel_request_date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/></td>
	                      	</c:if>
                        </tr>
                      	<tr>
							<td colspan="2">
								<div class="custom-control custom-radio mb-2" style="display: flex;">
									<div>
				                        <input type="radio" name="cancelType" class="custom-control-input" id="cancelType1" value="0" ${detail.cancel_reason_type==0?"checked" : ""} ${type=="info" ? "disabled" : ""}>
			                        	<label class="custom-control-label" for="cancelType1">배송지연</label>
		                        	</div>
			                        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                        	<div>
		                        		<input type="radio" name="cancelType" class="custom-control-input" id="cancelType2" value="2" ${detail.cancel_reason_type==2?"checked" : ""} ${type=="info" ? "disabled" : ""}>
		                        		<label class="custom-control-label" for="cancelType2">단순변심</label>
		                        	</div>
		                        	<c:if test="${type == 'info'}">
			                        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                        	<div>
			                        		<input type="radio" name="cancelType" class="custom-control-input" id="cancelType3" value="1" ${detail.cancel_reason_type==1?"checked" : ""} disabled>
			                        		<label class="custom-control-label" for="cancelType3">제품불량</label>
		                        		</div>
		                        	</c:if>
		                    	</div>
			                    <div>
			                    	<c:if test="${type == 'info'}">
			                    		<pre  style="height:150px" class="form-control">${detail.cancel_reason_detail}</pre>
			                    	</c:if>
			                    	<c:if test="${type != 'info'}">
			                    		<textarea style="height:150px" id="cancel_reason_detail" class="form-control" placeholder="상세 사유를 입력하세요"></textarea>
			                    	</c:if>
		                    	</div>
							️</td>
                        </tr>
                        <!-- 결제 정보 -->
                        <tr>
                      		<th colspan="2"><h4 class="mb-0">Payment Info</h4></th>
                      	</tr>
                        <tr>
                        	<th>총 상품금액</th>
                        	<td><fmt:formatNumber value="${origin_price}" pattern="#,###" /> 원</td>
                        </tr>
                        <tr>
                        	<th>배송비</th>
                        	<td><fmt:formatNumber value="${order.delivery_price}" pattern="#,###" /> 원</td>
                        </tr>
                        <tr>
                        	<th>적립금 사용</th>
                        	<td><fmt:formatNumber value="${order.point}" pattern="#,###" /> 원</td>
                        </tr>                    
                        <tr>
                        	<th>최종 결제 금액</th>
                        	<td><fmt:formatNumber value="${order.payment_price}" pattern="#,###" /> 원</td>
                        </tr>
                        <!-- 환불 정보 -->
                        <tr>
                      		<th colspan="2"><h4 class="mb-0">Refund Info</h4></th>
                      	</tr>
                        <tr>
                        	<th>환불 수단</th>
                        	<td>${order.payment_method}</td>
                        </tr>
                        <tr>
                        	<th>환불 금액</th>
                        	<td><fmt:formatNumber value="${refund_price}" pattern="#,###" /> 원</td>
                        </tr>
                        <tr>
                        	<th>환불 적립금</th>
                        	<td><fmt:formatNumber value="${refund_point}" pattern="#,###" /> 원</td>
                        </tr>
                      </tbody>
                    </table>
            	</div>
         	</div>
         	<div class="col-12" style="text-align: center">
         		<c:if test="${type != 'info'}">
         			<button class="btn btn-primary" onclick="submit();">확인</button>
         		</c:if>
         	</div>
         	
         	
         	
				</div>
				<script type="text/javascript">
				console.log($("#cancel_reason_detail").val());
				</script>
				<!-- /content -->
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
    </body>
</html>  