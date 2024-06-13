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

<title>soaff</title>
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
function redirectToUpdate() {
    var qnaNo = document.querySelector('input[name="qna_no"]').value;
    window.location.href = '/user/qna/detail2?qna_no=' + qnaNo;
}

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

	</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/user/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/user/include/mypageInfo.jsp"%>
	<section class="pt-5">
		<div class="container">
			<div class="row gutter-4 justify-content-between">
				<%@ include file="/WEB-INF/views/user/include/mypageNav.jsp"%>
				<div class="col-lg-9">
					<div class="row">
						<div class="col">


							<div class="detail-container">
								<div class="detail-header">
									<img src="${vo.qna_img}" alt="작성자 이미지">
									<div class="detail-info">
										<p style="font-size: 20px;">
											<fmt:formatDate value="${vo.question_date}"
												pattern="yyyy-MM-dd" />
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
												<form style="display: inline;">
													<input type="hidden" name="qna_no" value="${vo.qna_no}">
													<button type="button" class="btn btn-primary"
														onclick="redirectToUpdate()">수정</button>
												</form>
												<form action="/user/qna/delete" method="post"
													style="display: inline;">
													<input type="hidden" name="qna_no" value="${vo.qna_no}">
													<button type="submit" class="btn btn-danger"
														onclick="deleteQna()">삭제</button>
												</form>
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

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/user/include/footer.jsp"%>
</body>
</html>















