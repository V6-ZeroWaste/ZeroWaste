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
	
    <title>Review</title>
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
			width: 120px;
		}
		.review-img{
			max-width: 70%;
		}
		input{
			width:90%;
			margin: auto;
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
   			<h3 class="mb-0">Review</h3>
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
            <!-- /review info card -->
            
            <!-- review detail card -->
         	<div class="col-12">
         		<div  style="border: 1px solid #dddddd;">
                    <table class="table table-borderless">
                      <tbody>
                      	<tr>
                          <th scope="row">Rating</th>
                          <td colspan="2">⭐️⭐️⭐️⭐️⭐️</td>
                        </tr>
                        <tr>
                          <th scope="row">Title</th>
                          <td colspan="2"><input type="text" class="form-control"> </td>
                        </tr>
                        <tr>
                          <th>Content</th>
                          <td colspan="2">
                          	<div>
                          		<input type="text"  class="form-control" style="height:200px">
                          	</div>
                          </td>
                        </tr>
                        <tr>
                          <th>Image</th>
                          <td colspan="2">
                          	<input class="form-control" type="file" name="file" id="file" class="wid100"/>
                          </td>
                        </tr>
                      </tbody>
                    </table>
            	</div>
         	</div>
         	<div class="col-12" style="text-align: center">
         		<button class="btn btn-primary">등록</button>
         	</div>
         	
         	
         	
				</div>
				<!-- /content -->
	</div>
    </body>
</html>  