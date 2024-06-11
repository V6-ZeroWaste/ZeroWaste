<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>리뷰 상세</title>
        <link href="/admin/css/styles.css" rel="stylesheet" />
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        
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
		#review_img{
			max-height: 300px;
			max-width: 300px;
		}
		.input-box{
			width:100%;
			min-height:200px;
		}
		
		</style>
		
		<script>
		// 수정 버튼 클릭시 처리
	    	$(function(){
		    	$("#modify").click(function(){
		        	if(confirm("수정하시겠습니까?")){
		        		var data = {
		            			review_no: ${vo.review_no},
		            			exposed_status: $("#exposed_status:checked").val()
		            	}
		        		$.ajax({
		    				type: "POST", // method type
		    				url: "/admin/review/update", // 요청할 url
		                    data: JSON.stringify(data), // 전송할 데이터
		                    dataType: "text", // 응답 받을 데이터 type
		                    contentType: "application/json; charset=UTF-8",
		                    success : function(resp){
		                    	alert(resp);
		                    	location.reload(true);
		                    },
		                    error:function (data, textStatus) {
		                       	alert("서버 오류") // 서버오류
							}
		        		
			        	})
			        }
	
			    })
	
	    	})
		
		</script>
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
                        	<h1 class="mt-4">리뷰 상세</h1>
                        	<input class="btn btn-primary" type="button" style="height:38px" onclick="history.back()" value="돌아가기"> 
                        	
        				</div>
        				
        				<!-- 문의 영역 -->
                        <div class="card mb-4">

                        	<div class="card-body">
                        		<table class="datatable-table">
                        			<tbody>
                        			
                                    
                                    <tr>
                                    	<th>리뷰 번호</th>
                                    	<td>
                                    		${vo.review_no}
                                    	</td>
                                    	<th>작성 일자</th>
                                    	<td>
                                    		<fmt:formatDate value="${vo.regist_date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<th>상품카테고리</th>
                                    	<td>${vo.category_name}</td>
                                    	
                                    	<th>상품명</th>
                                    	<td><a href="/admin/item/detail?item_no=${vo.item_no}">${vo.item_name }</a></td>
                                    </tr>
                                    <tr>
                                    	<th>제목</th>
                                    	<td colspan='3'>
                                    		${vo.title }
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<th>작성자</th>
                                    	<td colspan='3'>
                                    		<a href="/admin/user/detail?user_no=${vo.user_no}">${vo.user_id }</a>
                                    	</td>
                                    </tr>
                                    
                                    <tr>
                                    	<th>별점</th>
                                    	<td>${vo.score}</td>
                                    	
                                    	<th>노출 여부</th>
                                    	<td>
                                    		<input type="radio" id="exposed_status" name="exposed_status" value="0" ${vo.exposed_status==0? "checked" : ""}>노출
                                    		&nbsp;&nbsp;
											<input type="radio" id="exposed_status" name="exposed_status" value="1" ${vo.exposed_status==1? "checked" : ""}>숨김
                                    	</td>
                                    	
                                    </tr>
                                    <tr>
                                    	
                                    </tr>
                                    <tr>
                                    	<th>리뷰 내용</th>
                                    	<td colspan='3'>
                                    		<div>
                                    			<c:if test="${vo.review_img != null}">
                                    				<img id="review_img" src="${vo.review_img}"/>
                                    			</c:if>
                                    		</div>
                                    		<div>
                                    			<input id="content" class="input-box" value="${vo.content}" disabled="disabled">
                                    		</div>
                                    	</td>
                                    </tr>
                                    </tbody>
                        		</table>
                        	</div>
                        </div>
                        
                        <!-- 수정/등록/취소.. 버튼 -->
		                <div class="behavior">
		                	<button id="modify" class="btn btn-primary" style="height:38px">수정</button>
		                </div>
                    </div>
	       		</main>
	            <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
	        </div>
        </div>
    </body>
</html>