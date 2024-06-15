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
<!-- breadcrumbs -->
<section class="breadcrumbs separator-bottom">
    <div class="container">
        <div class="row">
            <div class="col">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/index">Home</a></li>
                        <li class="breadcrumb-item"><a href="/shop">Shop</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Invoice</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>

<!-- hero -->
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
                    <div class="col-md-6 text-md-right">
                        <a class="eyebrow underline">* 필수 입력값</a>
                    </div>
                </div>
                <div class="row gutter-1 mb-12">
                    <div class="form-group col-md-12">
                        <label for="firstName">* 주문자 이름</label>
                        <input type="text" class="form-control" name="senderName" id="firstName" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="firstName">* 전화번호</label>
                        <input type="text" class="form-control" name="phone1" id="firstName" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="lastName"></label>
                        <input type="text" class="form-control" name="phone2" id="lastName" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="lastName"></label>
                        <input type="text" class="form-control" name="phone3" id="companyName" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="lastName">* e-mail</label>
                        <input type="text" class="form-control" name="emailID" id="companyName" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="lastName"></label>
                        <input type="text" class="form-control" name="emailID" id="companyName" placeholder="">
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
                </div>

                <!-- delivery -->
                <br>
                <div class="row align-items-end mb-2">
                    <div class="col-md-6">
                        <h2 class="h3 mb-0"><span class="text-muted">03.</span> Delivery</h2>
                    </div>
                    <div class="col-md-6 text-md-right">
                        <a class="eyebrow underline">* 필수 입력값</a>
                    </div>
                </div>
                <div class="row gutter-1 mb-2">
                    <div class="form-group col-md-12">
                        <label for="firstName">* 받으실 분</label>
                        <input type="text" class="form-control" name="recipientName" id="firstName" placeholder="">
                    </div>
                    <div class="form-group col-md-9">
                        <label for="firstName">* 받으실 곳</label>
                        <input type="text" class="form-control" name="zipcode" id="firstName" placeholder="">
                    </div>
                    <div class="form-group col-md-3">
                        <label></label>
                        <button class="form-control btn btn-primary" style="background-color: #FFFFFF; color: #618264;">
                            우편번호 검색
                        </button>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="firstName">* 주소</label>
                        <input type="text" class="form-control" name="addr" id="firstName" placeholder="">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="firstName">* 상세주소</label>
                        <input type="text" class="form-control" name="addr_detail" id="firstName" placeholder="상세주소">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="firstName">* 전화번호</label>
                        <input type="text" class="form-control" name="phone1" id="firstName" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="lastName"></label>
                        <input type="text" class="form-control" name="phone2" id="lastName" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="lastName"></label>
                        <input type="text" class="form-control" name="phone3" id="companyName" placeholder="">
                    </div>
                </div>

                <!-- Payment Info -->
                <br>
                <div class="row align-items-end mb-2">
                    <div class="col-md-6">
                        <h2 class="h3 mb-0"><span class="text-muted">04.</span> Payment Info</h2>
                    </div>
                    <div class="col-md-6 text-md-right">
                        <a class="eyebrow underline">* 필수 입력값</a>
                    </div>
                </div>
                <div class="tab-content" id="component-1-content">
                    <div class="tab-pane fade active show" id="component-1-1" role="tabpanel"
                         aria-labelledby="component-1-1">
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
                                               placeholder="사용할 적립금을 입력해주세요">
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
                <div class="tab-content" id="component-1-content">
                    <div class="tab-pane fade active show" id="component-1-1" role="tabpanel"
                         aria-labelledby="component-1-1">
                        <table class="table table-bordered">
                            <tbody>

                            <tr>
                                <th>결제 수단 선택</th>
                                <td>
                                    <div class="custom-control custom-radio">
                                        <input type="radio" name="custom-radio-1" class="custom-control-input"
                                               id="customRadio1">
                                        <label class="custom-control-label" for="customRadio1">간편결제</label>
                                    </div>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>

                <div div class="d-inline-flex col-md-12" style="padding-left: 0px;">
                    <div class="custom-control custom-checkbox mb-2">
                        <input type="checkbox" class="custom-control-input" id="customCheck1"
                               checked="">
                        <label class="custom-control-label" for="customCheck1"></label>
                    </div>
                    <div class="form-group col-md-10" style="padding-left: 0px;">
                        <h5>주문 결제에 동의합니다.</h5>
                    </div>

                </div>
                <button class="form-control btn btn-primary"
                        style="background-color: #79AC78; border-bottom-color: #79AC78; border-top-color: #79AC78; border-left-color: #79AC78; border-right-color : #79AC78;  ">
                    14,850원 결제하기
                </button>
                <a href="/order/success">결제하기</a>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
