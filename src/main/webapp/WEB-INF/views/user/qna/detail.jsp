<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
<link rel="stylesheet" href="/user/css/vendor.css" />
<link rel="stylesheet" href="/user/css/style.css" />
<title>문의 상세 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
.detail-container {
	width: 100%;
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 10px;
	background-color: #f9f9f9;
}

.reply-container {
	width: 100%;
	max-width: 1200px;
	margin: 50px auto;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 10px;
	background-color: #f9f9f9;
}

.reply-content {
	height: 200px;
}

.detail-header {
	display: flex;
	align-items: flex-start;
	margin-bottom: 20px;
}

.detail-header img {
	border-radius: 10px;
	width: 200px;
	height: 500px;
	margin-right: 20px;
}

.detail-header .detail-info {
	flex-grow: 1;
}

.detail-header .detail-info h2 {
	margin: 0;
	font-size: 20px;
}

.detail-header .detail-info p {
	margin: 5px 0;
	font-size: 18px;
}

.detail-content {
	margin-top: 30px;
	margin-bottom: 20px;
	border: 1px solid #ddd;
	border-radius: 10px;
	margin-bottom: 20px;
}

.detail-content h3 {
	margin-top: 0;
}

.detail-footer {
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	width: 100%;
}

.detail-footer .product-name {
	margin-bottom: 15px;
	font-size: 18px;
	font-weight: bold;
}

.detail-footer .buttons {
	display: flex;
}

.detail-footer button {
	margin-left: 10px;
}

.title-user-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.rating {
	color: #FFD700;
	font-size: 18px;
}
</style>
<script type="text/javascript">
var qna_no = ${vo.qna_no};
function deleteQna() {
    if (confirm("정말 삭제하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "/user/qna/delete",
            data: { qna_no: ${vo.qna_no} },
            success: function(response) {
                if (response === 1) {
                    alert("문의가 삭제되었습니다.");
                    location.href = "/user/qna/list";
                } else {
                    alert("문의 삭제에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버와의 통신 중 오류가 발생했습니다.");
            }
        });
    }
}



function updateQna(qna_no,title,content){
	 var title = $('#title').val();
	    var content = $('#content').val();
	if(confirm("정말 수정하시겠습니까?")){
		$.ajax({
			type: "POST",
			url: "/user/qna/update",
			data: {
				title: title,
				content: content,
				qna_no: qna_no
			},
			success: function(response){
				if(response===1){
					alert("문의가 수정되었습니다.");
				}else{
					alert("문의 수정에 실패하였습니다.");
				}
			},
			error: function(){
				alert("서버와의 통신 중 오류가 발생했습니다.");
			}
		});
	}
}

function handleUpdate() {
    var title = document.getElementById('title').value;
    var content = document.getElementById('content').value;
    updateQna(${vo.qna_no}, title, content);
}
	</script>
</head>
<body>
	<div class="detail-container">
		<div class="detail-header">
			<img src="${vo.qna_img}" alt="작성자 이미지">
			<div class="detail-info">
				<p style="font-size: 20px;">
					<fmt:formatDate value="${vo.question_date}" pattern="yyyy-MM-dd" />
				</p>
				<div class="title-user-container">
					<input type="text" id="title" class="form-control"
						value="${vo.title}">
					<p>작성자: ${vo.user_id}</p>
				</div>
				<div class="detail-content">
					<textarea id="content" class="form-control" rows="10">${vo.content}</textarea>
				</div>
				<div class="detail-footer">
					<div class="product-name">상품명: ${vo.item_name}</div>
					<div class="buttons">
						<button id="update" class="btn btn-primary" onclick="handleUpdate();"
							style="height: 55px">수정</button>
						<button id="delete" class="btn btn-danger" onclick="deleteQna();"
							style="height: 55px">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="reply-container">
		<div class="reply-content">
			<p>내용: ${vo.reply }</p>
		</div>
	</div>
</body>
</html>
