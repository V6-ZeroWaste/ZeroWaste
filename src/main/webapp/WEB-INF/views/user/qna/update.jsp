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
.qna-info {
	position: relative;
	padding-left: 1.25rem;
	font-size: 0.875rem;
}

.col-12 {
	margin-bottom: 10px;
}

th {
	width: 120px;
}

.qna-img {
	max-width: 70%;
}

input {
	width: 90%;
	margin: auto;
}

.item-img {
	max-height: 99.98px;
}
</style>
<script type="text/javascript">
var qna_no = ${vo.qna_no};

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
					window.location.href = '/user/qna/list';
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
	<div style="width: 700px; margin: auto;">
		<!-- content -->
		<div class="row">
			<!-- title -->
			<div class="col-12">
				<h3 class="mb-0">문의 수정</h3>
			</div>
			<!-- /title -->

			<!-- item info card -->
			<div class="col-12">
				<div style="border: 1px solid #dddddd;">
					<div class="row align-items-center" style="min-height: 100px">
						<div style="width: 140px; text-align: center">
							<!-- 상품이미지 -->
							<a href="product-1.html"
								title="Fawn Wool / Natural Mammoth Chair" data-toggle="tooltip"
								data-placement="top"> <img class="item-img"
								src="${vo.qna_img}" alt="Fawn Wool / Natural Mammoth Chair">
							</a>
						</div>
						<div style="width: 400px">
							<h3 class="order-number">${vo.item_name}</h3>
						</div>
						<div style="width: 130px">
							<!-- 상품 바로가기 링크 -->
							<a href="#!" class="action eyebrow underline">View Item</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div style="border: 1px solid #dddddd;">
					<table class="table table-borderless">
						<tbody>
							<tr>
								<th scope="row">Title</th>
								<td colspan="2"><input type="text" id="title"
									class="form-control" value="${vo.title}"></td>
							</tr>
							<tr>
								<th>Content</th>
								<td colspan="2">
									<div>
										<textarea id="content" class="form-control"
											style="height: 200px">${vo.content}</textarea>
									</div>
								</td>
							</tr>
							<tr>
								<th>Image</th>
								<td colspan="2"><input class="form-control" type="file"
									name="file" id="file" class="wid100" /></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="col-12" style="text-align: center">
				<button id="update" class="btn btn-primary"
					onclick="handleUpdate();">수정</button>
			</div>
		</div>
		<!-- /content -->
	</div>
</body>
</html>
