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
    <title>Cancel Form</title>
    <style>
    	img{
    		max-width: 100px;
    		max-height: 100px;
    	}
    </style>
  </head>
	<body>
		<form>
			<div>
				<h3 class="mb-0">주문 취소</h3>
				<div>
				
				<!-- item info -->
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
	                          	<span>3 개</span><br>
	                          	<span>30,000 원</span>
	                          </td>
	                        </tr>
	                        
	                      	<tr>
	                          <td>
	                          	<img class="order-itemImg" src="/user/images/demo/product-4.jpg" alt="Red Analog Magazine Rack">
	                          </td>
	                          <td>
	                          	<strong>황새 추천 비누</strong><br>
	                          	<span>3 개</span><br>
	                          	<span>30,000 원</span>
	                          </td>
	                        </tr>
	                        
	                        
	                      </tbody>
	                    </table>
			   		</div>
			   	</div>
			   	
			   	
			   	<div>
			   		<div></div>
			   	
			   	</div>
					
				</div>
				
			
			</div>
			<input id="order_no" type="hidden">
			<input id="order_detail_no" type="hidden">
		</form>
    </body>
</html>
    