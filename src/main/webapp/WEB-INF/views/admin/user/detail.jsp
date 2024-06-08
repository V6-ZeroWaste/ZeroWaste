<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>회원 상세</title>
        <link href="/admin/css/styles.css" rel="stylesheet" />
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <style>
        .title {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		} 
		.behavior{
			padding-bottom: 30px;
			display: flex;
			justify-content: space-around;
		}
		</style>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
        <div id="layoutSidenav">
        	<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        	<div id="layoutSidenav_content">
        		<main>
        			<div class="container-fluid px-4">
        				<!-- 제목 -->
        				<div class="title">
                        	<h1 class="mt-4">회원 상세</h1>
                        	<button class="btn btn-primary" style="height:38px">돌아가기</button>
        				</div>
        				
        				<!-- 회원영역 -->
                        <div class="card mb-4">
                        	<div class="card-header">
                                <h4 class="mt-4">회원 정보</h4>
                            </div>
                        	<div class="card-body">
                        		<table class="datatable-table">
                        			<tbody>
                                    <tr>
                                    	<th>회원번호</th>
                                    	<td>${user.user_no}</td>
                                    </tr>
                                    <tr>
                                    	<th>가입일자</th>
                                    	<td>${user.date}</td>
                                    </tr>
                                    <tr>
                                    	<th>아이디</th>
                                    	<td>${user.id}</td>
                                    </tr>
                                    <tr>
                                    	<th>이메일</th>
                                    	<td>${user.email}</td>
                                    </tr>
                                    <tr>
                                    	<th>이름</th>
                                    	<td>${user.name}</td>
                                    </tr>
                                    <tr>
                                    	<th>전화번호</th>
                                    	<td>${user.tel}</td>
                                    </tr>
                                    <tr>
                                    	<th rowspan="3">주소</th>
                                    	<td>우편번호</td>
                                    </tr>
                                    <tr>
                                    	<td> 주소 </td>
                                    </tr>
                                    <tr>
                                    	<td> 상세 주소 </td>
                                    </tr>
                                    </tbody>
                        		</table>
                        	</div>
                        </div>
                        
                        <!-- 적립금영역 -->
                        <div class="card mb-4">
                        	<div class="card-header">
                                <h4 class="mt-4">보유 적립금</h4>
                            </div>
                        	<div class="card-body">
                        	<div class="datatable-top">
                            		<div class="datatable-search">
                            			<button class="btn btn-primary" style="height:38px">추가하기</button>
                            		</div>
                            		
                            	</div>
                        		<div class="datatable-container">
	                                <table class="datatable-table">
	                                    <thead>
	                                        <tr>
	                                            <th>상태</th>
	                                            <th>적립</th>
	                                            <th>내용</th>
	                                            <th>주문번호</th>
	                                            <th>삭제</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="printList">
	                                    
	                                    </tbody>
	                                </table>
                            	</div>
                        	</div>
                        </div>
                        
                    </div>
                             
                    <!-- 수정/등록/취소.. 버튼 -->
                    <div class="behavior">
                    	<button class="btn btn-primary" style="height:38px">수정</button>
                    </div>
        		
        		</main>
                <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
            </div>
        </div>
        
    </body>
</html>
