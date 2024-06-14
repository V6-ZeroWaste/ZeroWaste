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
<title>강제 취소</title>
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
function redirectToDetail() {
    var orderNo = document.querySelector('input[name="order_no"]').value;
    var userId = document.querySelector('input[name="user_id"]').value;
    window.location.href = '/admin/order/detail?order_no=' + orderNo + '&id=' + userId;
}
function confirmForceCancel(order_detail_no) {
    const reasonDetail = $('#cancel_reason_detail').val();
    if (confirm("정말 주문을 강제 취소하시겠습니까?")) {
        updateCancelStatus(order_detail_no, reasonDetail);
    }
}

function updateCancelStatus(order_detail_no, reasonDetail) {
    const url = "${pageContext.request.contextPath}/admin/cancel/force/" + order_detail_no;
    $.ajax({
        type: "POST",
        url: url,
        data: {
            cancel_reason_type: 1,
            cancel_reason_detail: reasonDetail
        },
        success: function(resp) {
            if (resp.status === "success") {
                alert(resp.message);
                if (resp.message === "강제 취소 완료.") {
                    $('#cancelStatus').text('강제 취소 완료');
                }
                $('#forceCancelBtn').remove();
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
    window.location.href = "${pageContext.request.contextPath}/admin/order/detail";
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
						<h1 class="mt-4">강제 취소</h1>
						<input type="hidden" name="order_no" value="${forceDetail.order_no}">
<input type="hidden" name="user_id" value="${forceDetail.user_id}">
<button class="btn btn-primary my-3 returnButton" onclick="redirectToDetail()">돌아가기</button>
						

					</div>
					<div class="card mb-4"">
						<div class="card-header">
							<h4 class="mt-4">
								<b>${forceDetail.item_name}</b>에 대한 주문을 취소하시겠습니까?
							</h4>
						</div>
						<div class="card-body">
							<div class="datatable-container">
								<p>
									<b>주문번호: ${forceDetail.order_no} 
								</p>
								<p>
									<b>주문상세번호: ${forceDetail.order_detail_no } 
								</p>
								<label class="btn btn-primary"><input type="radio"
									name="cancel_reason" value="1" checked disabled> 제품 불량
								</label>

								<div>
									<input type="text" id="cancel_reason_detail"
										placeholder="상세 사유 입력 (선택사항)"
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
								<p>
									<b>총 주문 금액: ${forceDetail.total_price}원 
								</p>
								<p>
									<b>적립금 사용: ${forceDetail.point}원 
								</p>
								<p>
									<b>배송비 : ${forceDetail.delivery_price}원 
								</p>
								<p>
									<b>최종 결제금액: ${forceDetail.payment_price}원 
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
								<p>
									<b>환불수단: ${forceDetail.payment_method} 
								</p>
								<p>
									<b>환불금액: ${forceDetail.refund_price}원 
								</p>
								<p>
									<b>환불 적립금: ${forceDetail.refund_point}원 
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="list-group-item d-flex justify-content-center">
					<button id="forceCancelBtn" class="btn btn-primary"
						onclick="confirmForceCancel(${forceDetail.order_detail_no})">취소
						신청</button>

				</div>
		</main>
		
		<%@ include file="/WEB-INF/views/admin/include/footer.jsp"%>
	</div>
	</div>

</body>
</html>
