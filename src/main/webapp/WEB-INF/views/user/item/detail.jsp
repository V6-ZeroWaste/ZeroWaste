<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css" />
    <link rel="stylesheet" href="/user/css/style.css" />
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <style>
        /* input type = "number" 화살표 제거 */
        /* 크롬, 사파리, 엣지 */
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .no-padding {
            padding: 0;
        }

        .active-border {
            border-bottom: 3px solid #000; /* 원하는 색상과 두께로 설정 */
        }

        .review-title,
        .reply-status,
        .reply-type,
        .reply-title,
        .user-id,
        .date {
            font-size: 14px; /* 텍스트 크기 조정 */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .reply-status-line,
        .reply-type-line,
        .reply-title-line,
        .user-id-line,
        .date-line{
            font-size: 14px; /* 텍스트 크기 조정 */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding: 15px;
        }

        .rating,
        .photo-status {
            font-size: 12px; /* 별점과 사진 상태 텍스트 크기 조정 */
            display: inline-block; /* 한 줄에 나란히 배치 */
            vertical-align: middle; /* 텍스트 가운데 정렬 */
        }

        .photo-status {
            margin-left: 5px; /* 별점과 사진 상태 사이의 간격 조정 */
        }

        .content-box{
            /*padding: 50px;*/
            margin: 50px;
        }
        .user-id{
            padding: 0 30px;
        }
        .date{
            padding: 0 25px;
        }
    </style>

    <title>soaff</title>
    <script>
        // 스크롤 이동
        function scrollToSection(sectionId) {
            // 모든 버튼의 active-border 클래스 제거
            document.getElementById('detailBtn').classList.remove('active-border');
            document.getElementById('reviewBtn').classList.remove('active-border');
            document.getElementById('qnaBtn').classList.remove('active-border');
            // 클릭된 버튼에 active-border 클래스 추가

            document.getElementById(sectionId + 'Btn').classList.add('active-border');
            document.getElementById(sectionId + 'Section').scrollIntoView({behavior: 'smooth'});


            setTimeout(function () {
                document.getElementById('qnaBtn').classList.remove('active-border');
                document.getElementById(sectionId + 'Btn').classList.add('active-border');
                document.getElementById(sectionId + 'Section').scrollIntoView({behavior: 'smooth'});
            }, 1500);
        }

        // 기본적으로 첫 번째 버튼에 active-border 클래스 추가
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('detailBtn').classList.add('active-border');
        });
        /*
        먼저, 각 섹션을 관찰하기 위한 IntersectionObserver를 설정합니다.
        각 섹션이 뷰포트에 들어오면 해당 버튼에 active-border 클래스를 추가하고, 다른 버튼에서 제거합니다.
        추가하기 !!
        * */

        function addItem() {

            var itemName = $("#select-product").val();
            var itemPrice = $("#item-price").text();
            var selectedItems = [];


            if(itemName.startsWith('포장')){
                itemPrice=${item.packing_price};
                itemPrice = itemPrice.toLocaleString();
                itemPrice += '원';
            }

            console.log(itemPrice.toString().toLocaleString());

            $(".selected-item-name").each(function () {
                selectedItems.push($(this).text());
            });

            var status = true;

            selectedItems.forEach((selectedItem)=>{if(selectedItem===itemName){
                alert("이미 선택된 옵션입니다.");
                status = false;
            }})

            if(!status){
                $("#select-product").val("");
                return;
            }

            var html = "";
            html+="<div class='row align-items-center mt-3' style='border-top: #dddddd 1px solid; '>";
            html+="<div class='col-md-7'>";
            html+="<h5 class='mt-3 selected-item-name'>"+itemName+"</h5>";
            html+="<span class='selected-item-price' data-unit-price='"+itemPrice+"'>"+itemPrice.toString().toLocaleString()+"</span>";
            html+="</div>";
            html+="<div class='col-5 d-flex no-padding'>";
            html+="<button class='btn btn-outline-secondary btn-sm btn-full-width mt-3' type='button'";
            html+="id='button-minus-0' onClick='decreaseValue(this)'>-";
            html+="</button>";
            html+="<input type='number' class='form-control form-control-sm input-full-width mt-3' min='1'";
            html+="max='9' value='1'/>";
            html+="<button class='btn btn-outline-secondary btn-sm btn-full-width mt-3' type='button'";
            html+="id='button-plus-0' onClick='increaseValue(this)'>+";
            html+="</button>";
            html+="<button class='btn btn-sm btn-full-width mt-3' type='button' id='button-delete-item-0'";
            html+="onClick='removeItem(this)'>x"
            html+="</button>"
            html+="</div>"
            html+="</div>"

            $("#total-price").closest('.row').before(html);
            $("#select-product").val("");

            calcTotalPrice();
        }

        function increaseValue(button){
            var input = $(button).siblings('input[type="number"]');
            var currentValue = parseInt(input.val());
            if (currentValue < 9) {
                input.val(currentValue + 1);
            }
            calcItemPrice(button);
            calcTotalPrice();
        }

        function decreaseValue(button) {
            var input = $(button).siblings('input[type="number"]');
            var currentValue = parseInt(input.val());
            if (currentValue > 1) {
                input.val(currentValue - 1);
            }
            calcItemPrice(button);
            calcTotalPrice();
        }

        function removeItem(button) {
            $(button).closest('.row').remove();
            calcTotalPrice();
        }

        function calcTotalPrice() {
            var totalPrice = 0;
            $(".selected-item-price").each(function () {
                var priceText = $(this).data('unit-price');
                if (typeof priceText !== 'string') {
                    priceText = String(priceText); // 문자열로 변환
                }
                priceText = priceText.replace(/\D/g, '');
                var price = parseInt(priceText);
                if (!isNaN(price)) {
                    var quantityText = $(this).closest(".row").find("input[type=number]").val();
                    var quantity = parseInt(quantityText);
                    totalPrice += price * quantity;
                }
            });
            $('#total-price').html(totalPrice.toLocaleString()+'원');
        }

        function calcItemPrice(button) {
            var row = $(button).closest('.row');
            var priceText = row.find('.selected-item-price').data('unit-price');
            if (typeof priceText !== 'string') {
                priceText = String(priceText); // 문자열로 변환
            }
            priceText = priceText.replace(/\D/g, '');
            var price = parseInt(priceText);
            var quantity = parseInt(row.find('input[type=number]').val());

            if (!isNaN(price) && !isNaN(quantity)) {
                var totalPrice = price * quantity;
                row.find('.selected-item-price').text(totalPrice.toLocaleString()+'원');
            }
        }
    </script>

    <!-- 리뷰 -->
    <script>

    </script>

    <!-- 문의 -->
    <script>

    </script>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<body>

