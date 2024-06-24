<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
<link rel="stylesheet" href="/user/css/vendor.css" />
<link rel="stylesheet" href="/user/css/style.css" />
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script src="/admin/js/datatables-simple-demo.js"></script>

<title>Review Post</title>

<style>
.review-info {
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

.review-img {
	max-width: 70%;
}

input {
	width: 90%;
	margin: auto;
}

.item-img {
	max-height: 99.98px;
}

.star-rating-wrapper {
	display: flex;
	justify-content: flex-start;
	align-items: center;
}

.star-rating {
	display: flex;
	flex-direction: row-reverse;
	font-size: 1.5em;
}

.star-rating input {
	display: none;
}

.star-rating label {
	cursor: pointer;
	color: #ddd;
}

.star-rating input:checked ~ label, .star-rating input:hover ~ label,
	.star-rating label:hover ~ label {
	color: #f2b600;
}
</style>

<script type="text/javascript">
	function postReview() {
		var formData = new FormData(document.getElementById('reviewForm'));
		var title = document.getElementById('title').value;
		var content = document.getElementById('content').value;
		var score = document.querySelector('input[name="rating"]:checked').value;
		var review_img = document.getElementById('file').files[0];

		if (!title || !content || !score) {
			alert("모든 필수 항목을 입력해주세요.");
			return;
		}

		
		formData.append("score", score);
		if (review_img) {
			formData.append("review_img", review_img);
		}

		if (confirm("정말 등록하시겠습니까?")) {
			$.ajax({
				type : "POST",
				url : "/mypage/review/postReview",
				data : formData,
				contentType : false,
				processData : false,
				success : function(response) {
					if (response === "1") {
						alert("리뷰가 등록되었습니다.");
						window.location.href = '/mypage/review/list';
					} else {
						alert("리뷰 등록에 실패하였습니다.");
					}
				},
				error : function() {
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
							<h3 class="mb-0">Review Post</h3>
						</div>
						<!-- /title -->

						<!-- item info card -->
						<div class="col-12">
							<div style="border: 1px solid #dddddd;">
								<div class="row align-items-center" style="min-height: 100px">
									<div style="width: 140px; text-align: center">
										<!-- 상품이미지 -->
										<a href="product-1.html"
											title="Fawn Wool / Natural Mammoth Chair"
											data-toggle="tooltip" data-placement="top"> <img
											class="item-img" src="${vo.item_img}"
											alt="Fawn Wool / Natural Mammoth Chair">
										</a>
									</div>
									<div style="width: 400px">
										<h3 class="order-number">${vo.item_name}</h3>
									</div>
									
								</div>
							</div>
						</div>
						<!-- /review info card -->

						<!-- review detail card -->
						<div class="col-12">
							<form id="reviewForm" enctype="multipart/form-data">
								<!-- Hidden fields -->
								<input type="hidden" name="user_no" value="${vo.user_no}">
								<input type="hidden" name="user_id" value="${vo.user_id}">
								<input type="hidden" name="order_detail_no"
									value="${vo.order_detail_no}"> <input type="hidden"
									name="item_no" value="${vo.item_no}"> <input
									type="hidden" name="order_no" value="${vo.order_no}">

								<div style="border: 1px solid #dddddd;">
									<table class="table table-borderless">
										<tbody>
											<tr>
												<th scope="row">Score</th>
												<td colspan="2">
												<div class="star-rating-wrapper">
														<div class="star-rating">
															<input type="radio" id="5-stars" name="rating" value="5" /><label
																for="5-stars" class="star">&#9733;</label> <input
																type="radio" id="4-stars" name="rating" value="4" /><label
																for="4-stars" class="star">&#9733;</label> <input
																type="radio" id="3-stars" name="rating" value="3" /><label
																for="3-stars" class="star">&#9733;</label> <input
																type="radio" id="2-stars" name="rating" value="2" /><label
																for="2-stars" class="star">&#9733;</label> <input
																type="radio" id="1-stars" name="rating" value="1" /><label
																for="1-stars" class="star">&#9733;</label>
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row">Title</th>
												<td colspan="2"><input type="text" id="title"
													name="title" class="form-control"></td>
											</tr>
											<tr>
												<th>Content</th>
												<td colspan="2">
													<div>
														<textarea id="content" name="content" class="form-control"
															style="height: 200px"></textarea>
													</div>
												</td>
											</tr>
											<tr>
												<th>Image</th>
												<td colspan="2"><input class="form-control" type="file"
													name="review_img" id="file" class="wid100" /></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="col-12" style="text-align: center">
									<button id="post" class="btn btn-primary" type="button"
										onclick="postReview()">등록</button>
								</div>
							</form>



						</div>
					</div>
					<!-- /content -->
				</div>
			</div>
		</div>

	</section>
	<%@ include file="/WEB-INF/views/user/include/footer.jsp"%>
</body>
</html>
