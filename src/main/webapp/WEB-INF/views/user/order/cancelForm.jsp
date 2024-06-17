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
	
    <title>Cancel</title>
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
			width: 150px;
		}
		.review-img{
			max-width: 70%;
		}
		
		.item-img{
		max-height: 99.98px;
		}
    	
    </style>
  </head>
    <body>
    <div style="width:700px;margin: auto;">
    <!-- content -->
	<div class="row">
		<!-- title -->
    	<div class="col-12">
   			<h3 class="mb-0">Cancel</h3>
   		</div>
   		<!-- /title -->
   		
	   	
	   		<!-- item info card -->
	   		<div class="col-12">
              <div style="border: 1px solid #dddddd;">
                <div class="row align-items-center" style="min-height:100px">
                  <div style="width:140px;text-align:center">
                  	<!-- 상품이미지 -->
                  	<a href="product-1.html" title="Fawn Wool / Natural Mammoth Chair" data-toggle="tooltip" data-placement="top">
                  		<img class="item-img" src="/user/images/demo/product-1.jpg" alt="Fawn Wool / Natural Mammoth Chair">
                  	</a>
                  </div>
                  <div style="width:400px">
                    <h3 class="order-number">Item name</h3>
                  </div>
                  <div style="width:130px">
                  	<!-- 상품 바로가기 링크 -->
                    <a href="#!" class="action eyebrow underline">View Item</a>
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
							<td colspan="2">
								<div class="custom-control custom-radio mb-2">
			                        <input type="radio" name="custom-radio-2" class="custom-control-input" id="cancelType1" checked disabled>
			                        	<label class="custom-control-label" for="cancelType1">배송지연</label>
			                        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                        	<input type="radio" name="custom-radio-2" class="custom-control-input" id="cancelType2" disabled>
			                        	<label class="custom-control-label" for="cancelType2">단순변심</label>
			                    	</div>
			                    	<input type="text" class="form-control" placeholder="상세 사유를 입력하세요" disabled="disabled">
							️</td>
                        </tr>
                        <!-- 결제 정보 -->
                        <tr>
                      		<th colspan="2"><h4 class="mb-0">Payment Info</h4></th>
                      	</tr>
                        <tr>
                        	<th>총 상품금액</th>
                        	<td>10000 원</td>
                        </tr>
                        <tr>
                        	<th>총 할인금액</th>
                        	<td>300 원</td>
                        </tr>
                        <tr>
                        	<th>적립금 사용</th>
                        	<td>700 원</td>
                        </tr>
                        <tr>
                        	<th>적립금 사용</th>
                        	<td>700 원</td>
                        </tr>
                        <!-- 환불 정보 -->
                        <tr>
                      		<th colspan="2"><h4 class="mb-0">Refund Info</h4></th>
                      	</tr>
                        <tr>
                        	<th>환불 수단</th>
                        	<td>카카오페이</td>
                        </tr>
                        <tr>
                        	<th>환불 금액</th>
                        	<td>6700 원</td>
                        </tr>
                        <tr>
                        	<th>환불 적립금</th>
                        	<td>700원</td>
                        </tr>
                      </tbody>
                    </table>
            	</div>
         	</div>
         	<div class="col-12" style="text-align: center">
         		<button class="btn btn-primary">확인</button>
         	</div>
         	
         	
         	
				</div>
				<!-- /content -->
	</div>
    </body>
</html>  