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

    <title>soaff cart</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<script type="text/javascript">

    window.onload = function () {
        //  getList();
        sumItemTotalPrice();
        updatePaymentPrice();
    }

    function sumItemTotalPrice() {
        var total = 0;

        // .cart-item 내에 .custom-control-input:checked 인 요소를 찾습니다.
        var checkedItems = $(".cart-item .custom-control-input:checked");

        // 각 체크된 항목에 대해 동작
        checkedItems.each(function () {
            // .custom-control-input을 포함하는 .cart-item 요소 찾기
            var cartItem = $(this).closest('.cart-item');
            // 해당 .cart-item 내에서 id가 "itemTotalPrice"로 시작하는 요소를 찾습니다.
            var priceElement = cartItem.find('[id^="itemTotalPrice"]');

            // 텍스트 내용 가져오기
            var text = priceElement.text(); // .text()는 jQuery 메서드로, .innerText와 같은 역할을 합니다.

            // "원" 제거 및 쉼표 제거 후 숫자로 변환
            var value = parseFloat(text.replace(/,/g, '').replace('원', ''));

            // 합산
            if (!isNaN(value)) {
                total += value;
            }
        });

        // 결과 출력 (합계가 표시될 요소의 ID가 "sumItemTotal"인 경우)
        $('#sumItemTotal').text(total.toLocaleString() + "원");
    }


    function chageAmount(e, active) {

        var cart_no = e.getAttribute('cart_no');
        var field = e.getAttribute('field');
        var amount = document.getElementById(field).value;
        if (active == '+') {
            amount++;
        }
        if (amount > 0 && active == '-') {
            amount--;
        }
        if (amount == 0) {
            alert("1개 이상부터 주문이 가능합니다")
            return location.href = "/cart";
        }

        var data = {
            cart_no: cart_no,
            amount: amount,
        };
        // console.log(data)

        // input 값 확인해서 수량 update 쿼리 날리기
        $.ajax({
            type: "GET", // method type
            url: "/cart/updateAmount", // 요청할 url
            data: data, // 전송할 데이터
            dataType: "json", // 응답 받을 데이터 type
            success: function (resp) {
                console.log("ok")
                // 데이터 리스트 출력
                if (resp > 0) {
                    document.getElementById(field).value = amount;
                    console.log(amount);
                    console.log(document.getElementById(field).value);

                    // id= itemTotalPrice+주문번호
                    var itemTotalPriceId = "itemTotalPrice" + cart_no;
                    var discountedPriceId = "discountedPrice" + cart_no;
                    var discountedPrice = document.getElementById(discountedPriceId).innerText;

                    // "원" 제거 및 쉼표 제거 후 숫자로 변환
                    var discountedPriceValue = parseFloat(discountedPrice.replace(/,/g, '').replace('원', ''));
                    var amountValue = parseFloat(amount);
                    var cal = (discountedPriceValue * amountValue).toLocaleString('ko-KR')
                    document.getElementById(itemTotalPriceId).innerText = cal + "원";

                    sumItemTotalPrice();
                    updatePaymentPrice();

                }
            },
            error: function (data, textStatus) {
                $('#fail').html("관리자에게 문의하세요.") // 서버오류
                console.log('error', data, textStatus);
            }
        })

    }


    function changePage(obj) {
        page = obj.getAttribute("data-page");
        getList();
    }

    function getList() {
        var data = {
            user_no: 1// 로그인세션에서 가져와야 함
        }

        $.ajax({
            type: "GET", // method type
            url: "/cart/getList", // 요청할 url
            data: data, // 전송할 데이터
            dataType: "json", // 응답 받을 데이터 type
            success: function (resp) {
                // 데이터 리스트 출력
                $("#cartList").html(resp.printCartList);

                // 페이지네이션 출력
                // 총 개수
                $(".datatable-info").html("Showing " + ((page - 1) * 20 + 1) + " to " + (page * 20 <= resp.total ? page * 20 : resp.total) + " of " + resp.total + " entries");
                // 페이지네이션
                let printPage = "";
                if (resp.isPrev) {
                    printPage += '<li class="datatable-pagination-list-item">';
                    printPage += '<a data-page="1" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
                    printPage += '<li class="datatable-pagination-list-item">';
                    printPage += '<a data-page="' + (resp.startPage - 1) + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
                }
                for (i = resp.startPage; i <= resp.endPage; i++) {
                    printPage += '<li class="datatable-pagination-list-item' + (i == page ? ' datatable-active' : '') + '">';
                    printPage += '<a data-page="' + i + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">' + i + '</a></li>';
                }
                if (resp.isNext) {
                    printPage += '<li class="datatable-pagination-list-item">';
                    printPage += '<a data-page="' + (resp.endPage + 1) + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
                    printPage += '<li class="datatable-pagination-list-item">';
                    printPage += '<a data-page="' + resp.totalPage + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
                }
                $(".datatable-pagination-list").html(printPage);


            },
            error: function (data, textStatus) {
                $('#fail').html("관리자에게 문의하세요.") // 서버오류
                console.log('error', data, textStatus);
            }
        })

    }

    function updatePaymentPrice() {
        // #sumItemTotal의 텍스트 값 가져오기
        var sumItemText = $('#sumItemTotal').text(); // 예: "5,000원"
        console.log("sumItemTotal: ", sumItemText);

        // #deliveryPrice의 텍스트 값 가져오기
        var deliveryText = $('#deliveryPrice').text(); // 예: "2,000원" 또는 "0원"
        console.log("deliveryPrice: ", deliveryText);

        // "원" 제거 및 쉼표 제거 후 숫자로 변환
        var sumItemValue = parseFloat(sumItemText.replace(/,/g, '').replace('원', ''));
        var deliveryValue = parseFloat(deliveryText.replace(/,/g, '').replace('원', ''));

        // 숫자가 아닌 값이 들어온 경우 0으로 설정
        sumItemValue = isNaN(sumItemValue) ? 0 : sumItemValue;

        // 체크된 항목 개수 확인
        var checkedItemsCount = $(".cart-item .custom-control-input:checked").length;


        // 체크된 항목이 없거나 전체 선택 체크박스가 체크되지 않았을 때 deliveryValue를 0으로 설정
        if (checkedItemsCount === 0) {
            deliveryValue = 0;
            $('#deliveryPrice').text("0원");
        } else {
            // 체크된 항목이 있고 전체 선택 체크박스가 체크된 상태일 때 원래 배송비로 되돌림
            deliveryValue = 3000; // 원래의 배송비 값으로 설정 (여기서 3000은 예제 값입니다)
            $('#deliveryPrice').text(deliveryValue.toLocaleString() + "원");
        }

        // 합산 (체크된 항목이 있는 경우에만 배송비 추가)
        var totalPrice = sumItemValue + deliveryValue;

        console.log("Total price with delivery (if applicable): ", totalPrice);

        // 결과를 #paymentPrice에 설정하기
        $('#paymentPrice').html(totalPrice.toLocaleString() + "원");
    }

    function updateTotalItemCount() {

        // 체크된 항목 개수 확인
        var checkedItemsCount = $(".cart-item .custom-control-input:checked").length;

        $('#countItemTotal').html("총 " + checkedItemsCount + "개의 상품금액");
    }


    function deleteCart(e) {

        alert("장바구니에서 삭제하시겠습니까?")
        var cart_no = e.getAttribute('cart_no');
        console.log(cart_no);

        var data = {
            cart_no: cart_no,
        };

        // delete 쿼리 날리기
        $.ajax({
            type: "GET", // method type
            url: "/cart/delete", // 요청할 url
            data: data, // 전송할 데이터
            dataType: "json", // 응답 받을 데이터 type
            success: function (resp) {
                console.log("ok")
                // 데이터 리스트 출력
                if (resp > 0) {

                    var deleteId = "#cart" + cart_no;
                    $(deleteId).hide();
                    location.href = "/cart";
                }
            },
            error: function (data, textStatus) {
                $('#fail').html("관리자에게 문의하세요.") // 서버오류
                console.log('error', data, textStatus);
            }
        })

    }


