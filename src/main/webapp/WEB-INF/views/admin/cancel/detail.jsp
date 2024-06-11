<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>취소 상세</title>
<link href="${pageContext.request.contextPath}/admin/css/styles.css"
	rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/admin/js/scripts.js"></script>
<style>
.cancelDetailPage {
	width: 100%;
	margin: auto;
	margin-top: 30px;
}

.cancelStatus {
	border: 1px solid #ddd;
	padding: 20px;
	margin-top: 20px;
}

.cancelStatus h2 {
	margin-bottom: 20px;
}

.cancelStatus p {
	margin-top: 30px;
}

.actionButtons {
	margin-top: 20px;
	text-align: center;
}

.actionButtons button {
	width: 100px;
	margin: 0 10px;
}

.cancelReasonOptions {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.cancelReasonOptions label {
	border: 1px solid black;
	text-align: left;
	padding: 5px;
}

.cancelReasonOptions input {
	margin-right: 5px;
}

.returnButton {
	position: absolute;
	right: 20px;
	top: 20px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/include/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="cancelDetailPage">
					<h1>
						<b>취소 상세
							<button class="btn btn-dark my-3 returnButton"
								onclick="history.back()">돌아가기</button>
					</h1>
					<div class="cancelStatus">
						<p>
							<span id="cancelStatus"> <c:choose>
									<c:when test="${cancelDetail.cancel_status == 0}">취소 요청</c:when>
									<c:when test="${cancelDetail.cancel_status == 1}">취소 승인</c:when>
									<c:when test="${cancelDetail.cancel_status == 3}">취소 거절</c:when>
									<c:when test="${cancelDetail.cancel_status == 2}">취소 확정</c:when>
								</c:choose>
							</span>
						</p>
						<div class="cancelReasonOptions">
							<label><b> <input type="radio" name="cancel_reason"
									value="1"
									<c:if test="${cancelDetail.cancel_reason_type == 1}">checked disabled</c:if>>
									배송 지연 </label> <label> <input type="radio" name="cancel_reason"
								value="2"
								<c:if test="${cancelDetail.cancel_reason_type == 2}">checked disabled</c:if>>
								제품 불량
							</label> <label> <input type="radio" name="cancel_reason"
								value="3"
								<c:if test="${cancelDetail.cancel_reason_type == 3}">checked disabled</c:if>>
								단순 변심
							</label>
						</div>
						<div>
							<input type="text" value="${cancelDetail.cancel_reason_detail}"
								readonly
								style="width: 100%; background-color: #f0f0f0; border: 1px solid #ddd;">
						</div>

						<h3 style="margin-top: 30px;">
							<b>최종 결제 정보 
						</h3>
						<p>
							<b>총 주문 금액: ${cancelDetail.total_price}원 
						</p>
						<p>
							<b>적립금 사용: ${cancelDetail.point}원 
						</p>
						<p>
							<b>배송비 : ${cancelDetail.delivery_price}원 
						</p>
						<p>
							<b>최종 결제금액: ${cancelDetail.payment_price}원 
						</p>

						<h3 style="margin-top: 80px;">
							<b>환불정보 확인 
						</h3>
						<p>
							<b>환불수단: ${cancelDetail.payment_method} 
						</p>
						<p>
							<b>환불금액: ${cancelDetail.refund_price}원 
						</p>
						<p>
							<b>환불 적립금: ${cancelDetail.refund_point}원 
						</p>
					</div>
					<div class="actionButtons">
						<c:choose>
							<c:when test="${cancelDetail.cancel_status == 0}">
								<button id="rejectBtn" class="btn btn-danger"
									onclick="confirmRefuseCancel(${cancelDetail.order_detail_no})">거절</button>
								<button id="approveBtn" class="btn btn-primary"
									onclick="confirmApproveCancel(${cancelDetail.order_detail_no})">승인</button>
							</c:when>
							<c:otherwise>
								<button id="confirmBtn" class="btn btn-primary"
									onclick="goToList()">확인</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</main>
			<%@ include file="/WEB-INF/views/admin/include/footer.jsp"%>
		</div>
	</div>
	<script>
function confirmApproveCancel(order_detail_no) {
    if (confirm("승인 하시겠습니까?")) {
        updateCancelStatus(order_detail_no, 'approve');
    }
}

function confirmRefuseCancel(order_detail_no) {
    if (confirm("거절 하시겠습니까?")) {
        updateCancelStatus(order_detail_no, 'refuse');
    }
}

function updateCancelStatus(order_detail_no, action) {
    let url = '';
    if (action === 'approve') {
        url = "${pageContext.request.contextPath}/admin/cancel/approve/" + order_detail_no;
    } else if (action === 'refuse') {
        url = "${pageContext.request.contextPath}/admin/cancel/refuse/" + order_detail_no;
    }

    $.ajax({
        type: "POST",
        url: url,
        success: function(resp) {
            if (resp.status === "success") {
                alert(resp.message);
                if (resp.message === "승인 완료") {
                    $('#cancelStatus').text('취소 승인');
                } else if (resp.message === "거절 완료") {
                    $('#cancelStatus').text('취소 거절');
                }
                $('#rejectBtn').remove();
                $('#approveBtn').remove();
                $('.actionButtons').append('<button id="confirmBtn" class="btn btn-primary" onclick="goToList()">확인</button>');
            } else {
                alert('관리자에게 문의하세요.');
            }
        },
        error: function() {
            alert('관리자에게 문의하세요.');
        }
    });
}



function goToList() {
    window.location.href = "${pageContext.request.contextPath}/admin/cancel/list";
}
</script>
</body>
</html>
