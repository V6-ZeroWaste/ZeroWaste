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
            border-bottom: 3px solid #618264; /* 원하는 색상과 두께로 설정 */
        }

        .input-count:read-only{
            background-color: #efefef;
        }

        .review-title,
        .reply-status,
        .reply-type,
        .reply-title,
        .user-id,
        .rating,
        .date {
            font-size: 14px; /* 텍스트 크기 조정 */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding-bottom: 1%;
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
            /*padding: 15px;*/
        }

        .rating,
        .photo-status {
            font-size: 12px; /* 별점과 사진 상태 텍스트 크기 조정 */
            display: inline-block; /* 한 줄에 나란히 배치 */
            vertical-align: middle; /* 텍스트 가운데 정렬 */
            /* */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding-bottom: 7%;
        }

        .photo-status {
            margin-left: 5px; /* 별점과 사진 상태 사이의 간격 조정 */
        }

        .content-box{
            /*padding: 50px;*/
            margin: 50px;
        }
        #total-price {
            white-space: nowrap;
        }

        .review-pagination-list,
        .qna-pagination-list{
            display: flex; /* 가로 배열을 위해 flexbox 사용 */
            justify-content: center; /* 자식 요소들을 수평으로 가운데 정렬 */
            list-style-type: none; /* 기본 리스트 스타일 제거 */
            padding: 0; /* 기본 패딩 제거 */
            margin: 0; /* 기본 마진 제거 */
        }
        .review-pagination-list .page-item,
        .qna-pagination-list .page-item{
            margin-right: 5px; /* 페이지 아이템 간의 간격 조정 */
        }
        .review-pagination-list .page-link:hover,
        .qna-pagination-list .page-link:hover{
            background-color: #e9ecef; /* 호버 시 배경색 변경 */
        }
        .datatable-active .page-link {
            font-weight: bold;
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
        }

        function addItem() {
            var itemName = $("#select-product").val();
            var itemPrice = $("#item-price").text();
            var selectedItems = [];

            if(itemName.includes('포장')){
                itemPrice=${item.discounted_price + item.packing_price};
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
            html+="<input type='number' class='form-control form-control-sm input-full-width mt-3 input-count' min='1'";
            html+="max='9' value='1' readonly />";
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

        $(document).ready(function() {
            // 처음에는 detailBtn에 active-border 클래스 추가
            $('#detailBtn').addClass('active-border');

            // IntersectionObserver의 콜백 함수
            const callback = (entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        // 모든 버튼에서 active-border 클래스 제거
                        $('#detailBtn').removeClass('active-border');
                        $('#reviewBtn').removeClass('active-border');
                        $('#qnaBtn').removeClass('active-border');

                        // 현재 보이는 섹션에 해당하는 버튼에 active-border 클래스 추가
                        if ($(entry.target).attr('id') === 'detailSection') {
                            $('#detailBtn').addClass('active-border');
                        } else if ($(entry.target).attr('id') === 'reviewSection') {
                            $('#reviewBtn').addClass('active-border');
                        } else if ($(entry.target).attr('id') === 'qnaSection') {
                            $('#qnaBtn').addClass('active-border');
                        }
                    }
                });
            };

            // IntersectionObserver 옵션
            const options = {
                root: null,
                rootMargin: '0px',
                threshold: 0.5 // 원하는 임계값 (0.5는 절반 이상 보여야 함)
            };

            // IntersectionObserver 인스턴스 생성
            const observer = new IntersectionObserver(callback, options);

            // 각 섹션을 관찰 대상으로 설정
            observer.observe(document.getElementById('detailSection'));
            observer.observe(document.getElementById('reviewSection'));
            observer.observe(document.getElementById('qnaSection'));
        });
    </script>

    <!-- 리뷰 -->
    <script>
        let reviewPage = 1;
        window.onload=function(){
            getReviewList();
            getQnaList();
        }
        function applyReviewCondition(){
            reviewPage = 1;
            getReviewList();
        }
        function changeReviewPage(obj){
            reviewPage = obj.getAttribute("data-page");
            getReviewList();
            scrollToReviewSection();
        }

        function scrollToReviewSection(){
            $('html, body').animate({
                scrollTop: $('#reviewSection').offset().top
            }, 500);

        }

        function getReviewList(){
            var data = {
                orderBy: $('#reviewOrderBy').val(),
                item_no: ${item.item_no},
                filter: $('#photo-check-box').is(':checked') ? '사진' : '',
                page: reviewPage,
            }
            console.log(data.photoCheck);
            $.ajax({
                type: "GET", // method type
                url: "/item/getReviewList", // 요청할 url
                data: data, // 전송할 데이터
                dataType: "json", // 응답 받을 데이터 type
                success : function(resp){
                    console.log("리뷰 성공");
                    // 데이터 리스트 출력
                    $("#reviewPrintList").html(resp.printList);
                    $("#review-total").html("후기("+resp.total.toLocaleString()+"개)");
                    $("#avgScore").html(resp.avgScore);
                    //
                    // // 페이지네이션 출력
                    // // 페이지네이션
                    let printPage = "";
                    if(resp.isPrev){
                        printPage += '<li class="datatable-pagination-list-item page-item">';
                        printPage += '<a data-page="1" class="datatable-pagination-list-item-link page-link" onclick="changeReviewPage(this);">‹‹</a></li>';
                        printPage += '<li class="datatable-pagination-list-item page-item">';
                        printPage += '<a data-page="'+(resp.startPage-1)+'" class="datatable-pagination-list-item-link page-link" onclick="changeReviewPage(this);">‹</a></li>';
                    }
                    for(i = resp.startPage; i<=resp.endPage; i++){
                        printPage += '<li class="datatable-pagination-list-item page-item'+(i==reviewPage? ' datatable-active' : '')+'">';
                        printPage += '<a data-page="'+ i +'" class="datatable-pagination-list-item-link page-link" onclick="changeReviewPage(this);">'+i+'</a></li>';
                    }
                    if(resp.isNext){
                        printPage += '<li class="datatable-pagination-list-item page-item">';
                        printPage += '<a data-page="'+(resp.endPage+1)+'" class="datatable-pagination-list-item-link page-link" onclick="changeReviewPage(this);">‹‹</a></li>';
                        printPage += '<li class="datatable-pagination-list-item page-item">';
                        printPage += '<a data-page="'+resp.totalPage+'" class="datatable-pagination-list-item-link page-link" onclick="changeReviewPage(this);">‹</a></li>';
                    }
                    $(".review-pagination-list").html(printPage);



                },
                error:function (data, textStatus) {
                    console.log("리뷰 실패");
                    $('#fail').html("관리자에게 문의하세요.") // 서버오류
                    console.log('error', data, textStatus);
                }
            })

        }
    </script>

    <!-- 문의 -->
    <script>
        let qnaPage = 1;
        function applyQnaCondition(){
            qnaPage = 1;
            getQnaList();
        }
        function changeQnaPage(obj){
            qnaPage = obj.getAttribute("data-page");
            getQnaList();
        }

        function getQnaList(){
            var data = {
                item_no: ${item.item_no},
                page: qnaPage,
            }

            $.ajax({
                type: "GET", // method type
                url: "/item/getQnaList", // 요청할 url
                data: data, // 전송할 데이터
                dataType: "json", // 응답 받을 데이터 type
                success : function(resp){
                    console.log("문의 성공");
                    // 데이터 리스트 출력
                    $("#qnaPrintList").html(resp.printList);
                    $("#qna-total").html("상품 문의("+resp.total.toLocaleString()+"개)");
                    //
                    // // 페이지네이션 출력
                    // // 페이지네이션
                    let printPage = "";
                    if(resp.isPrev){
                        printPage += '<li class="datatable-pagination-list-item page-item">';
                        printPage += '<a data-page="1" class="datatable-pagination-list-item-link page-link" onclick="changeQnaPage(this);">‹‹</a></li>';
                        printPage += '<li class="datatable-pagination-list-item page-item">';
                        printPage += '<a data-page="'+(resp.startPage-1)+'" class="datatable-pagination-list-item-link page-link" onclick="changeQnaPage(this);">‹</a></li>';
                    }
                    for(i = resp.startPage; i<=resp.endPage; i++){
                        printPage += '<li class="datatable-pagination-list-item page-item'+(i==qnaPage? ' datatable-active' : '')+'">';
                        printPage += '<a data-page="'+ i +'" class="datatable-pagination-list-item-link page-link" onclick="changeQnaPage(this);">'+i+'</a></li>';
                    }
                    if(resp.isNext){
                        printPage += '<li class="datatable-pagination-list-item page-item">';
                        printPage += '<a data-page="'+(resp.endPage+1)+'" class="datatable-pagination-list-item-link page-link" onclick="changeQnaPage(this);">‹‹</a></li>';
                        printPage += '<li class="datatable-pagination-list-item page-item">';
                        printPage += '<a data-page="'+resp.totalPage+'" class="datatable-pagination-list-item-link page-link" onclick="changeQnaPage(this);">‹</a></li>';
                    }
                    // console.log(printPage);
                    $(".qna-pagination-list").html(printPage);



                },
                error:function (data, textStatus) {
                    console.log("문의 실패");
                    $('#fail').html("관리자에게 문의하세요.") // 서버오류
                    console.log('error', data, textStatus);
                }
            })

        }
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
                                <a class="image" href="/upload/item_img/${item.item_img}"
                                   style="background-image: url(/upload/item_img/${item.item_img});">
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
<%--                                    <option value="포장(<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.discounted_price+item.packing_price}" />원)"> ${item.name} 포장 (+<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.packing_price}" />원) </option>--%>
                                    <option value="${item.name} (포장) "> ${item.name} 포장 (+<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.packing_price}" />원) </option>
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
                        <div class="col-md-8 ">
                            <h3 class="mt-3">총 가격</h3>
                        </div>
                        <div class="col-md-4 d-flex justify-content-end">
                            <h3 class="mt-3" id="total-price">0원</h3>
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
                <div id="review-total">후기(6,404 개)</div>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <h2><b id="avgScore">4.3</b> / 5</h2>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0">
                <div class="col-md-8">
                </div>
                <div class="col-md-3 d-flex align-items-center justify-content-end">
                    <input type="checkbox" value="photo-review-check" id="photo-check-box" class="form-control-sm" onchange="applyReviewCondition();">
                    <label class="mb-0 ml-1">포토리뷰만 보기</label>
                </div>
                <div class="col-1">
                    <select name="reviewOrderBy" id="reviewOrderBy" class="form-control-sm" onchange="applyReviewCondition();">
                        <option value="최신순" selected>최신순</option>
                        <option value="오래된순" >오래된순</option>
                        <option value="높은평점순" >높은 평점 순</option>
                        <option value="낮은평점순" >낮은 평점 순</option>
                    </select>
                </div>
            </div>

            <div id="reviewPrintList"> <!-- 리뷰 리스트 -->
            </div>
            <div class="row">
                <div class="col text-center">
                    <!-- 리뷰 페이지 네이션 영역 -->
                    <nav class="review-pagination">
                        <ul class="review-pagination-list">
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
                <div class="col-md-9 text-left" id="qna-total">
                </div>
                <div class="col-md-3 d-flex align-items-center justify-content-end">
                    <input type="button" value="문의하기" class="btn btn-primary btn-sm">
                </div>
            </div>
            <div class="row gutter-2 gutter-lg-4 mb-0 d-flex justify-content-center align-items-center text-center" style="font-size: 14px;">
                <div class="col-md-12 d-flex justify-content-center align-items-center text-center" style="padding: 0; width: 100%;">
                    <div class="row w-100 align-items-center mb-0 border-bottom" style="padding:20px; margin-right:18px; width:100%">
                        <div class="col-md-1 reply-status-line">
                            답변상태
                        </div>
                        <div class="col-md-2 reply-type-line">
                            질문유형
                        </div>
                        <div class="col-md-5 reply-title-line">
                            제목
                        </div>
                        <div class="col-md-2 user-id-line">
                            작성자
                        </div>
                        <div class="col-md-2 date-line">
                            작성일
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <div id="qnaPrintList"> <!-- 문의 리스트 -->
            </div>
            <!-- 문의 끝 -->
            <div class="row">
                <div class="col text-center">
                    <!-- 문의 페이지 네이션 영역 -->
                    <nav class="qna-pagination">
                        <ul class="qna-pagination-list">
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </section>


    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