</script>


<script>


    function goOrder() {
        if (con) {
            $('#frm').submit();

        } else {
            alert("상품을 선택해주세요")
        }
    }

    function checkedCartNo() {

        let cartNoArray = [];

        $(".cart-item .custom-control-input:checked").each(function () {
            let cartNo = $(this).attr("cart_no");

            // cart_no 속성 값이 존재하면 배열에 추가
            if (cartNo !== undefined) {
                cartNoArray.push(cartNo);
            }
        });

        // cart_no 값들이 담긴 배열을 반환
        return cartNoArray;

    }


    function updateConState() {
        con = $(".cart-item .custom-control-input:checked").length > 0;
    }

    let con = false;
    $(document).ready(function () {
        $("#checkAll").on('change', function () {
            $(".cart-item .custom-control-input").prop('checked', $(this).prop('checked'));
            updateConState();
            sumItemTotalPrice();
            updatePaymentPrice();
            updateTotalItemCount();
        });

        $(".cart-item .custom-control-input").on('change', function () {
            if ($(".cart-item .custom-control-input:checked").length === $(".cart-item .custom-control-input").length) {
                $("#checkAll").prop('checked', true);
            } else {
                $("#checkAll").prop('checked', false);
            }
            updateConState();
            sumItemTotalPrice();
            updatePaymentPrice();
            updateTotalItemCount();

        });

        $("#orderBtn").on('click', function () {
            updateConState();
            goOrder();
        });

    });

