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

    <title>Reviews</title>
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
   			<h3 class="mb-0">Reviews</h3>
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
	   	<!-- <div class="reviewList row gutter-2"> -->
	   		
	   		<!-- review card -->
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
                    <a href="#!" class="action eyebrow underline">View Detail</a>
                  </div>
                </div>
              </div>
            </div>
            <!-- /review card -->
            
			<!-- review card -->
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
                    <a href="#!" class="action eyebrow underline">View Detail</a>
                  </div>
                </div>
              </div>
            </div>
            <!-- /review card -->
	   		

	   		
   		</div>
   		<!-- /list -->
 
							
						
					
					
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
			        </div>
			        <!-- /pagination -->
				</div>
				<!-- /content -->
			</div>
			<!-- </div> -->
		
	</section>
    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>  