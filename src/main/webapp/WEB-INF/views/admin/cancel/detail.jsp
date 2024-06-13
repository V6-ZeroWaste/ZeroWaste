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
.title {
	display: flex;
	justify-content: space-between;
	align-items: center;
}
</style>
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
                    $('#statusText').text('취소 승인');
                } else if (resp.message === "거절 완료") {
                    $('#cancelStatus').text('취소 거절');
                    $('#statusText').text('취소 거절');
                    
                }
                $('#rejectBtn').remove();
                $('#approveBtn').remove();
                
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
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/include/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="title">
						<h1 class="mt-4">취소 상세</h1>
						<button class="btn btn-dark my-3 returnButton"
							onclick="window.location.href='/admin/cancel/list'">돌아가기</button>
					</div>
					<div class="card mb-4">
						<div class="card-header">
							<h4 id="statusText" class="mt-4">
								상태 :
								<c:choose>
									<c:when test="${cancelDetail.cancel_status == 0}">취소 요청</c:when>
									<c:when test="${cancelDetail.cancel_status == 1}">취소 승인</c:when>
									<c:when test="${cancelDetail.cancel_status == 3}">취소 거절</c:when>
									<c:when test="${cancelDetail.cancel_status == 2}">취소 확정</c:when>
								</c:choose>
							</h4>
						</div>
						<div class="card-body">
							<div class="datatable-container">
								<p>주문번호: ${cancelDetail.order_no}</p>
								<p>주문상세번호: ${cancelDetail.order_detail_no }</p>
								<label class="btn btn-primary"> <input type="radio"
									name="cancel_reason" value="1"
									<c:if test="${cancelDetail.cancel_reason_type == 1}">checked disabled</c:if>
									<c:if test="${cancelDetail.cancel_reason_type != 1}">disabled</c:if>>배송
									지연
								</label> <label class="btn btn-primary"> <input type="radio"
									name="cancel_reason" value="2"
									<c:if test="${cancelDetail.cancel_reason_type == 2}">checked disabled</c:if>
									<c:if test="${cancelDetail.cancel_reason_type != 2}">disabled</c:if>>제품
									불량
								</label> <label class="btn btn-primary"> <input type="radio"
									name="cancel_reason" value="3"
									<c:if test="${cancelDetail.cancel_reason_type == 3}">checked disabled</c:if>
									<c:if test="${cancelDetail.cancel_reason_type != 3}">disabled</c:if>>단순
									변심
								</label>
								<div>
									<input type="text" value="${cancelDetail.cancel_reason_detail}"
										readonly
										style="width: 100%; margin-top: 10px; background-color: #f0f0f0; border: 1px solid #ddd;">
								</div>
							</div>
						</div>
					</div>


					<div class="card mb-4">
						<div class="card-header">
							<h4 class="mt-4">최종 결제 정보</h4>
						</div>
						<div class="card-body">
							<div class="datatable-container">
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
							</div>
						</div>
					</div>

					<div class="card mb-4">
						<div class="card-header">
							<h4 class="mt-4">환불정보 확인</h4>
						</div>
						<div class="card-body">
							<div class="datatable-container">

								<b>환불수단: ${cancelDetail.payment_method}
									</p>
									<p>
										<b>환불금액: ${cancelDetail.refund_price}원 
									</p>
									<p>
										<b>환불 적립금: ${cancelDetail.refund_point}원 
									</p>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="list-group-item d-flex justify-content-center">
					<c:choose>
						<c:when test="${cancelDetail.cancel_status == 0}">
							<button id="rejectBtn" class="btn btn-danger"
								style="height: 38px"
								onclick="confirmRefuseCancel(${cancelDetail.order_detail_no})">거절</button>
							<button id="approveBtn" class="btn btn-primary"
								style="height: 38px"
								onclick="confirmApproveCancel(${cancelDetail.order_detail_no})">승인</button>
						</c:when>
					</c:choose>
				</div>
			</main>
			<%@ include file="/WEB-INF/views/admin/include/footer.jsp"%>
		</div>
	</div>

</body>
</html>
