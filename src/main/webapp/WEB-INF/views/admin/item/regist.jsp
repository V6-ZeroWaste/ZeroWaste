<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>상품 등록</title>
    <link href="/admin/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/admin/js/scripts.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <script src="/smarteditor/js/HuskyEZCreator.js"></script>
    <style>
        img{
            max-height: 300px;
            max-width: 500px;
        }
        .title-img{
            height: 500px;
        }
    </style>
    <script>
        var oEditors = [];
        $(function() {
            nhn.husky.EZCreator.createInIFrame({
                oAppRef: oEditors,
                elPlaceHolder: "content",
                sSkinURI: "/smarteditor/SmartEditor2Skin.html",
                htParams : {
                    bUseToolbar : true,                // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
                    bUseVerticalResizer : true,        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
                    bUseModeChanger : true,            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
                    fOnBeforeUnload : function(){
                    }
                }, //boolean
                fOnAppLoad : function(){
                    //예제 코드
                    //oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
                },
                fCreator: "createSEditor2"
            });
        });

        function goSave() {
            oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용됩니다.
            document.forms[name='regist'].submit(); // 폼 제출
        }

        function openPopup(){
            var windowPopup = window.open("category", "new", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=1000, height=700, left=0, top=0" );
            windowPopup.onbeforeunload = function() {
                window.location.reload();
            };
            windowPopup.onload = function() {
                window.location.reload();
            };
        }

    </script>
    <script>
        var itemNo = "${item.item_no}";


        function deleteItem(){
            if(confirm("정말 삭제하시겠습니까?")){
                $.ajax({
                    url : "/admin/item/delete",
                    type : "POST",
                    data : {itemNo : itemNo},
                    success : function(response){
                        alert(response);
                        document.location.href = 'list';
                    },
                    error: function(xhr, status, error){
                        alert(response);
                    }
                });
            }
        }

        function deleteImg(){
            if(confirm("정말 삭제하시겠습니까?")){
                $.ajax({
                    url : "/admin/item/deleteImg",
                    type : "POST",
                    data : {itemNo : itemNo },
                    success : function(response){
                        alert(response);
                        window.location.reload();
                    },
                    error: function(xhr, status, error){
                        alert(response);
                    }
                });
            }
        }
    </script>

    <script>
        $(function(){
            var itemImg = "${item.item_img}";
            var deleteButton = $("input[name='x']");

            if(itemImg == null || itemImg.trim() === ""){
                deleteButton.css("display", "none");
            } else {
                deleteButton.css("display", "block");
            }
        })
    </script>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
    <div id="layoutSidenav">
        <%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="container-fluid px-4 d-flex justify-content-end">
                        <button class="btn btn-primary my-3" onclick="history.back()">돌아가기</button>
                    </div>
                    <div class="card mb-4">
                        <div class="list-group">
                            <form method="post" action="regist" name="regist" enctype="multipart/form-data">
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center title-img d-flex align-items-center justify-content-center">
                                            <b>상품 대표<br>이미지</b>
                                        </div>
                                        <div class="col-md-3">
                                            <input class="form-control" type="file" name="file" id="file" class="wid100"/>
                                        </div>
                                        <div class="col-md-3 d-flex flex-column align-items-center">
                                            <img src="/upload/item_img/${item.item_img}" class="img-fluid"/>
                                            <p>${item.item_img}</p>
                                            <input class="btn btn-danger" type="button" name="x" value="이미지 삭제" onclick="deleteImg()">
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>카테고리</b>
                                        </div>
                                        <div class="col-md-2">
                                            <select name="category_no" class="form-select">
                                                <c:forEach var="category" items="${categories}">
                                                    <c:choose>
                                                        <c:when test="${item.category_no == category.category_no}">
                                                            <option value="${category.category_no}" selected>${category.name}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${category.category_no}">${category.name}</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="button" class="btn btn-outline-primary" value="수정" onclick="openPopup()">
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>상품명</b>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="text" name="name" class="form-control" value="${item.name}">
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>상품설명</b>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="text" class="form-control" name="description" value="${item.description}">
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>재고</b>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="text" name="amount" class="form-control" value="${item.amount}">
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>포장 가능 여부</b>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="radio" class="form-check-input" name="packable_option" value="true"
                                                   ${item.packable_option ? 'checked="checked"' : '' }
                                            >가능 |
                                            <input type="radio" class="form-check-input" name="packable_option" value="false"
                                                   ${!item.packable_option ? 'checked="checked"' : '' }
                                            >불가능
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>상품 가격</b>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="text" name="price" class="form-control" value="${item.price}">
                                        </div>
                                        <div class="col-md-1">
                                            원
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>할인율</b>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="text" name="discount_rate" class="form-control" value="${item.discount_rate}" disabled >
                                        </div>
                                        <div class="col-md-1">
                                            %
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>판매 가격</b>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="text" name="discounted_price" class="form-control" value="${item.discounted_price}" >
                                        </div>
                                        <div class="col-md-1">
                                            원
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>노출 여부</b>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="radio" class="form-check-input" name="exposed_status" value="true"
                                                   ${item.exposed_status ? 'checked="checked"' : '' }
                                            >노출  |
                                            <input type="radio" class="form-check-input" name="exposed_status" value="false"
                                                   ${!item.exposed_status ? 'checked="checked"' : '' }
                                            >숨김
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-1 text-center">
                                            <b>상품 상세</b>
                                        </div>
                                        <div class="col-md-11" >
                                            <textarea name="detail" id="content" class="form-control w-100"> ${item.detail} </textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item d-flex justify-content-center">
                                    <input class="btn btn-primary me-3" type="button" value="등록" onclick="goSave()">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
            <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
        </div>
    </div>

</body>
</html>
