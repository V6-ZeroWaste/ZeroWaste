<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css"/>
    <link rel="stylesheet" href="/user/css/style.css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

    <title>soaff order</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<style>
    #orderInfo {
        margin-left: 10px;
        margin-top: 30px;
    }


    #orderInfo th {
        width: 200px;
        vertical-align: middle;
    }


    #deliveryInfo {
        margin-left: 10px;
        margin-top: 30px;
    }

    #deliveryInfo th {
        width: 200px;
        vertical-align: middle;
    }

    #deliveryInfo tr {
        width: 500px;
    }

    #paymentMethodTable {
        margin-left: 10px;
        margin-top: 30px;
        margin-bottom: 30px;
    }

    #paymentMethodTable th {
        width: 200px;
        vertical-align: middle;
    }

    #paymentInfoTable th {
        width: 200px;
        vertical-align: middle;
    }

    #agreeContainer {
        margin-top: 30px;
        margin-bottom: 10px;
    }

</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script>


    let isValid;
    //let paymentResult;

    function fieldCheck() {
        isValid = true;
        let receiverName = $("#receiverName");
        let zipcode = $("#zipcode");
        let addr = $("#addr");
        let addrDetail = $("#addrDetail");
        let receiverTel1 = $("#receiverTel1");
        let receiverTel2 = $("#receiverTel2");
        let receiverTel3 = $("#receiverTel3");
        let paymentMethod = $("#paymentMethod");
        let agree = $("#agree").prop('checked');

        let receiverNameCheckMsg = $("#receiverNameCheckMsg");
        let zipcodeCheckMsg = $("#zipcodeCheckMsg");
        let addrCheckMsg = $("#addrCheckMsg");
        let addrDetailCheckMsg = $("#addrDetailCheckMsg");
        let receiverTel1CheckMsg = $("#receiverTel1CheckMsg");
        let receiverTel2CheckMsg = $("#receiverTel2CheckMsg");
        let receiverTel3CheckMsg = $("#receiverTel3CheckMsg");
        let paymentMethodCheckMsg = $("#paymentMethodCheckMsg");
        let agreeCheckMsg = $("#agreeCheckMsg");

        receiverNameCheckMsg.css("display", "none");
        zipcodeCheckMsg.css("display", "none");
        addrCheckMsg.css("display", "none");
        addrDetailCheckMsg.css("display", "none");
        receiverTel1CheckMsg.css("display", "none");
        receiverTel2CheckMsg.css("display", "none");
        receiverTel3CheckMsg.css("display", "none");
        paymentMethodCheckMsg.css("display", "none");
        agreeCheckMsg.css("display", "none");


        if (!receiverName.val()) {
            receiverNameCheckMsg.html("받으실 분의 성함을 입력해주세요");
            receiverNameCheckMsg.css("display", "block");
            receiverName.focus();
            isValid = false;
        }

        if (!zipcode.val()) {
            zipcodeCheckMsg.html("우편번호를 입력해주세요");
            zipcodeCheckMsg.css("display", "block");
            zipcode.focus();
            isValid = false;
        }

        if (!addr.val()) {
            addrCheckMsg.html("주소를 입력해 주세요");
            addrCheckMsg.css("display", "block");
            addr.focus();
            isValid = false;
        }
        if (!addrDetail.val()) {
            addrDetailCheckMsg.html("상세주소를 입력해 주세요");
            addrDetailCheckMsg.css("display", "block");
            addrDetail.focus();
            isValid = false;
        }
        if (!receiverTel1.val() || !receiverTel2.val() || !receiverTel3.val()) {
            receiverTel1CheckMsg.html("전화번호를 입력해주세요");
            receiverTel1CheckMsg.css("display", "block");

            if (!receiverTel2.val()) {
                receiverTel2.focus();
            }
            if (!receiverTel3.val()) {
                receiverTel3.focus();
            }

        }
        if (!agree) {
            agreeCheckMsg.html("주문 동의가 필요합니다");
            agreeCheckMsg.css("display", "block");
            isValid = false;
        }

        return isValid;
    }

    window.onload = function () {

        aboutTotalPrice();
        telFormat();
        paymentInfo();
        let orderName = portOneOrderName();
        console.log(orderName);

        $("#receiverName, #zipcode, #addr, #addrDetail, #receiverTel1, #receiverTel2, #receiverTel3, #paymentMethod, #agree").on("change", fieldCheck);

        $("#zipcode").on('click', function () {

            if (!$("#zipcode").val()) {
                zipcode();
            }


        });


        $("#addr").on('click', function () {

            if (!$("#addr").val()) {
                zipcode();
            }
        });

        $("#searchZipcode").on('click', function () {

            if (!$("#addr").val()) {
                zipcode();
            }
        });

        $("#goPay").on('click', function () {
            var agree = $("#agree").is(":checked");

            if (fieldCheck()) {
                
                request_pay();
                

            }
            
             if (!agree) {
                 alert("주문 동의가 필요합니다");
                 $("#agree").focus();
            
            }


        });

        $('#pointBtn').on('click', function () {
            // 유효성 검사를 실행하고 성공하면 paymentInfo 함수 호출
            if (validatePointInput()) {
                paymentInfo();
            }
        });

    };

    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function zipcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                /*
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                */
                $('#zipcode').val(data.zonecode);
                $('#addr').val(roadAddr);
            }
        }).open();
    }

    function generateUuid() {
        // 4자리 랜덤 숫자 생성
        const randomNumber = Math.floor(1000 + Math.random() * 9000); // 1000부터 9999까지의 숫자 생성

        // 현재 타임스탬프 생성
        const timestamp = Date.now(); // 밀리초 단위의 현재 타임스탬프

        // 랜덤 숫자와 타임스탬프 결합
        return randomNumber + "-" + timestamp;
    }

    async function request_pay() {
        const orderUuid = generateUuid();
        // console.log(orderUuid);
        let order_name = portOneOrderName();
        let payment_price = parseFloat($('#paymentPrice').text().replace(/[^0-9.-]/g, ''))
        let payMethod = $('input[name=paymentMethod]:checked').val();
        let paymentId = 'payment-' + orderUuid
        const response = await PortOne.requestPayment({
            // Store ID 설정
            storeId: "store-cfa799d7-b5cc-4fb8-b538-98363bffffbd",
            // 채널 키 설정
            channelKey: "channel-key-8f312486-23c0-4ee3-95b4-5a26210375f3",
            paymentId: paymentId,
            orderName: order_name,
            totalAmount: payment_price,
            currency: "CURRENCY_KRW",
            payMethod: payMethod,
        });
        //console.log(response);

        if (response.code != null) {
            // 오류 발생
            return alert(response.message);
        }

        // db `order` 업데이트 정보
        let point = (parseFloat($('#pointToUse').val().replace(/[^0-9.-]/g, '')) * -1) || 0;
        let order_status = 2
        let receiver_name = $('#receiverName').val();
        let zipcode = $('#zipcode').val();
        let addr = $('#addr').val();
        let addr_detail = $('#addrDetail').val();
        let receiver_tel = $('#receiverTel1').val() + "-" + $('#receiverTel2').val() + "-" + $('#receiverTel3').val();
        let delivery_request = $('#deliveryRequest').val();
        let delivery_price = 3000;
        let buyer_name = $('#buyerName').text();
        let buyer_email = $('#buyerEmail').text();
        let buyer_tel = $('#buyerTel').text();
        let delivery_status = 0;
        let payment_date = currDate();
        let pointPlusContent = order_name + "주문건 적립";
        let pointContent = order_name + "주문시 적립금 사용";
        let pointPlus = parseFloat($('#estimatedPoint').text().replace(/[^0-9.-]/g, '')) || 0;

        
        let data = {
            payment_date: payment_date,
            payment_price: payment_price,
            payment_method: payMethod,
            payment_id: paymentId,
            point: point,
            order_status: order_status,
            order_name: order_name,
            receiver_name: receiver_name,
            zipcode: zipcode,
            addr: addr,
            addr_detail: addr_detail,
            receiver_tel: receiver_tel,
            delivery_request: delivery_request,
            delivery_price: delivery_price,
            buyer_name: buyer_name,
            buyer_email: buyer_email,
            buyer_tel: buyer_tel,
            delivery_status: 0,
            pointPlusContent: pointPlusContent,
            pointContent: pointContent,
            pointPlus: pointPlus

        };

        $.ajax({
            type: "POST", // method type
            url: "/order/insert", // 요청할 url
            data: JSON.stringify(data), // 전송할 데이터를 JSON 문자열로 변환
            contentType: "application/json ; charset=UTF-8", // 요청 데이터의 Content-Type을 JSON으로 설정
            success: function (resp) {
            	
            	
            	//console.log(resp);
            	if(resp == 'success'){
            		//paymentResult = true;
            		deleteCart();

                  	
            	}
            	else{
            		//paymentResult =false;
            	}
            	
            	
            },
            error: function (data, textStatus) {
                $('#fail').html("관리자에게 문의하세요."); // 서버오류
                console.log('error', data, textStatus);
            }
        })


    }
    
    
    function deleteCart() {
        let spans = document.querySelectorAll('span[id^="itemTotalPrice"]');

        // 선택된 태그들의 cart_no 속성 값을 저장할 배열
        let cartNoList = [];

        // 각 <span> 태그에서 cart_no 속성 값을 추출하여 배열에 추가
        spans.forEach(span => {
            let cartNo = span.getAttribute('cart_no');
            if (cartNo !== null) {
                cartNoList.push(cartNo);
            }
        });

        console.log(cartNoList);

        // 데이터 객체 생성
        var data = {
            checkedCartNo: cartNoList // checkedCartNo를 배열로 전달
        };

        // AJAX 요청
        $.ajax({
            type: "GET", // 요청 메서드 타입
            url: "/order/deleteCartAfterOrder", // 요청할 URL
            traditional: true, // 배열 데이터 전송 시 필요한 옵션
            data: data, // 전송할 데이터
            success: function(resp) {
                if (resp === 'success') {
                    console.log("return true");
                    location.href = "/order/success";
                    
                    // 성공적으로 처리된 경우
                }
            },
            error: function(data, textStatus) {
                $('#fail').html("관리자에게 문의하세요."); // 에러 메시지 출력
                console.log('error', data, textStatus);
            }
        });
    }

    function currDate() {
    	const date = new Date();
    	const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const day = date.getDate().toString().padStart(2, '0');
        const hours = date.getHours().toString().padStart(2, '0'); // 24시간 형식
        const minutes = date.getMinutes().toString().padStart(2, '0');
        const seconds = date.getSeconds().toString().padStart(2, '0');
        const result = year + "-" + month + "-" + day+" "+hours+ "-" +minutes+ "-" +seconds;

        return result;
    }

    function aboutTotalPrice() {
        var total = 0;

        // id가 'itemTotalPrice'로 시작하는 모든 span 요소를 선택
        $('span[id^="itemTotalPrice"]').each(function () {
            // 각 span 요소의 텍스트 값을 가져와서 숫자로 변환
            var value = parseFloat($(this).text().replace(/[^0-9.-]/g, ''));

            // 값이 유효한 경우 total에 더함
            if (!isNaN(value)) {
                total += value;
            }
        });

        // 합계 결과를 포맷팅하여 출력 (여기서는 '원'을 추가)
        $('#sumItemTotal').text(total.toLocaleString() + "원");
        $('#orderSummarySumItemTotal').text(total.toLocaleString() + "원");
        $('#paymentInfoSumItemTotal').text(total.toLocaleString() + "원");


        // value에 3000을 더함(배송비추가)
        total += 3000;

        // $('#sumDeliveryPrice')인 h4 태그 사이에 결과 출력
        $('#sumDeliveryPrice').text("= "+total.toLocaleString() + "원");
        $('#orderSummarySumDeliveryPrice').text(total.toLocaleString() + "원");
        $('#paymentPrice').text(total.toLocaleString() + "원");
        $('#goPay').text(total.toLocaleString() + "원 결제하기");
        
    }

    function telFormat() {
        // JSP에서 map.info.buyer_tel 값을 JavaScript 변수로 전달
        var buyerTel = "${map.info.buyer_tel}";

        // 전화번호를 '-' 기준으로 분리
        var phoneParts = buyerTel.split('-');

        // 분리된 전화번호를 각각의 input 요소에 할당
        if (phoneParts.length === 3) {
            $('#receiverTel1').val(phoneParts[0]);
            $('#receiverTel2').val(phoneParts[1]);
            $('#receiverTel3').val(phoneParts[2]);
        } else {
            console.error("Invalid phone number format.");
        }
    }

    function paymentInfo() {
        // id가 paymentInfoSumItemTotal인 td의 값을 숫자로 변환하여 가져옴
        var total = parseFloat($('#sumDeliveryPrice').text().replace(/[^0-9.-]/g, '')) || 0;

        // id가 pointToUse인 input 요소의 값을 숫자로 변환하여 가져옴
        var pointsToUse = parseFloat($('#pointToUse').val().replace(/[^0-9.-]/g, '')) || 0;
        //console.log(pointsToUse);

        // pointToUse의 값을 고려하여 finalPayment 계산
        var finalPayment = total - pointsToUse;

        // 결과를 id가 paymentPrice인 td에 넣음
        $('#paymentPrice').text(finalPayment.toLocaleString() + "원");
        $('#orderSummarySumDeliveryPrice').text(finalPayment.toLocaleString() + "원");
        $('#goPay').text(finalPayment.toLocaleString() + "원 결제하기");

        // 적립금 계산 (3%를 계산하고, 소수점 이하를 버림)
        var estimatedPoint = Math.floor(finalPayment * 0.03);

        // 결과를 id가 estimatedPoint인 td에 넣음
        $('#estimatedPoint').text(estimatedPoint.toLocaleString() + "원");
    }

    function validatePointInput() {
        // JSP에서 전달된 map.point 값을 JavaScript 변수로 가져옴
        var availablePoints = parseFloat("${map.point}");

        // id가 pointToUse인 input 요소의 값을 숫자로 변환하여 가져옴
        var inputPoints = parseFloat($('#pointToUse').val().replace(/[^0-9.-]/g, '')) || 0;

        // 입력값이 사용 가능한 포인트보다 큰 경우
        if (inputPoints > availablePoints) {
            // 경고 메시지를 표시
            alert("보유 포인트보다 작은 금액을 입력해주세요");

            // 입력값을 0으로 초기화
            $('#pointToUse').val();

            // 유효성 검사 실패를 나타내는 false 반환
            return false;
        }

        // 유효성 검사 성공을 나타내는 true 반환
        return true;
    }

    function portOneOrderName() {
        // JSP에서 전달된 cartCount 값을 가져옴
        var cartCount = ${map.cartCount};

        // id가 itemName인 <h5> 요소 사이의 텍스트 값을 가져옴
        var firstItemName = $('.media-title:first').text();


        // 최종 문자열을 저장할 변수
        var finalString = firstItemName;

        // cartCount가 2 이상이면, " 외 ${map.cartCount - 1} 개" 문자열을 추가
        if (cartCount >= 2) {
            finalString += " 외 " + (cartCount - 1) + " 개";
        }

        return finalString
    }

