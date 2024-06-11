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

    <title>soaff</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
  </head>
    <body>
		<main>
        			<div class="container-fluid px-4">
                        <h1 class="mt-4">상품 리뷰 관리</h1>
                        <div class="card mb-4">
                            <!-- <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                DataTable Example
                            </div> -->
                            
                            <div class="card-body">
                             	<!-- 리스트 정렬, 필터 검색 영역  -->
                             	<div>
                             		<div class="datatable-dropdown" style="margin-bottom: 20px">
										<span>작성 날짜</span>
										<input id="startDate" name="startDate" type="date" class="datatable-selector" onchange="applyCondition();">-
										<input id="endDate" name="endDate" type="date" class="datatable-selector" onchange="applyCondition();">
									</div>
                             	</div>
                             	
                            	<div class="datatable-top">

                            		<div class="datatable-dropdown">
							            <label>
							                <select id="orderBy" class="datatable-selector" onchange="applyCondition();">
								                <option value="" selected="">===정렬===</option>
								                <option value="최신순">최신순</option>
								                <option value="오래된순">오래된순</option>
								                <option value="평점높은순">평점높은순</option>
								                <option value="평점낮은순">평점낮은순</option>
							                </select>
							            </label>
							        </div>
							            
                            		<div class="row align-items-center">
	                                    <div class="col-md-9">
	                                         <input id="searchWord" class="datatable-input" type="search" placeholder="상품명/리뷰제목/카테고리 검색" onkeyup="if(window.event.keyCode==13){applyCondition();}">
	                                    </div>
	                                    
                                    	<div class="col-md-1">
                                        	<input type="button" value="검색" class="btn btn-primary" onclick="applyCondition()"> 
                                      	</div>
                                 	</div>
                            	</div>
                            	
                            	<!-- 리스트 영역 -->
                            	<div class="datatable-container">
                                <table class="datatable-table">
                                    <thead>
                                        <tr>
                                            <th>상품명</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>리뷰일자</th>
                                            <th>평점</th>
                                        </tr>
                                    </thead>
                                    <tbody id="printList">
                                    
                                    </tbody>
                                </table>
                            </div>
                            <!-- 페이지네이션 영역 -->
                            <div class="datatable-bottom">
							    <div class="datatable-info"></div>
							    <nav class="datatable-pagination">
							    	<ul class="datatable-pagination-list">                    
							    	</ul>
							    </nav>
							    </div>
							</div>
                        </div>
                    </div>
        		</main>

    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
