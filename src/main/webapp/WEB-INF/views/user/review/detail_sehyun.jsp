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

    <title>Review Detail</title>
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
		<!-- title -->
    	<div class="col-12">
   			<h3 class="mb-0">Review Detail</h3>
   		</div>
   		<!-- /title -->
   		
	   	
	   		<!-- item info card -->
	   		<div class="col-12">
              <div class="order">
                <div class="row align-items-center" style="height:100px">
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
                  </div>
                  <div class="col-lg-2">
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
                          <th scope="row">Date</th>
                          <td>2023-11-11 00:12:45 </td>
                          <td style="text-align: right">
                          	⭐️⭐️⭐️⭐️⭐️
                          </td>
                        </tr>
                        <tr>
                          <th scope="row">Title</th>
                          <td colspan="2">review title 아무거나 대충 </td>
                        </tr>
                        <tr>
                          <th>Content</th>
                          <td colspan="2">
                          	<div>
                          		여기는 그냥 리뷰 내용영역이다<br>
                          		adlkfjalksdjflakjsdfklajsl
                          	</div>
                          </td>
                        </tr>
                        <tr>
                          <th>Image</th>
                          <td colspan="2">
                          	<img class="review-img" src="https://cdn.imweb.me/thumbnail/20230824/20e7077f9429c.png"></img>
                          </td>
                        </tr>
                      </tbody>
                    </table>
            	</div>
         	</div>
         	<div class="col-12" style="text-align: center">
         		<button class="btn btn-primary">수정</button>
         		<button class="btn btn-danger">삭제</button>
         	</div>
         	
         	
         	
				</div>
				<!-- /content -->
			</div>
		</div>
	</div>
			<!-- </div> -->
		
	</section>
    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>  