</script>


<body>


<!-- hero -->
<br>
<br>
<br>
<section>
    <div class="container">
        <div class="row">
            <div class="col text-center">
                <h1>Invoice</h1>
            </div>
        </div>
    </div>
</section>

<section class="no-overflow pt-0">
    <div class="container">
        <div class="row gutter-4 justify-content-between">

            <aside class="col-4">
                <div class="row">

                    <!-- order summary -->
                    <div class="col-12 mt-1">
                        <div class="card card-data bg-light">
                            <div class="card-header py-2 px-3">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <h3 class="fs-18 mb-0">Order Summary</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-minimal">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">

                                        <span id="orderSummarycountItemTotal" style="margin-left: 0px; color: #555555;">총 ${map.cartCount}개의 상품 금액</span>
                                        <span id="orderSummarySumItemTotal" style="color: #555555;"></span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        배송비
                                        <span>3,000원</span>
                                    </li>

                                </ul>
                            </div>
                            <div class="card-footer py-2">
                                <ul class="list-group list-group-minimal">
                                    <li class="list-group-item d-flex justify-content-between align-items-center text-dark fs-18">
                                        Total
                                        <span id="orderSummarySumDeliveryPrice"></span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>


                </div>
            </aside>


            <div class="col-8">
                <!--제목 -->
                <div class="row align-items-end mb-2">
                    <div class="col-6">
                        <h2 class="h3 mb-0"><span class="text-muted">01.</span> Order Items</h2>
                    </div>
                </div>


                <!-- item list 담는 박스 -->
                <div class="col-lg-12 cart-item-list mb-6">
                    <div class="row mb-1 d-none d-lg-flex">
                        <div class="col-lg-12">
                            <!-- 제목 -->
                            <div class="row pr-6">
                                <div class="col-lg-6"><span class="eyebrow">Product</span></div>
                                <div class="col-lg-2 text-center"><span class="eyebrow">Price</span></div>
                                <div class="col-lg-2 text-center"><span class="eyebrow">Quantity</span></div>
                                <div class="col-lg-2 text-center"><span class="eyebrow">Total</span></div>
                            </div>
                        </div>
                    </div>

                    <!-- cart item -->

                    <c:if test="${empty map.cartList}">
                        <div class="cart-item">
                            <div class="row align-items-center col-12 eyebrow" style="text-align : center;">
                                Empty
                            </div>
                        </div>
                    </c:if>


                    <c:forEach var="vo" items="${map.cartList }">
                        <div class="cart-item">
                            <div class="row align-items-center">
                                <div class="col-12 col-lg-6">
                                    <div class="media media-product">
                                        <img src="${vo.item_img}" alt="Image">
                                        <div class="media-body">
                                            <h5 class="media-title">${vo.name}</h5>
                                            <c:if test="${vo.packing_status eq 1}">
                                                <span class="small">포장O (+2,000원)</span>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-4 col-lg-2 text-center">

                                    <del><fmt:formatNumber value="${vo.price}" type="number" pattern="#,##0"/>원</del>

                                    <p class="cart-item-price" id="discountedPrice${vo.cart_no}"><fmt:formatNumber
                                            value="${vo.discounted_price}"
                                            type="number" pattern="#,##0"/>원</p>
                                </div>
                                <div class="col-4 col-lg-2 text-center">
                                    <div class="counter">
                                        <span class="counter-value">${vo.amount}</span>
                                    </div>
                                </div>
                                <div class="col-4 col-lg-2 text-center">
                                <span class="cart-item-price" id="itemTotalPrice${vo.cart_no}"
                                      cart_no="${vo.cart_no}"><fmt:formatNumber
                                        value="${vo.amount*vo.discounted_price}" type="number"
                                        pattern="#,##0"/>원</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- 합계-->
                    <br>
                    <div class="row gutter-1 mb-12">
                        <div class="col-4">
                            <div class="inline-block">
                                <h6 style="text-align: right">총 ${map.checkedCartCount}개의 상품 금액</h6>
                                <h4 style="text-align: right" class="h2" id="sumItemTotal"></h4>
                            </div>
                        </div>
                        <div class=" col-4">
                            <div class="inline-block">
                                <h6 style="text-align: right">배송비</h6>
                                <h4 style="text-align: right" class="h2">+ 3,000원</h4>
                            </div>
                        </div>
                        <div class=" col-4">
                            <div class="inline-block">
                                <h6 style="text-align: right">합계</h6>
                                <h4 style="text-align: right" class="h2" id="sumDeliveryPrice"></h4>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- Order Info -->

                <div class="row align-items-end mb-2">
                    <div class="col-md-6">
                        <h2 class="h3 mb-0"><span class="text-muted">02.</span> Order Info</h2>
                    </div>
                    <table class="table table-borderless" id="orderInfo">
                        <tbody>
                        <tr>
                            <th><b>주문자 이름</b></th>
                            <td id="buyerName">${orderVO.buyer_name}</td>
                        </tr>
                        <tr>
                            <th><b>전화번호</b></th>
                            <td id="buyerTel">${map.info.buyer_tel}</td>
                        </tr>
                        <tr>
                            <th><b>email</b></th>
                            <td id="buyerEmail">${map.info.buyer_email}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>


                <form>
                    <!-- delivery -->


                    <div class="row align-items-end mb-2">
                        <div class="col-md-6">
                            <h2 class="h3 mb-0"><span class="text-muted">03.</span> Delivery Info</h2>
                        </div>
                        <div class="col-md-6 text-md-right">
                            <a class="eyebrow">* 필수 입력값</a>
                        </div>
                        <table class="table table-borderless" id="deliveryInfo">
                            <tbody>
                            <tr>
                                <th><b>* 받으실 분</b></th>
                                <td><input type="text" class="form-control col-5 " name="receiverName" id="receiverName"
                                           placeholder="" value="${orderVO.buyer_name}">
                                    <div id="receiverNameCheckMsg" class="invalid-feedback"></div>
                                </td>

                            </tr>
                            <tr>
                                <th><b>* 우편번호</b></th>
                                <td>
                                    <div class="d-inline-flex col-12" style="padding-left: 0px;">
                                        <input type="text" class="form-control col-5" name="zipcode" id="zipcode"
                                               placeholder="" value="${map.info.zipcode}" readonly>
                                        <input type="button" class="btn btn-primary form-control col-4 ml-2"
                                               value="우편번호 검색" style="background-color: #FFFFFF; color: #618264;"
                                               id="searchZipcode">


                                    </div>
                                    <div id="zipcodeCheckMsg" class="invalid-feedback"></div>
                                </td>
                            </tr>
                            <tr>
                                <th><b>* 주소</b></th>
                                <td><input type="text" class="form-control" name="addr" id="addr" placeholder=""
                                           value="${map.info.addr}"
                                           readonly>
                                    <div id="addrCheckMsg" class="invalid-feedback"></div>
                                </td>

                            </tr>
                            <tr>
                                <th><b>* 상세주소</b></th>
                                <td><input type="text" class="form-control" name="addrDetail" id="addrDetail"
                                           placeholder="상세주소" value="${map.info.addr_detail}">
                                    <div id="addrDetailCheckMsg" class="invalid-feedback"></div>
                                </td>


                            </tr>
                            <tr>
                                <th><b>* 전화번호</b></th>
                                <td>
                                    <div>

                                        <div class="d-inline-flex col-12" style="padding-left: 0px;">
                                            <input type="text" class="form-control col-2" name="receiverTel1"
                                                   id="receiverTel1"
                                                   placeholder="">
                                            <p class="d-flex justify-content-center align-items-center col-1"
                                               style="margin: 0;">-</p>
                                            <input type="text" class="form-control col-2" name="receiverTel2"
                                                   id="receiverTel2"
                                                   placeholder="">
                                            <p class="d-flex justify-content-center align-items-center col-1"
                                               style="margin: 0;">-</p>
                                            <input type="text" class="form-control col-2" name="receiverTel3"
                                                   id="receiverTel3"
                                                   placeholder="">

                                        </div>
                                        <div id="receiverTel1CheckMsg" class="invalid-feedback"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><b>배송 요청사항</b></th>
                                <td><input type="text" class="form-control" name="deliveryRequest" id="deliveryRequest"
                                           placeholder=""></td>
                            </tr>

                            </tbody>
                        </table>

                    </div>
                    `

                    <!-- Payment Info -->
                    <br>
                    <div class="row align-items-end mb-2">
                        <div class="col-md-6">
                            <h2 class="h3 mb-0"><span class="text-muted">04.</span> Payment Info</h2>
                        </div>
                        <div class="col-md-6 text-md-right">
                        </div>
                    </div>

                    <table class="table table-borderless" id="paymentInfoTable">
                        <tbody>
                        <tr>
                            <th><b>상품 합계 금액</b></th>
                            <td id="paymentInfoSumItemTotal"></td>
                        </tr>
                        <tr>
                            <th><b>배송비</b></th>
                            <td>3,000원</td>
                        </tr>
                        <tr>
                            <th><b>적립금 사용</b></th>
                            <td>
                                <div class="d-inline-flex col-12" style="padding-left: 0px;">
                                    <input type="text" class="form-control col-md-6" name="point" id="pointToUse"
                                           placeholder="사용가능한 포인트 : <fmt:formatNumber value="${map.point }" type="number" pattern="#,##0"/>">
                                    <button type=button class="form-control col-sm-3 btn btn-primary ml-2" id="pointBtn"
                                            value=0>사용
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><b>예상 적립 금액</b></th>
                            <td id="estimatedPoint"></td>
                        </tr>
                        <tr>
                            <th class="text-danger"><b>최종 결제 금액</b></th>
                            <td id="paymentPrice" class="text-danger"></td>
                        </tr>
                        
                        </tbody>
                    </table>


                    <!-- Payment method -->
                    <br>
                    <div class="row align-items-end mb-2">
                        <div class="col-md-6">
                            <h2 class="h3 mb-0"><span class="text-muted">05.</span> Payment Method</h2>
                        </div>
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane fade active show" id="PaymentMethodTableComponent" role="tabpanel"
                             aria-labelledby="PaymentMethodTableComponent">
                            <table class="table table-borderless" id="paymentMethodTable">
                                <tbody>

                                <tr>
                                    <th>결제 수단 선택</th>
                                    <td>
                                        <div class="d-inline-flex col-12" style="padding-left: 0px;">

                                            <div class="d-inline-flex col-12" style="padding-left: 0px;">
                                                <div class="custom-control custom-radio col-4">
                                                    <input type="radio" name="paymentMethod" value="CARD"
                                                           class="custom-control-input"
                                                           id="paymentMethod1" checked>
                                                    <label class="custom-control-label"
                                                           for="paymentMethod1">카드결제</label>
                                                </div>
                                                <div class="custom-control custom-radio col-4">
                                                    <input type="radio" name="paymentMethod" value="TRANSFER"
                                                           class="custom-control-input"
                                                           id="paymentMethod2">
                                                    <label class="custom-control-label"
                                                           for="paymentMethod2">계좌이체</label>
                                                </div>
                                                <div class="custom-control custom-radio col-4">
                                                    <input type="radio" name="paymentMethod" value="CARD"
                                                           class="custom-control-input"
                                                           id="paymentMethod3">
                                                    <label class="custom-control-label"
                                                           for="paymentMethod3">간편결제</label>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div div class="d-inline-flex col-md-12" style="padding-left: 0px;" id="agreeContainer">
                        <div class="custom-control custom-checkbox mb-2">
                            <input type="checkbox" class="custom-control-input" id="agree" name="agree">
                            <label class="custom-control-label" for="agree"></label>
                        </div>
                        <div class=" col-md-12" style="padding-left: 0px;">
                            <h5>주문 결제에 동의합니다.</h5>
                            <div id="agreeCheckMsg" class="invalid-feedback"></div>
                        </div>
                    </div>
                </form>
                <br>
                <button id="goPay" type="button" class="form-control btn btn-primary"
                        style="background-color: #79AC78; border-bottom-color: #79AC78; border-top-color: #79AC78; border-left-color: #79AC78; border-right-color : #79AC78;"
                ></button>
                
                

            </div>


        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
