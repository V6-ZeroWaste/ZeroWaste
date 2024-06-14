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
		.search-filter>div{
			margin:10px 0px 10px 0px;
		}
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
		img{
			max-width: 50%;
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
   		
	   	
	   		<!-- review info card -->
	   		<div class="col-12">
              <div class="order">
                <div class="row align-items-center">
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
                    <span class="review-info">2023-11-11 12:00:12</span>
                    <br>
                    <span class="review-info">review title</span>
                    <br>
                    <span class="review-info">⭐️⭐️⭐️⭐️</span>
                  </div>
                  <div class="col-lg-2">
                    <a href="#!" class="action eyebrow underline">Modify</a>
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
                          <th scope="row">Title</th>
                          <td>review title 아무거나 대충 </td>
                        </tr>
                        <tr>
                          <th>Content</th>
                          <td>
                          	<div>
                          		여기는 그냥 리뷰 내용영역이다<br>
                          		adlkfjalksdjflakjsdfklajsl
                          	</div>
                          </td>
                        </tr>
                        <tr>
                          <th>Image</th>
                          <td>
                          	<img src="https://cdn.imweb.me/thumbnail/20230824/20e7077f9429c.png"></img>
                          </td>
                        </tr>
                      </tbody>
                    </table>
            	</div>
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