</script>

<body>

<!-- hero -->
<section class="hero">
    <div class="container">
        <div class="row">
            <div class="col text-center">
                <h1>My Cart</h1>
            </div>
        </div>
    </div>
</section>


<section class="pt-0">
    <div class="container">
        <div class="row mb-1 d-none d-lg-flex">
            <div class="col-lg-8">
                <!--전체선택-->
                <div class="custom-control custom-checkbox col-lg-8">
                    <input type="checkbox" class="custom-control-input" id="checkAll"
                           checked="">
                    <label class="custom-control-label" for="checkAll"></label>
                </div>
                <br>
                <!-- 제목 -->
                <div class="row pr-8">

                    <div class="col-lg-6 text-left"><span class="eyebrow">Product</span></div>

                    <div class="col-lg-2 text-center"><span class="eyebrow">Price</span></div>
                    <div class="col-lg-2 text-center"><span class="eyebrow">Quantity</span></div>
                    <div class="col-lg-2 text-center"><span class="eyebrow">Total</span></div>

                </div>

            </div>
        </div>


        <div class="row gutter-2 gutter-lg-4 justify-content-end">


            <!-- item list 담는 박스 -->
            <div class="col-lg-8 cart-item-list" id="cartList">

                <c:if test="${empty map.list}">
                    <div class="cart-item">
                        <div class="row align-items-center col-12" style="text-align : center;">
                            <span>Empty</span>
                        </div>
                    </div>
                </c:if>
                <form action="/order" method="post" id="frm">
                    <c:forEach var="vo" items="${map.list }">

                        <!-- cart item -->
                        <div class="cart-item" id="cart${vo.cart_no}">
                            <div class="row align-items-center">
                                <div class="col-12 col-lg-6">
                                    <div class="media media-product">

                                        <!-- id, for 가 일치해야 토글이 됩니다 -->
                                        <div class="custom-control custom-checkbox mb-2">
                                            <input type="checkbox" class="custom-control-input"
                                                   id="checkbox${vo.cart_no}" name="checkedCartNo" value="${vo.cart_no}" cart_no="${vo.cart_no}"
                                                   checked>
                                            <label class="custom-control-label" for="checkbox${vo.cart_no}"></label>
                                        </div>

                                        <a href="/item/detail?${vo.item_no}"><img src="${vo.item_img}" alt="Image"></a>
                                        <div class="media-body">
                                            <h5 class="media-title">${vo.name}</h5>
                                            <c:if test="${vo.packing_status eq 1}">
                                                <span class="small">포장O (+2,000원)</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-4 col-lg-2 text-center">

            
                                            
                                     <!-- `discountedPrice`가 비어 있으면 -->
									<c:if test="${empty vo.discounted_price}">
									    <p class="cart-item-price" id="itemPrice${vo.cart_no}">
									    <fmt:formatNumber value="${vo.price}" type="number" pattern="#,##0"/>원</p>
									</c:if>
									
									<!-- `discountedPrice`가 비어 있지 않으면 -->
									<c:if test="${!empty vo.discounted_price}">
									    <del><fmt:formatNumber value="${vo.price}" type="number" pattern="#,##0"/>원</del>
									    <p class="cart-item-price" id="itemPrice${vo.cart_no}">
									        <fmt:formatNumber value="${vo.discounted_price}" type="number" pattern="#,##0"/>원
									    </p>
									</c:if>       
                                            
                                            
                                            
                                            
                                </div>
                                <div class="col-4 col-lg-2 text-center">
                                    <div class="counter">
                                        <span class="counter-minus icon-minus" id='plusAmount${vo.cart_no}'
                                              field='amount${vo.cart_no}' onclick="chageAmount(this, '-');"
                                              cart_no="${vo.cart_no}"></span>
                                        <input type='text' id='amount${vo.cart_no}'
                                               class="counter-value" value="${vo.amount}"
                                               min="0" max="${vo.inventory}" cart_no="${vo.cart_no}" readonly>
                                        <span class="counter-plus icon-plus" id='minusAmount${vo.cart_no}'
                                              field='amount${vo.cart_no}' onclick="chageAmount(this, '+');"
                                              cart_no="${vo.cart_no}"></span>
                                    </div>
                                </div>
                                <div class="col-4 col-lg-2 text-center">
                                
                                <!-- `discountedPrice`가 비어 있으면 -->
									<c:if test="${empty vo.discounted_price}">						    
									    <span class="cart-item-price" id="itemTotalPrice${vo.cart_no}"
	                                      cart_no="${vo.cart_no}"><fmt:formatNumber
	                                        value="${vo.amount*vo.price}" type="number"
	                                        pattern="#,##0"/>원</span>
									</c:if>
									
									<!-- `discountedPrice`가 비어 있지 않으면 -->
									<c:if test="${!empty vo.discounted_price}">
									    <span class="cart-item-price" id="itemTotalPrice${vo.cart_no}"
	                                      cart_no="${vo.cart_no}"><fmt:formatNumber
	                                        value="${vo.amount*vo.discounted_price}" type="number"
	                                        pattern="#,##0"/>원</span>
									</c:if>


                                </div>
                                <a class="cart-item-close"><i class="icon-x" onclick="deleteCart(this);"
                                                              id="delete${vo.cart_no}" cart_no="${vo.cart_no}"></i></a>
                            </div>
                        </div>
                    </c:forEach>
                </form>
            </div>


            <div class="col-lg-4" id="orderSummary">

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
                                <span id="countItemTotal" style="margin-left: 0px; color: #555555;">총 ${map.count}개의 상품 금액</span>
                                <span class="list-group-item" id="sumItemTotal" style="color: #555555;"></span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span style="margin-left: 0px; color: #555555;">배송비</span>
                                <span id="deliveryPrice" style="color: #555555;"><fmt:formatNumber
                                        value="3000" type="number"
                                        pattern="#,##0"/>원</span>
                            </li>

                        </ul>
                    </div>
                    <div class="card-footer py-2">
                        <ul class="list-group list-group-minimal">
                            <li class="list-group-item d-flex justify-content-between align-items-center text-dark fs-18">
                                합계
                                <span id="paymentPrice"></span>
                            </li>
                        </ul>
                    </div>
                </div>

                <button class="btn btn-lg btn-primary btn-block mt-1"
                        style="background-color:#79AC78;border-color: #79AC78;" id="orderBtn">Order NOW
                </button>


            </div>

        </div>

    </div>
</section>
<br>


<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
