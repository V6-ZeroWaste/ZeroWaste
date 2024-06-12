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
<title>리뷰 상세 페이지</title>
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
	margin-bottom: 20px;
	padding: 20px;
	height: 300px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 10px;
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

	
	
</head>
<body>
	<div class="detail-container">
		<div class="detail-header">
			<img src="${vo.review_img}" alt="작성자 이미지">
			<div class="detail-info">
				<p style="font-size: 20px;">
					<fmt:formatDate value="${vo.regist_date}" pattern="yyyy-MM-dd" />
				</p>
				<div class="title-user-container">
					<h2>${vo.title}</h2>
					<p>작성자: ${vo.user_id}</p>
				</div>
				<div class="detail-content">
					<p>${vo.content}</p>
				</div>
				<p class="rating">
					평점:
					<c:forEach var="i" begin="1" end="${vo.score}">
						<i class="fas fa-star"></i>
					</c:forEach>
				</p>
				<div class="detail-footer">
					<div class="product-name">상품명: ${vo.item_name}</div>
					<div class="buttons">
						<form action="/user/review/update" method="post"
							style="display: inline;">
							<input type="hidden" name="review_no" value="${vo.review_no}">
							<button type="submit" class="btn btn-primary">수정</button>
						</form>
						<form action="/user/review/delete" method="post"
							style="display: inline;">
							<input type="hidden" name="review_no" value="${vo.review_no}">
							<button type="submit" class="btn btn-danger">삭제</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