<br>
<br>
<br>
<!-- 상품 영역 -->
<section class="hero bg-light pt-5">
    <div class="container">
        <div class="row gutter-2 gutter-md-4 justify-content-between">

            <div class="col-lg-7">
                <div class="row gutter-1 justify-content-between">
                    <div class="col-lg-10 order-lg-2">
                        <div class="owl-carousel gallery" data-slider-id="1" data-thumbs="true" data-nav="true">
                            <figure class="equal">
                                <a class="image" href="assets/images/demo/product-8.jpg"
                                   style="background-image: url(assets/images/demo/product-8.jpg);">
                                </a>
                            </figure>
                                <figure class="equal">
                                    <a class="image" href="assets/images/demo/product-8-2.jpg"
                                       style="background-image: url(assets/images/demo/product-8-2.jpg);">
                                    </a>
                                </figure>
                                <figure class="equal">
                                    <a class="image" href="assets/images/demo/product-8-3.jpg"
                                       style="background-image: url(assets/images/demo/product-8-3.jpg);">
                                    </a>
                                </figure>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5 mb-5 mb-lg-0" id="selected-item-list">
                    <div class="row">
                        <div class="col-12">
                            <h1 class="item-title">${item.name}</h1>
                            <h3 class="item-title text-muted">${item.description}</h3>
                            <c:if test="${item.discount_rate!=0}">
                                <span class="item-price"><s class="text-muted"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.price}" /></s><span class="text-red">${item.discount_rate}%</span></span>
                            </c:if>
                            <div class="item-price" id="item-price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.discounted_price}" />원</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <select name="select-product" id="select-product" class="form-control" onchange="addItem();">
                                <option value="" disabled selected>상품 선택</option>
                                <option value="${item.name}"> ${item.name} </option>
                                <c:if test="${item.packable_option}">
                                    <option value="포장(<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.packing_price}" />원)"> 포장(<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.packing_price}" />원) </option>
                                </c:if>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <input type="button" class="btn btn-block btn-lg btn-primary" value="장바구니">
                        </div>
                        <div class="col-md-6">
                            <input type="button" class="btn btn-block btn-lg btn-primary" value="바로 구매">
                        </div>
                    </div>

                    <!-- 상품 추가 영역 -->

                    <div class="row align-items-center mt-3" style="border-top: #dddddd 1px solid; ">
                        <div class="col-md-8">
                            <h3 class="mt-3">총 가격</h3>
                        </div>
                        <div class="col-md-4">
                            <h3 class="mt-3" id="total-price">0</h3>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="separator">
        <div class="container">
            <div class="row gutter-2 gutter-lg-4 border-bottom">
                <div class="col-md-4 d-flex justify-content-center align-items-center text-center ">
                    <button id="detailBtn" class="btn btn-link text-dark" onclick="scrollToSection('detail'); ">Detail</button>
                </div>
                <div class="col-md-4 d-flex justify-content-center align-items-center text-center ">
                    <button id="reviewBtn" class="btn btn-link text-dark" onclick="scrollToSection('review')">Review</button>
                </div>
                <div class="col-md-4 d-flex justify-content-center align-items-center text-center">
                    <button id="qnaBtn" class="btn btn-link text-dark" onclick="scrollToSection('qna')">Q&A</button>
                </div>
            </div>
        </div>
    </section>

    <!-- 상품 상세 영역 -->
    <section class="separator item-detail" id="detailSection">
        <div class="container">
            <div class="row gutter-2 gutter-lg-4">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center">
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <div style="width: 80%; margin: auto" >
                        ${item.detail}
                    </div>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>

                </div>
            </div>
        </div>
    </section>

    <!-- 리뷰 영역 -->
    <section class="separator item-review" id="reviewSection">
        <div class="container border-top">
            <br>
            <br>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div>후기(6,404 개)</div>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <h2><b>4.3</b> / 5</h2>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div class="col-md-8">
                </div>
                <div class="col-md-3 d-flex align-items-center justify-content-end">
                    <input type="checkbox" value="photo-review-check" class="form-control-sm">
                    <label class="mb-0 ml-1">포토리뷰만 보기</label>
                </div>
                <div class="col-1">
                    <select name="orderBy" class="form-control-sm">
                        <option value="" disabled selected>정렬</option>
                    </select>
                </div>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center" style="width: 100%;">
                    <div class="accordion accordion-minimal" id="review-1" style="width: 100%; margin: 0;">
                        <div class="card">
                            <div class="card-header" id="review-heading-1">
                                <h5 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#review-detail-1" aria-expanded="false" aria-controls="review-detail-1" style="padding-bottom: 0;">
                                        <div class="row w-100 align-items-center">
                                            <div class="col-2">
                                                <span class="rating">⭐⭐⭐⭐⭐</span>
                                                <span class="photo-status">🖼️️</span>
                                            </div>
                                            <div class="col-6 review-title" >
                                                상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.
                                            </div>
                                            <div class="col-2 user-id">
                                                User123
                                            </div>
                                            <div class="col-2 date">
                                                2024-06-13
                                            </div>
                                        </div>
                                    </button>
                                </h5>
                            </div>

                            <!-- class에서 show의 유무에 따라 열리고 닫힘 -->
                            <div id="review-detail-1" class="collapse" aria-labelledby="review-heading-1" data-parent="#review-1" style="background: #fafafa;">
                                <div class="card-body text-left content-box">
                                    <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1685510644/noticon/zlnodb9oj9icejaqiytd.png">
                                    <p>리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글리뷰 상세 text 글</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center" style="width: 100%;">
                    <div class="accordion accordion-minimal" id="review-2" style="width: 100%; margin:0;">
                        <div class="card">
                            <div class="card-header" id="review-heading-2">
                                <h5 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#review-detail-2" aria-expanded="false" aria-controls="review-detail-2" style="padding-bottom: 0;">
                                        <div class="row w-100 align-items-center">
                                            <div class="col-2">
                                                <span class="rating">⭐⭐⭐⭐⭐</span>
                                                <span class="photo-status">️</span>
                                            </div>
                                            <div class="col-6 review-title" >
                                                상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.
                                            </div>
                                            <div class="col-2 user-id">
                                                User123
                                            </div>
                                            <div class="col-2 date">
                                                2024-06-13
                                            </div>
                                        </div>
                                    </button>
                                </h5>
                            </div>

                            <!-- class에서 show의 유무에 따라 열리고 닫힘 -->
                            <div id="review-detail-2" class="collapse" aria-labelledby="review-heading-2" data-parent="#review-2" style="background: #fafafa ">
                                <div class="card-body text-left content-box">
                                     <p>리뷰 상세 text 글</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col text-center">
                    <!-- 페이지 네이션 영역 -->
                    <nav class="item-pagination">
                        <ul class="item-pagination-list">
                            <li>1</li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <!-- QnA 영역 -->
    <section class="separator item-qna" id="qnaSection">
        <div class="container border-top">
            <br>
            <br>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div class="col-md-9 text-left">
                    상품 문의(6,404 개)
                </div>
                <div class="col-md-3 d-flex align-items-center justify-content-end">
                    <input type="button" value="문의하기" class="btn btn-primary btn-sm">
                </div>
            </div>
