<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<script>


    let isValid;

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

            console.log(1);

            //fieldCheck()
            if (true) {
                //location.href = "/order/success";
                console.log(0);
                request_pay();

            }
            //
            // if (!agree) {
            //     alert("주문 동의가 필요합니다");
            //     $("#agree").focus();
            //
            // }

        });

    };

</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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
</script>

<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<script>

    function generateUuid() {
        // 4자리 랜덤 숫자 생성
        const randomNumber = Math.floor(1000 + Math.random() * 9000); // 1000부터 9999까지의 숫자 생성

        // 현재 타임스탬프 생성
        const timestamp = Date.now(); // 밀리초 단위의 현재 타임스탬프

        // 랜덤 숫자와 타임스탬프 결합
        return randomNumber+"-"+timestamp;
    }

    async function request_pay() {
        const orderUuid = generateUuid();
        console.log(orderUuid);
        const response = await PortOne.requestPayment({
            // Store ID 설정
            storeId: "store-cfa799d7-b5cc-4fb8-b538-98363bffffbd",
            // 채널 키 설정
            channelKey: "channel-key-8f312486-23c0-4ee3-95b4-5a26210375f3",
            paymentId: 'payment-'+orderUuid,
            orderName: "나이키 와플 트레이너 2 SD",
            totalAmount: 100,
            currency: "CURRENCY_KRW",
            payMethod: $('input[name=paymentMethod]:checked').val(),
        });

        console.log(response);

        if (response.code != null) {
            // 오류 발생
            return alert(response.message);
        }

        // 고객사 서버에서 /payment/complete 엔드포인트를 구현해야 합니다.
        // (다음 목차에서 설명합니다)
        const notified = await fetch(`${SERVER_BASE_URL}/payment/complete`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            // paymentId와 주문 정보를 서버에 전달합니다
            body: JSON.stringify({
                paymentId: paymentId,
                // 주문 정보...
            }),
        });

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
                                        총 n개의 상품 금액
                                        <span>11,850원</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        배송비
                                        <span>3000원</span>
                                    </li>

                                </ul>
                            </div>
                            <div class="card-footer py-2">
                                <ul class="list-group list-group-minimal">
                                    <li class="list-group-item d-flex justify-content-between align-items-center text-dark fs-18">
                                        Total
                                        <span>14,850원</span>
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
                    <div class="cart-item">
                        <div class="row align-items-center">
                            <div class="col-12 col-lg-6">
                                <div class="media media-product">
                                    <a href="#!"><img src="/user/images/demo/product-4.jpg" alt="Image"></a>
                                    <div class="media-body">
                                        <h5 class="media-title">Product Name1</h5>
                                        <span class="small">포장O (+3,000원)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 col-lg-2 text-center">
                                <p class="cart-item-price">
                                    <del>9,500원</del>
                                </p>
                                8,500원
                            </div>
                            <div class="col-4 col-lg-2 text-center">
                                <div class="counter">
                                    <span class="counter-value">1</span>
                                </div>
                            </div>
                            <div class="col-4 col-lg-2 text-center">
                                <span class="cart-item-price">11,850원</span>
                            </div>
                        </div>
                    </div>
                    <!-- 합계-->
                    <br>
                    <div class="row gutter-1 mb-12">
                        <div class="col-4">
                            <div class="inline-block">
                                <h6 style="text-align: right">총 n개의 상품 금액</h6>
                                <h4 style="text-align: right" class="h2">11,850원</h4>
                            </div>
                        </div>
                        <div class=" col-4">
                            <div class="inline-block">
                                <h6 style="text-align: right">배송비</h6>
                                <h4 style="text-align: right" class="h2">+ 3000원</h4>
                            </div>
                        </div>
                        <div class=" col-4">
                            <div class="inline-block">
                                <h6 style="text-align: right">합계</h6>
                                <h4 style="text-align: right" class="h2">= 14,850원</h4>
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
                            <td>V6</td>
                        </tr>
                        <tr>
                            <th><b>전화번호</b></th>
                            <td>010-1111-1111</td>
                        </tr>
                        <tr>
                            <th><b>email</b></th>
                            <td>v6@gmail.com</td>
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
                            <a class="eyebrow underline">* 필수 입력값</a>
                        </div>
                        <table class="table table-borderless" id="deliveryInfo">
                            <tbody>
                            <tr>
                                <th><b>* 받으실 분</b></th>
                                <td><input type="text" class="form-control col-5 " name="receiverName" id="receiverName"
                                           placeholder="">
                                    <div id="receiverNameCheckMsg" class="invalid-feedback"></div>
                                </td>

                            </tr>
                            <tr>
                                <th><b>* 우편번호</b></th>
                                <td>
                                    <div class="d-inline-flex col-12" style="padding-left: 0px;">
                                        <input type="text" class="form-control col-5" name="zipcode" id="zipcode"
                                               placeholder="" readonly>
                                        <input type="button" class="btn btn-primary form-control col-4 ml-2"
                                               value="우편번호 검색"
                                               style="background-color: #FFFFFF; color: #618264;" id="searchZipcode"
                                        >


                                    </div>
                                    <div id="zipcodeCheckMsg" class="invalid-feedback"></div>
                                </td>
                            </tr>
                            <tr>
                                <th><b>* 주소</b></th>
                                <td><input type="text" class="form-control" name="addr" id="addr" placeholder=""
                                           readonly>
                                    <div id="addrCheckMsg" class="invalid-feedback"></div>
                                </td>

                            </tr>
                            <tr>
                                <th><b>* 상세주소</b></th>
                                <td><input type="text" class="form-control" name="addrDetail" id="addrDetail"
                                           placeholder="상세주소">
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
                                <th><b>* 배송 요청사항</b></th>
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
                            <td>11,850원</td>
                        </tr>
                        <tr>
                            <th><b>배송비</b></th>
                            <td>3000원</td>
                        </tr>
                        <tr>
                            <th><b>적립금 사용</b></th>
                            <td>
                                <div class="d-inline-flex col-12" style="padding-left: 0px;">
                                    <input type="text" class="form-control col-md-6" name="point"
                                           placeholder="사용가능한 적립금: 5000원">
                                    <input type=button class="form-control col-sm-3 btn btn-primary ml-2" value="사용">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><b>최종 결제 금액</b></th>
                            <td>14,580원</td>
                        </tr>
                        <tr>
                            <th><b>예상 적립 금액</b></th>
                            <td>355원</td>
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
                >14,850원 결제하기
                </button>
            </div>


        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
