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

<title>soaff mypage QnA</title>
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
    width: 200px; 
    height: auto; 
}

.disable-link {
	pointer-events: none;
}

.order-preview {
	width: 180px;
}
</style>
<script type="text/javascript">
function redirectToUpdate() {
	var qnaNo = document.getElementById('qna_no').value;
    window.location.href = '/mypage/qna/update?qna_no=' + qnaNo;
}

function redirectToItem(itemNo) {
	console.log("Item No: ", itemNo);
	window.location.href = '/item/detail?item_no=' + itemNo;
}

var qna_no = ${vo.qna_no};
function deleteQna() {
    if (confirm("정말 삭제하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "/mypage/qna/delete",
            data: { qna_no: ${vo.qna_no} },
            success: function(response) {
                if (response === 1) {
                    alert("문의가 삭제되었습니다.");
                    location.href = "/mypage/qna/list";
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
console.log("Initial Item No: ", ${vo.item_no});
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
						<div class="col-12">
							<h3 class="mb-0">QnA Detail</h3>
						</div>


						<div class="col-12">
							<div class="order">
								<div class="row align-items-center" style="height: 110px">
									<div class="col-lg-2 order-preview justify-content-center">
										<!-- 상품이미지 -->
										<a href="product-1.html" title="${vo.item_name }"
											class="disable-link" data-toggle="tooltip"
											data-placement="top"> <img src="${vo.item_img}"
											alt="${vo.item_name }">
										</a>
									</div>
									<div class="col-lg-4">
										<h3 class="order-number">${vo.item_name}</h3>
									</div>
									<div class="col-lg-4"></div>
									<div class="col-lg-2">
										<!-- 상품 바로가기 링크 -->
										<a href="#!" class="action eyebrow underline"
											onclick="redirectToItem(${vo.item_no})">View Item</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-12">
							<div style="border: 1px solid #dddddd;">
								<table class="table table-borderless">
									<tbody>
										<tr>
											<th scope="row">Date</th>
											<td><fmt:formatDate value="${vo.question_date}"
													pattern="yyyy-MM-dd" /></td>
											<td style="text-align: right">${vo.replyState}</td>
										</tr>
										<tr>
											<th scope="row">Title</th>
											<td colspan="2">${vo.title}</td>
										</tr>
										<tr>
											<th scope="row">type</th>
											<td colspan="2">${vo.typeString}</td>
										</tr>
										<tr>
											<th>Content</th>
											<td colspan="2"><pre
													style="white-space: pre-wrap; word-wrap: break-word;">${vo.content}</pre>
											</td>
										</tr>
										<c:if test="${not empty vo.qna_img}">
											<tr>
												<th>Image</th>
												<td colspan="2"><img class="qna-img"
													src="${vo.qna_img}" /></td>
											</tr>
										</c:if>
									</tbody>
								</table>
								<input type="hidden" id="qna_no" value="${vo.qna_no}">
							</div>
						</div>
						<div class="col-12" style="text-align: center">
							<button class="btn btn-primary" onclick="redirectToUpdate()">수정</button>
							<button class="btn btn-danger" onclick="deleteQna()">삭제</button>
						</div>

						<div class="col-12">
							<div style="border: 1px solid #dddddd;">
								<table class="table table-borderless">
									<tbody>
										<tr>
											<th scope="row">Date</th>
											<td><fmt:formatDate value="${vo.reply_date}"
													pattern="yyyy-MM-dd" /></td>
										</tr>
										<tr>
											<th scope="row">Reply</th>
											<td colspan="2">${vo.reply}</td>
										</tr>

									</tbody>
								</table>
							</div>
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