<%--            <div class="row gutter-2 gutter-lg-4 mb-0 w-100" style="font-size: 14px;">--%>
            <div class="row gutter-2 gutter-lg-4 mb-0 d-flex justify-content-center align-items-center text-center border-bottom" style="font-size: 14px;">
                <div class="col-md-1 reply-status-line">
                    답변상태
                </div>
                <div class="col-md-2 reply-type-line text-left">
                    질문유형
                </div>
                <div class="col-md-5 reply-title-line">
                    제목
                </div>
                <div class="col-md-2 user-id-line text-left">
                    작성자
                </div>
                <div class="col-md-2 date-line text-left">
                    작성일
                </div>
            </div>
            <br>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center" style="width: 100%;">
                    <div class="accordion accordion-minimal" id="qna-1" style="width: 100%; margin: 0;"> <!-- accordion-1 -> qna-1 -->
                        <!-- -->
                        <div class="card">                  <!-- heading-1-1 -> qna-heading-1 -->
                            <div class="card-header" id="qna-heading-1">
                                <!-- -->
                                <h5 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#qna-detail-1" aria-expanded="false" aria-controls="qna-detail-1" style="padding-bottom: 0;">
                                        <!-- -->
                                        <div class="row w-100 align-items-center">
                                            <div class="col-1 reply-status">
                                                답변 대기
                                            </div>
                                            <div class="col-2 reply-type">
                                                상품 상세 문의
                                            </div>
                                            <div class="col-5 reply-title">
                                                상품 문의 글입니다 상품 문의 글입니다 상품 문의 글입니다 상품 문의 글입니다 상품 문의 글입니다 상품 문의 글입니다
                                            </div>
                                            <div class="col-2 user-id" style="padding: 0 30px;">
                                                User123
                                            </div>
                                            <div class="col-2 date" style="padding: 0 25px;">
                                                2024-06-13
                                            </div>
                                        </div>
                                    </button>
                                </h5>
                            </div>

                            <!-- class에서 show의 유무에 따라 열리고 닫힘 -->
                            <!-- collapse-1-1 -> qna-detail-1 -->
                            <div id="qna-detail-1" class="collapse" aria-labelledby="qna-heading-1" data-parent="#qna-1" style="background: #fafafa ">
                                <div class="card-body text-left content-box"> <!-- container 만져보기 -->
                                    <h4>Q</h4>
                                    <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1685510644/noticon/zlnodb9oj9icejaqiytd.png">
                                    <p> 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t
                                        문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t
                                        문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center" style="width: 100%;">
                    <div class="accordion accordion-minimal" id="qna-2" style="width: 100%; margin:0;">
                        <div class="card">
                            <div class="card-header" id="qna-heading-2">
                                <h5 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#qna-detail-2" aria-expanded="false" aria-controls="qna-detail-2" style="padding-bottom: 0;">
                                        <div class="row w-100 align-items-center">
                                            <div class="col-1 reply-status">
                                                답변 완료
                                            </div>
                                            <div class="col-2 reply-type">
                                                교환/환불 문의
                                            </div>
                                            <div class="col-5 reply-title">
                                                상품 문의 글입니다 상품 문의 글입니다 상품 문의 글입니다 상품 문의 글입니다 상품 문의 글입니다 상품 문의 글입니다
                                            </div>
                                            <div class="col-2 user-id">
                                                User123
                                            </div>
                                            <div class="col-2 date">
                                                2024-06-13
                                            </div>
                                        </div>
                                    </button>
                                </h5>
                            </div>

                            <!-- class에서 show의 유무에 따라 열리고 닫힘 -->
                            <div id="qna-detail-2" class="collapse" aria-labelledby="qna-heading-2" data-parent="#qna-2" style="background: #fafafa ">
                                <div class="card-body text-left content-box">
                                    <h4>Q</h4>
                                    <p> 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t
                                        문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t
                                        문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t
                                        문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t 문 의 상 세 t e x t </p>
                                </div>
                                <div class="card-body text-left content-box border-top">
                                    <br>
                                    <h4>A</h4>
                                    <p> 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t
                                        문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t
                                        문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t
                                        문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t 문 의 답 변 t e x t </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col text-center">
                    <!-- 페이지 네이션 영역 -->
                    <nav class="item-pagination">
                        <ul class="item-pagination-list">
                            <li>1</li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </section>


    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
