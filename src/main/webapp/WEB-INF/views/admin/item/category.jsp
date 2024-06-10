<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/admin/css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
	$(document).ready(function() {
		
		window.onunload = function() {
		    if (window.opener && !window.opener.closed) {
		        window.opener.location.reload();
		    }
		};
		
		function fixCategory(categoryNo) {
			if (confirm('정말 수정하시겠습니까?')) {
				const categoryName = $('#category-name-' + categoryNo).val();
				if($("#category-name-"+categoryNo).val()=='' || $("#category-name-"+categoryNo).val()==null){
					alert("값을 입력해주세요");
				} else {
					var data = {
							name : categoryName,
							category_no : categoryNo
					}
					
					$.ajax({
	        			type: "POST", // method type
	        			url: "/admin/item/category/fix", // 요청할 url
	                    data: JSON.stringify(data),
	                    dataType: "text", // 응답 받을 데이터 type
	                    contentType: "application/json; charset=UTF-8",
	                    success : function(resp){
	                    	alert(resp);
	                    	window.location.reload();
	                    },
	                    error:function (data, textStatus) {
	                      	alert("서버 오류") // 서버오류
	        			}
	                })
				}
			}
		}
		
		// 카테고리 삭제
		function deleteCategory(categoryNo, quantity) {
			if (confirm('정말 삭제하시겠습니까?')) {
				if(quantity>0){
					alert("하나 이상의 품목이 포함된 카테고리는 삭제할 수 없습니다");
				}else{
					var data = {
							category_no : categoryNo
					}
					
					$.ajax({
	        			type: "POST", // method type
	        			url: "/admin/item/category/delete", // 요청할 url
	                    data: JSON.stringify(data),
	                    dataType: "text", // 응답 받을 데이터 type
	                    contentType: "application/json; charset=UTF-8",
	                    success : function(resp){
	                    	alert(resp);
	                    	window.location.reload();
	                    },
	                    error:function (data, textStatus) {
	                      	alert("서버 오류") // 서버오류
	        			}
	                })
				}
			}
		}
		
		function insertCategory(){
			var insertCategoryName = $('#insert-category-name').val();
			if(insertCategoryName == '' || insertCategoryName == null){
				alert("값을 입력해주세요");
			} else {
				var data = {
						name : insertCategoryName,
				}
				
				$.ajax({
        			type: "POST", // method type
        			url: "/admin/item/category/insert", // 요청할 url
                    data: JSON.stringify(data),
                    dataType: "text", // 응답 받을 데이터 type
                    contentType: "application/json; charset=UTF-8",
                    success : function(resp){
                    	alert(resp);
                    	window.location.reload();
                    },
                    error:function (data, textStatus) {
                      	alert("서버 오류") // 서버오류
        			}
                })
			}
		}
		

		// 수정 버튼 클릭 이벤트 바인딩
		$('.btn-fix').click(function() {
			const categoryNo = $(this).data('category-no');
			fixCategory(categoryNo);
		});
		
		// 삭제 버튼 클릭 이벤트 바인딩
		$('.btn-delete').click(function() {
			const categoryNo = $(this).data('category-no');
			const quantity = $(this).data('quantity');
			deleteCategory(categoryNo, quantity);
		});
		
		// 추가 버튼 클릭 이벤트 바인딩
		$('.btn-insert').click(function() {
			insertCategory();
		});
	});
</script>
</head>
<body>
	<div class="container-fluid px-4">
	<h1 class="mt-4">카테고리 관리</h1>
		<div class="card mb-4">
			<div class='list-group'>
				<div class="list-group-item">
					<div class="row align-items-center">
						<div class="col-md-2 text-center">
							이름
						</div>
						<div class="col-md-5">
							<input type="text" id="insert-category-name" name="insert" class="form-control"">
	        			</div>
						<div class="col-md-5">
							<input type="button" class="btn btn-primary me-2 btn-insert" value="추가">
	        			</div>
        			</div>
				</div>
				<div class="list-group-item">
					<div class="row align-items-center">
						<div class="col-md-2 text-center">
							<b>카테고리 번호</b>
						</div>
						<div class="col-md-5 text-center">
							<b>카테고리 이름</b>
	        			</div>
	        			<div class="col-md-1 text-center">
	        				<b>개수</b>
	        			</div>
					</div>
				</div>
				<c:forEach var="category" items="${categories}">
					<div class="list-group-item">
						<div class="row align-items-center">
							<div class="col-md-2 text-center">
		        				${category.category_no} 
		        			</div>
							<div class="col-md-5">
								<input type="text" id="category-name-${category.category_no}" name="name" class="form-control" value="${category.name}">
		        			</div>
		        			<div class="col-md-1 text-center">
		        				${category.quantity}
		        			</div>
		        			<div class="col-md-2"></div>
		        			<div class="col-md-2 d-flex justify-content-end">
		        				<input type="button" class="btn btn-primary me-2 btn-fix" data-category-no="${category.category_no}" value="수정">
		        				<input type="button" class="btn btn-danger btn-delete" data-category-no="${category.category_no}" data-quantity="${category.quantity}" value="삭제">
		        			</div>
		        		</div>  
	        		</div>              
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>
