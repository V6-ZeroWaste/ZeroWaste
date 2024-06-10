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
		<script type="text/javascript">
        let page = 1;
        window.onload=function(){
        	  getList();
        	}
        function applyCondition(){
       		page = 1;
       		getList();
        }
        function changePage(obj){
       		page = obj.getAttribute("data-page");
       		getList();
        }
        function getList(){
        	var data = {
        			searchWord: $('#searchWord').val(),
        			orderBy: $('#orderBy').val(),
        			page: page,
        	}
            
           	$.ajax({
				type: "GET", // method type
				url: "/admin/user/list.do", // 요청할 url
                data: data, // 전송할 데이터
                dataType: "json", // 응답 받을 데이터 type
                success : function(resp){
                   	console.log(resp)
                   	// 데이터 리스트 출력
                   	let printList = "";
                   	if(resp.list.length == 0){
                   		printList = "<td class=\"first\" colspan=\"5\">등록된 글이 없습니다.</td>";
                   	}
                   	for(vo in resp.list){
                   		printList += '<tr onclick="location.href='+"'/admin/user/detail?user_no="+ resp.list[vo].user_no + "'"+'">';
                   		printList += "<td>" + resp.list[vo].user_no + "</td>";
                   		printList += "<td>" + resp.list[vo].id + "</td>";
                   		printList += "<td>" + resp.list[vo].name + "</td>";
                   		printList += "<td>" + resp.list[vo].tel + "</td>";
                   		printList += "<td>" + resp.list[vo].email + "</td>";
                   		printList += "</tr>";
                   	}
               		$("#printList").html(printList);
               		
               		// 페이지네이션 출력
               		// 총 개수
               		$(".datatable-info").html("Showing "+((page-1)*20+1)+" to "+(page*20<=resp.total? page*20 : resp.total)+" of "+resp.total+" entries"); 
               		// 페이지네이션
               		let printPage = "";
               		if(resp.isPrev){
               			printPage += '<li class="datatable-pagination-list-item">';
               			printPage += '<a data-page="1" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
               			printPage += '<li class="datatable-pagination-list-item">';
               			printPage += '<a data-page="'+(resp.startPage-1)+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
               		}
               		for(i = resp.startPage; i<=resp.endPage; i++){
               			printPage += '<li class="datatable-pagination-list-item'+(i==page? ' datatable-active' : '')+'">';
               			printPage += '<a data-page="'+ i +'" class="datatable-pagination-list-item-link" onclick="changePage(this);">'+i+'</a></li>';
               		}
               		if(resp.isNext){
               			printPage += '<li class="datatable-pagination-list-item">';
               			printPage += '<a data-page="'+(resp.endPage+1)+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
               			printPage += '<li class="datatable-pagination-list-item">';
               			printPage += '<a data-page="'+resp.totalPage+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
               		}
               		$(".datatable-pagination-list").html(printPage);
               		
                   	
                   	
                },
                error:function (data, textStatus) {
                    $('#fail').html("관리자에게 문의하세요.") // 서버오류
                    console.log('error', data, textStatus);
                }
           	})
        	
		}
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
