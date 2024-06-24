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

<title>Qna Post</title>
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
function postQna() {
    var formData = new FormData(document.getElementById('qnaForm'));
    var title = document.getElementById('title').value;
    var content = document.getElementById('content').value;
    var type = document.getElementById('type').value
    var qna_img = document.getElementById('file').files[0];
    var user_no = document.querySelector('input[name="user_no"]').value;
    var item_no = document.querySelector('input[name="item_no"]').value;
   

    if (!title || !content) {
        alert("모든 필수 항목을 입력해주세요.");
        return;
    }

    formData.append("user_no", user_no);
    formData.append("item_no", item_no);

    if (qna_img) {
        formData.append("qna_img", qna_img);
    }

    // formData의 값 확인
    for (var pair of formData.entries()) {
        console.log(pair[0]+ ': ' + pair[1]); 
    }

    if (confirm("정말 등록하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "/mypage/qna/postQna",
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                if (response === "1") {
                    alert("문의가 등록되었습니다.");
                    window.location.href = '/mypage/qna/list';
                } else {
                    alert("문의 등록에 실패하였습니다.");
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
					<!-- content -->
					<div class="row">
						<!-- title -->
						<div class="col-12">
							<h3 class="mb-0">Qna Post</h3>
						</div>
						<!-- /title -->

						<!-- item info card -->
						<div class="col-12">
							<div style="border: 1px solid #dddddd;">
								<div class="row align-items-center" style="min-height: 100px">
									<div style="width: 140px; text-align: center">
										<!-- 상품이미지 -->
										<a href="product-1.html" title="${itemVo.name}"
											data-toggle="tooltip" data-placement="top"> <img
											class="item-img" src="${itemVo.item_img}"
											alt="${itemVo.name}">
										</a>
									</div>
									<div style="width: 400px">
										<h3 class="order-number">${itemVo.name}</h3>
									</div>

								</div>
							</div>
						</div>
						<div class="col-12">
							<form id="qnaForm" enctype="multipart/form-data">
								<input type="hidden" name="user_no" value="${qnaVo.user_no}" />
								<input type="hidden" name="item_no" value="${itemVo.item_no}" />
								<div style="border: 1px solid #dddddd;">
									<table class="table table-borderless">
										<tbody>
											<tr>
												<th scope="row">Title</th>
												<td colspan="2"><input type="text" id="title"
													name="title" class="form-control" value="${qnaVo.title}"></td>
											</tr>
											<tr>
												<th>Type</th>
												<td colspan="2"><select id="type" name="type"
													class="datatable-selector">
														<option value="교환/환불문의">교환/환불문의</option>
														<option value="상품상세문의">상품상세문의</option>
												</select></td>
											</tr>
											<tr>
												<th>Content</th>
												<td colspan="2">
													<div>
														<textarea id="content" name="content" class="form-control"
															style="height: 200px">${qnaVo.content}</textarea>
													</div>
												</td>
											</tr>
											<tr>
												<th>Image</th>
												<td colspan="2"><input class="form-control" type="file"
													name="qna_img" id="file" class="wid100" /></td>
											</tr>
										</tbody>
									</table>
								</div>

								<div class="col-12" style="text-align: center">
									<button id="post" type="button" class="btn btn-primary" style="margin-top:10px"
										onclick="postQna();">등록</button>
								</div>
								<!-- /content -->
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/user/include/footer.jsp"%>
</body>
</html>
