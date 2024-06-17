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
    <title>soaff</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<script>

    function goPay() {
        if (fieldCheck()) {
            location.href = "/order/success";
        }

    }


    function fieldCheck() {
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


        let isValid = true;

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
        if (!receiverTel1.val()) {
            receiverTel1CheckMsg.html("전화번호를 입력해주세요");
            receiverTel1CheckMsg.css("display", "block");
            receiverTel1.focus();
            isValid = false;
        }
        if (!receiverTel2.val()) {
            receiverTel2CheckMsg.html("전화번호를 입력해주세요");
            receiverTel2CheckMsg.css("display", "block");
            receiverTel2.focus();
            isValid = false;
        }
        if (!receiverTel3.val()) {
            receiverTel3CheckMsg.html("전화번호를 입력해주세요");
            receiverTel3CheckMsg.css("display", "block");
            receiverTel3.focus();
            isValid = false;
        }
        if (!paymentMethod.val()) {
            paymentMethodCheckMsg.html("결제수단을 확인해주세요");
            paymentMethodCheckMsg.css("display", "block");
            paymentMethod.focus();
            isValid = false;
        }
        if (!agree) {
            agreeCheckMsg.html("주문 동의가 필요합니다");
            agreeCheckMsg.css("display", "block");
            alert("주문 동의가 필요합니다");
            agree.focus();
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
            <!--제목 -->
            <div class="col-lg-12">
                <div class="row align-items-end mb-2">
                    <div class="col-md-6">
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
                        <div class="form-group col-md-3">
                            <div class="inline-block">

                            </div>
                        </div>
                        <div class="form-group col-md-3">
                            <div class="inline-block">
                                <h6 style="text-align: right">총 n개의 상품 금액</h6>
                                <h4 style="text-align: right" class="h2">11,850원</h4>
                            </div>
                        </div>
                        <div class="form-group col-md-3">
                            <div class="inline-block">
                                <h6 style="text-align: right">배송비</h6>
                                <h4 style="text-align: right" class="h2">+ 3000원</h4>
                            </div>
                        </div>
                        <div class="form-group col-md-3">
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
                </div>
                <div class="row gutter-1 mb-12">
                    <div class="form-group col-md-12">
                        <label for="buyerName">주문자 이름</label>
                        <input type="text" class="form-control" name="buyerName" id="buyerName" placeholder=""
                               value="V6"
                               readonly>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="buyerTel">전화번호</label>
                        <input type="text" class="form-control" name="buyerTel" id="buyerTel" placeholder=""
                               value="010-1111-1111"
                               readonly>
                    </div>
                    <!--
                    <div class="form-group col-md-4">
                        <label for="orderPhone2"></label>
                        <input type="text" class="form-control" name="orderPhone2" id="orderPhone2" placeholder=""readonly>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="orderPhone3"></label>
                        <input type="text" class="form-control" name="orderPhone3" id="orderPhone3" placeholder="" readonly>
                    </div>
                    -->
                    <div class="form-group col-md-12">
                        <label for="buyerEmail">e-mail</label>
                        <input type="text" class="form-control" name="buyerEmail" id="buyerEmail" placeholder=""
                               value="v6@gmail.com"
                               readonly>
                    </div>
                    <!--
                    <div class="form-group col-md-4">
                        <label for="emailDomain"></label>
                        <input type="text" class="form-control" name="emailDomain" id="emailDomain" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label></label>
                        <select id="emailSel" class="custom-select" required>
                            <option value="">선택</option>
                            <option value="직접입력">직접입력</option>
                            <option value="naver.com">naver.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="hanmail.net">hanmail.net</option>
                            <option value="hotmail.com">hotmail.com</option>
                            <option value="korea.com">korea.com</option>
                            <option value="nate.com">nate.com</option>
                            <option value="yahoo.com">yahoo.com</option>
                        </select>
                    </div>
                    -->
                </div>

                <form>
                    <!-- delivery -->
                    <br>
                    <div class="row align-items-end mb-2">
                        <div class="col-md-6">
                            <h2 class="h3 mb-0"><span class="text-muted">03.</span> Delivery Info</h2>
                        </div>
                        <div class="col-md-6 text-md-right">
                            <a class="eyebrow underline">* 필수 입력값</a>
                        </div>
                    </div>
                    <div class="row gutter-1 mb-2">
                        <div class="form-group col-md-12">
                            <label for="receiverName">* 받으실 분</label>
                            <input type="text" class="form-control" name="receiverName" id="receiverName"
                                   placeholder="">
                            <div id="receiverNameCheckMsg" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-9">
                            <label for="zipcode">* 우편번호</label>
                            <input type="text" class="form-control" name="zipcode" id="zipcode" placeholder=""
                                   readonly>
                            <div id="zipcodeCheckMsg" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-3">
                            <label></label>
                            <button class="btn btn-primary"
                                    style="background-color: #FFFFFF; color: #618264;"
                                    id="searchZipcode" onclick="zipcode();">
                                우편번호 검색
                            </button>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="addr">* 주소</label>
                            <input type="text" class="form-control" name="addr" id="addr" placeholder=""
                                   readonly>
                            <div id="addrCheckMsg" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="addrDetail">* 상세주소</label>
                            <input type="text" class="form-control" name="addrDetail" id="addrDetail"
                                   placeholder="상세주소">
                            <div id="addrDetailCheckMsg" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="receiverTel1">* 전화번호</label>
                            <input type="text" class="form-control" name="receiverTel1" id="receiverTel1"
                                   placeholder="">
                            <div id="receiverTel1CheckMsg" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="receiverTel2"></label>
                            <input type="text" class="form-control" name="receiverTel2" id="receiverTel2"
                                   placeholder="">
                            <div id="receiverTel2CheckMsg" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="receiverTel3"></label>
                            <input type="text" class="form-control" name="receiverTel3" id="receiverTel3"
                                   placeholder="">
                            <div id="receiverTel3CheckMsg" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-12">
                            <label for="deliveryRequest">배송 요청사항</label>
                            <input type="text" class="form-control" name="deliveryRequest" id="deliveryRequest"
                                   placeholder="">
                        </div>
                    </div>

                    <!-- Payment Info -->
                    <br>
                    <div class="row align-items-end mb-2">
                        <div class="col-md-6">
                            <h2 class="h3 mb-0"><span class="text-muted">04.</span> Payment Info</h2>
                        </div>
                        <div class="col-md-6 text-md-right">
                        </div>
                    </div>
                    <div class="tab-content" id="paymentInfoTable">
                        <div class="tab-pane fade active show" id="paymentInfoTableComponent" role="tabpanel"
                             aria-labelledby="paymentInfoTableComponent">
                            <table class="table table-bordered">
                                <tbody>
                                <tr>
                                    <th scope="row"><b>상품 합계 금액</b></th>
                                    <td>11,850원</td>
                                </tr>
                                <tr>
                                    <th scope="row"><b>배송비</b></th>
                                    <td>3000원</td>
                                </tr>
                                <tr>
                                    <th scope="row"><b>적립금 사용</b></th>
                                    <td>
                                        <div class="d-inline-flex col-md-12" style="padding-left: 0px;">
                                            <input type="text" class="form-control col-md-6" name="point"
                                                   placeholder="사용가능한 적립금: 5000원">
                                            <button class="form-control col-sm-3 btn btn-primary ml-4">사용하기</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><b>최종 결제 금액</b></th>
                                    <td>14,580원</td>
                                </tr>
                                <tr>
                                    <th scope="row"><b>예상 적립 금액</b></th>
                                    <td>355원</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Payment method -->
                    <br>
                    <div class="row align-items-end mb-2">
                        <div class="col-md-6">
                            <h2 class="h3 mb-0"><span class="text-muted">05.</span> Payment Method</h2>
                        </div>
                    </div>
                    <div class="tab-content" id="PaymentMethodTable">
                        <div class="tab-pane fade active show" id="PaymentMethodTableComponent" role="tabpanel"
                             aria-labelledby="PaymentMethodTableComponent">
                            <table class="table table-bordered">
                                <tbody>

                                <tr>
                                    <th>결제 수단 선택</th>
                                    <td>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="paymentMethod" class="custom-control-input"
                                                   id="paymentMethod" checked>
                                            <label class="custom-control-label" for="paymentMethod">간편결제</label>
                                        </div>
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div div class="d-inline-flex col-md-12" style="padding-left: 0px;">
                        <div class="custom-control custom-checkbox mb-2">
                            <input type="checkbox" class="custom-control-input" id="agree" name="agree">
                            <label class="custom-control-label" for="agree"></label>
                        </div>
                        <div class="form-group col-md-12" style="padding-left: 0px;">
                            <h5>주문 결제에 동의합니다.</h5>
                            <div id="agreeCheckMsg" class="invalid-feedback"></div>
                            <br>
                        </div>
                    </div>
                </form>
                <br>
                <button class="form-control btn btn-primary"
                        style="background-color: #79AC78; border-bottom-color: #79AC78; border-top-color: #79AC78; border-left-color: #79AC78; border-right-color : #79AC78;"
                        onclick="goPay();">
                    14,850원 결제하기
                </button>

            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
