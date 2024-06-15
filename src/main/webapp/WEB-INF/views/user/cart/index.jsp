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

    <title>soaff</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
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
                <!-- 제목 -->
                <div class="row pr-6">
                    <div class="col-lg-6"><span class="eyebrow">Product</span></div>
                    <div class="col-lg-2 text-center"><span class="eyebrow">Price</span></div>
                    <div class="col-lg-2 text-center"><span class="eyebrow">Quantity</span></div>
                    <div class="col-lg-2 text-center"><span class="eyebrow">Total</span></div>
                </div>

            </div>
        </div>
        <div class="row gutter-2 gutter-lg-4 justify-content-end">

            <!-- item list 담는 박스 -->
            <div class="col-lg-8 cart-item-list">

                <form>
                    <!-- cart item -->
                    <div class="cart-item">
                        <div class="row align-items-center">
                            <div class="col-12 col-lg-6">
                                <div class="media media-product">
                                    <!-- id, for 가 일치해야 토글이 됩니다 -->
                                    <div class="custom-control custom-checkbox mb-2">
                                        <input type="checkbox" class="custom-control-input" id="customCheck1"
                                               checked="">
                                        <label class="custom-control-label" for="customCheck1"></label>
                                    </div>

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
                                    <span class="counter-minus icon-minus" field='qty-1'></span>
                                    <input type='text' name='qty-1' class="counter-value" value="2" min="1" max="10">
                                    <span class="counter-plus icon-plus" field='qty-1'></span>
                                </div>
                            </div>
                            <div class="col-4 col-lg-2 text-center">
                                <span class="cart-item-price">11,850원</span>
                            </div>
                            <a href="#!" class="cart-item-close"><i class="icon-x"></i></a>
                        </div>
                    </div>

                </form>


            </div>

            <div class="col-lg-4">
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
                            <!--
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                              <a href="" class="text-primary action underline">Add coupon code</a>
                            </li>
                            -->
                        </ul>
                    </div>
                    <div class="card-footer py-2">
                        <ul class="list-group list-group-minimal">
                            <li class="list-group-item d-flex justify-content-between align-items-center text-dark fs-18">
                                합계
                                <span>14,850원</span>
                            </li>
                        </ul>
                    </div>
                </div>
                <a href="/order" class="btn btn-lg btn-primary btn-block mt-1"
                   style="background-color:#79AC78;border-color: #79AC78;">주문하기</a>
            </div>

        </div>
    </div>
</section>
<br>


<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
