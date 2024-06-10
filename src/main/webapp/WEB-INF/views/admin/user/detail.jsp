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
        <title>회원 상세</title>
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
		</style>
		<script>
		// 포인트리스트 처리
        let page = 1;
        window.onload=function(){
        	  getList();
        	}
        function changePage(obj){
       		page = obj.getAttribute("data-page");
       		getList();
        }
        function getList(){
        	var data = {
        			page: page,
        			user_no: ${user.user_no}
        	}
            
           	$.ajax({
				type: "GET", // method type
				url: "/point/getList", // 요청할 url
                data: data, // 전송할 데이터
                dataType: "json", // 응답 받을 데이터 type
                success : function(resp){
                   	// 데이터 리스트 출력
               		$("#printList").html(resp.printList);
               		// 총 보유 적립금
               		$("#totalPoint").html(resp.totalPoint);
                   	
               		// 페이지네이션 출력
               		// 총 개수
               		$(".datatable-info").html("Showing "+((page-1)*10+1)+" to "+(page*10<=resp.total? page*10 : resp.total)+" of "+resp.total+" entries"); 
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
        
        // 우편번호 찾기 처리
        $(function(){
    		$(".zipcodeFind, #zipcode").click(function(){
    			new daum.Postcode({
    	            oncomplete: function(data) {
    	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

    	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
    	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
    	                var addr = ''; // 주소 변수
    	                var extraAddr = ''; // 참고항목 변수

    	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
    	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
    	                    addr = data.roadAddress;
    	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
    	                    addr = data.jibunAddress;
    	                }

    	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
    	                if(data.userSelectedType === 'R'){
    	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
    	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
    	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
    	                        extraAddr += data.bname;
    	                    }
    	                    // 건물명이 있고, 공동주택일 경우 추가한다.
    	                    if(data.buildingName !== '' && data.apartment === 'Y'){
    	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
    	                    }
    	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
    	                    if(extraAddr !== ''){
    	                        extraAddr = ' (' + extraAddr + ')';
    	                    }
    	                    // 조합된 참고항목을 해당 필드에 넣는다.
    	                    // document.getElementById("sample6_extraAddress").value = extraAddr;
    	                
    	                } else {
    	                   // document.getElementById("sample6_extraAddress").value = '';
    	                }

    	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
    	                document.getElementById('zipcode').value = data.zonecode;
    	                document.getElementById("addr").value = addr;
    	                // 커서를 상세주소 필드로 이동한다.
    	                $("#addr_detail").focus();
    	            }
    	        }).open();	
    		})
    	})
        
    	// 수정 버튼 클릭시 처리
    	$(function(){
	    	$("#modify").click(function(){
	       		if( $("#tel1").val().trim()=="" || $("#tel2").val().trim()=="" || $("#tel2").val().trim()==""){
	       			alert("전화번호를 입력하세요");
	       			
        		}else{
		        	if(confirm("수정하시겠습니까?")){
		        		var data = {
		            			user_no: ${user.user_no},
		        				zipcode: $("#zipcode").val().trim(),
		        				addr: $("#addr").val().trim(),
		        				addr_detail: $("#addr_detail").val().trim(),
		        				tel: $("#tel1").val().trim()+"-"+$("#tel2").val().trim()+"-"+$("#tel3").val().trim(),
		            	}
		        		console.log(data);
		        		$.ajax({
		    				type: "POST", // method type
		    				url: "/admin/user/update", // 요청할 url
		                    data: JSON.stringify(data), // 전송할 데이터
		                    dataType: "text", // 응답 받을 데이터 type
		                    contentType: "application/json; charset=UTF-8",
		                    success : function(resp){
		                    	alert(resp);
		                    },
		                    error:function (data, textStatus) {
		                       	alert("서버 오류") // 서버오류
							}
		        		
			        	})
			        }
        		}
		    })

    	})
        
        
    	// 포인트 삭제 버튼 클릭시 처리
    	function pointDelete(obj){
    		if(confirm("삭제하시겠습니까?")){
    			var data = {
            			point_no: obj.getAttribute("point_no")
            	}
    			$.ajax({
    				type: "POST", // method type
    				url: "/point/delete", // 요청할 url
                    data: JSON.stringify(data), // 전송할 데이터
                    dataType: "text", // 응답 받을 데이터 type
                    contentType: "application/json; charset=UTF-8",
                    success : function(resp){
                    	alert(resp);
                    	getList();
                    },
                    error:function (data, textStatus) {
                       	alert("서버 오류") // 서버오류
					}
               	})
    		}
    		
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
                        	<input class="btn btn-primary" type="button" style="height:38px" onclick="history.back()" value="돌아가기"> 
                        	
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
                                    	<td>
                                    		<fmt:formatDate value="${user.date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/>
                                    	</td>
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
                                    	<td>
                                    		<input id="tel1" type="number" style="width:60px" value="${fn:split(user.tel, '-')[0]}" >-
                                    		<input id="tel2" type="number" style="width:60px" size="4" value="${fn:split(user.tel, '-')[1]}" >-
                                    		<input id="tel3" type="number" style="width:60px" size="4" value="${fn:split(user.tel, '-')[2]}" >
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<th rowspan="3">주소</th>
                                    	<td>
                                    		<input id="zipcode" name="zipcode" type="text" value="${user.zipcode}"  disabled="disabled" style="width:100px"/>
                                    		<button class="btn btn-outline-primary zipcodeFind" style="height:38px">우편번호 찾기</button>
										</td>
                                    </tr>
                                    <tr>
                                    	<td>
                                    		<input id="addr" name="addr" type="text" value="${user.addr}" disabled="disabled" style="width:100%"/>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td>
                                    		<input id="addr_detail" name="addr_detail" type="text" value="${user.addr_detail}" style="width:100%"/>
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
	                

                        
                        <!-- 적립금영역 -->
                        
                        <div class="card mb-4">
                        	<div class="card-header">
                                <h4 class="mt-4">보유 적립금 : <span id="totalPoint"></span> 원</h4>
                            </div>
                        	<div class="card-body">
                        		<div class="datatable-top">
                            		<div class="datatable-search">
                            			<button class="btn btn-primary" style="height:38px">추가</button>
                            		</div>
                            		
                            	</div>
                        		<div class="datatable-container">
                        			
	                                <table class="datatable-table">
	                                    <thead>
	                                        <tr>
	                                            <th>상태</th>
	                                            <th>적립금</th>
	                                            <th>내용</th>
	                                            <th>주문번호</th>
	                                            <th>적용일시</th>
	                                            <th>삭제</th>
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
	            <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
	        </div>
        </div>
    </body>
</html>
