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
        .user-id,
        .date {
            font-size: 14px; /* 텍스트 크기 조정 */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
    </style>

    <title>soaff</title>
    <script>
        function activateTab(tabName) {
        // 모든 버튼의 active-border 클래스 제거
        document.getElementById('detailBtn').classList.remove('active-border');
        document.getElementById('reviewBtn').classList.remove('active-border');
        document.getElementById('qnaBtn').classList.remove('active-border');

        // 클릭된 버튼에 active-border 클래스 추가
        if (tabName === 'detail') {
            document.getElementById('detailBtn').classList.add('active-border');
        } else if (tabName === 'review') {
            document.getElementById('reviewBtn').classList.add('active-border');
        } else if (tabName === 'qna') {
            document.getElementById('qnaBtn').classList.add('active-border');
        }

            // 원하는 데이터를 로드하는 함수 호출
        }

            // 기본적으로 첫 번째 탭에 active-border 클래스 추가
        document.getElementById('detailBtn').classList.add('active-border');

        function increaseValue(){

        }

        function decreaseValue(){

        }
    </script>

    </script>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<body>

<br>
<br>
<br>
<!-- product -->
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

                <div class="col-lg-5 mb-5 mb-lg-0">
                    <div class="row">
                        <div class="col-12">
                            <h1 class="item-title">Product name</h1>
                            <h3 class="item-title text-muted">상품에 대한 간단한 설명</h3>
                            <span class="item-price"><s class="text-muted">9500</s><span class="text-red">10%</span></span>
                            <div class="item-price"> 8850원</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <select name="select-product" id="select-product" class="form-control" onchange="applyCondition();">
                                <option value="" disabled selected>상품 선택</option>
                                <option value="product name"> product name </option>
                                <option value="additional product name"> additional product name </option>
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
                    <!-- 상품 선택 시 아래의 영역에 추가 -->
                    <div class="row align-items-center mt-3" style="border-top: #dddddd 1px solid; ">
                        <div class="col-md-7">
                            <!-- 상품 영역 -->
                            <h5 class="mt-3">Product name</h5>
                            8,850원
                        </div>
                        <div class="col-5 d-flex no-padding">
                            <button class="btn btn-outline-secondary btn-sm btn-full-width mt-3" type="button" id="button-minus-0" onclick="decreaseValue()">-</button>
                            <input type="number" class="form-control form-control-sm input-full-width mt-3" min="1" max="9" value="1">
                            <button class="btn btn-outline-secondary btn-sm btn-full-width mt-3" type="button" id="button-plus-0" onclick="increaseValue()">+</button>
                            <button class="btn btn-sm btn-full-width mt-3" type="button" id="button-delete-item-0" onclick="increaseValue()">x</button>
                        </div>
                    </div>
                    <div class="row align-items-center mt-3" style="border-top: #dddddd 1px solid; ">
                        <div class="col-md-7">
                            <!-- 상품 영역 -->
                            <h5 class="mt-3">Product name - 포장</h5>
                            8,850원
                        </div>
                        <div class="col-5 d-flex no-padding">
                            <button class="btn btn-outline-secondary btn-sm btn-full-width mt-3" type="button" id="button-minus" onclick="decreaseValue()">-</button>
                            <input type="number" class="form-control form-control-sm input-full-width mt-3" min="1" max="9" value="1" >
                            <button class="btn btn-outline-secondary btn-sm btn-full-width mt-3" type="button" id="button-plus" onclick="increaseValue()">+</button>
                            <button class="btn btn-sm btn-full-width mt-3" type="button" id="button-delete-item" onclick="increaseValue()">x</button>
                        </div>
                    </div>
                    <div class="row align-items-center mt-3" style="border-top: #dddddd 1px solid; ">
                        <div class="col-md-8">
                            <h3 class="mt-3">총 가격</h3>
                        </div>
                        <div class="col-md-4">
                            <h3 class="mt-3">18,700</h3>
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
                    <button id="detailBtn" class="btn btn-link text-dark" onclick="activateTab('detail')">Detail</button>
                </div>
                <div class="col-md-4 d-flex justify-content-center align-items-center text-center ">
                    <button id="reviewBtn" class="btn btn-link text-dark" onclick="activateTab('review')">Review</button>
                </div>
                <div class="col-md-4 d-flex justify-content-center align-items-center text-center">
                    <button id="qnaBtn" class="btn btn-link text-dark" onclick="activateTab('qna')">Q&A</button>
                </div>
            </div>
        </div>
    </section>


    <section class="separator item-detail">
        <div class="container">
            <div class="row gutter-2 gutter-lg-4">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center">
                    123 123 123 123 123
                    123 123 123 123 123
                    123 123 123 123 123
                    123 123 123 123 123
                    123 123 123 123 123
                </div>
            </div>
        </div>
    </section>

    <section class="separator item-review ">
        <div class="container border-top">
            <br>
            <br>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div>평점(6,404 개)</div>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <h2><b>4.3</b> / 5</h2>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center" style="width: 100%;">
                    <div class="accordion accordion-minimal" id="accordion-1" style="width: 100%; margin: 0;">
                        <div class="card">
                            <div class="card-header" id="heading-1-1">
                                <h5 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapse-1-1" aria-expanded="false" aria-controls="collapse-1-1" style="padding-bottom: 0;">
                                        <div class="row w-100 align-items-center">
                                            <div class="col-2">
                                                <span class="rating">⭐⭐⭐⭐⭐</span>
                                                <span class="photo-status">🖼️</span>
                                            </div>
                                            <div class="col-6">
                                                <div class="review-title">상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.</div>
                                            </div>
                                            <div class="col-2">
                                                <span class="user-id">User123</span>
                                            </div>
                                            <div class="col-2">
                                                <span class="date">2024-06-13</span>
                                            </div>
                                        </div>
                                    </button>
                                </h5>
                            </div>

                            <!-- class에서 show의 유무에 따라 열리고 닫힘 -->
                            <div id="collapse-1-1" class="collapse" aria-labelledby="heading-1-1" data-parent="#accordion-1" style="background: #fafafa ">
                                <div class="card-body text-left">
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
                    <div class="accordion accordion-minimal" id="accordion-2" style="width: 100%; margin:0;">
                        <div class="card">
                            <div class="card-header" id="heading-2-1">
                                <h5 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapse-2-1" aria-expanded="false" aria-controls="collapse-2-1" style="padding-bottom: 0;">
                                        <div class="row w-100">
                                            <div class="col-2">
                                                <span class="rating">⭐⭐⭐⭐⭐</span>
                                                <span class="photo-status">️</span>
                                            </div>
                                            <div class="col-6">
                                                <div class="review-title">상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.상품 후기 제목입니다.</div>
                                            </div>
                                            <div class="col-2">
                                                <span class="user-id">User123</span>
                                            </div>
                                            <div class="col-2">
                                                <span class="date">2024-06-13</span>
                                            </div>
                                        </div>
                                    </button>
                                </h5>
                            </div>

                            <!-- class에서 show의 유무에 따라 열리고 닫힘 -->
                            <div id="collapse-2-1" class="collapse" aria-labelledby="heading-2-1" data-parent="#accordion-2" style="background: #fafafa ">
                                <div class="card-body text-left">
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

    <section class="separator item-qna">
        <div class="container border-top">
            <div class="row gutter-2 gutter-lg-4">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center">
                    123 123 123 123 123
                    123 123 123 123 123
                    123 123 123 123 123
                    123 123 123 123 123
                    123 123 123 123 123
                </div>
            </div>
        </div>
    </section>


    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
