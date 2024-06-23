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
        <title>적립금 추가</title>
        <link href="/admin/css/styles.css" rel="stylesheet" />
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <style>
        .behavior{
			padding-bottom: 30px;
			display: flex;
			justify-content: space-around;
		}
		input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
		</style>
		<script>
		function addPoint(){
			if($("#content").val().trim() == "" || $("#point").val().trim() == ""){
				alert("필수값(* 표시)을 입력하세요.")
        	}else{
        		var data = {
        			content: $("#content").val().trim(),
        			order_no: $("#order_no").val().trim(),
        			point: $("#point").val().trim(),
        			user_no: $("#user_no").val().trim()
        		
        		}
        		$.ajax({
        			type: "POST", // method type
        			url: "/point/insert", // 요청할 url
                    data: JSON.stringify(data), // 전송할 데이터
                    dataType: "text", // 응답 받을 데이터 type
                    contentType: "application/json; charset=UTF-8",
                    success : function(resp){
                    	alert(resp);
                    	self.close();
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
		<div class="container-fluid px-4">
			<!-- 제목 -->

			<div class="title" style="width:100%; text-align: center;">
				<h1 class="mt-4">적립금 내역 추가</h1>
			</div>
			
			<div class="card-body">
			<table class="datatable-table">
				
				<tbody>
					<tr>
                    	<th>* 적립 내용</th>
                    	<td>
                    		<input id="content" type="text" style="width:100%" value="" >
                    	</td>
                    </tr>
        			<tr>
                    	<th>* 적립 금액</th>
                    	<td>
                    		<input id="point" type="number" style="width:50%" value="" >원
                    	</td>
                    </tr>
                    
        			<tr>
                    	<th>주문번호</th>
                    	<td>
                    		<input id="order_no" type="number" style="width:50%" value="" >
                    	</td>
                    </tr>
                    </tbody>
        		</table>
        		
        	</div>
        	<div class="behavior">
				<button id="add" class="btn btn-primary" style="height:38px" onclick="addPoint()">추가</button>
			</div>
			<input id="user_no" type="hidden" value="">

        </div>
    </body>
</html>
