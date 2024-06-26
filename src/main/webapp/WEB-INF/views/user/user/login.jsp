<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
    <title>soaff login</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<script>
    function checkBox() {
        if ($('#idSaveCheck').is(':checked')) {
            $('#idSaveCheck').val("yes");
        } else {
            $('#idSaveCheck').val(null);
        }
    }

    function loginCheck() {
        let id = $("#id");
        let pw = $("#pw");
        let idCheckMsg = $("#idCheckMsg");
        let pwdCheckMsg = $("#pwdCheckMsg");
        let submitCheckMsg = $("#submitCheckMsg");

        submitCheckMsg.css("display", "hidden");
        idCheckMsg.css("display", "hidden");
        pwdCheckMsg.css("display", "hidden");

        let isValid = true;

        if (!id.val()) {
            idCheckMsg.html("아이디를 입력해주세요");
            idCheckMsg.css("display", "block");
            isValid = false;
        }else{
            idCheckMsg.css("display", "none");
        }

        if (!pw.val()) {
            pwdCheckMsg.html("비밀번호를 입력해주세요");
            pwdCheckMsg.css("display", "block");
            isValid = false;
        }else{
            pwdCheckMsg.css("display", "none");
        }


        return isValid;
    }

    function formcheck() {
        let isValid = loginCheck();
        if (isValid) {
            $.ajax({
                url: '/login',
                method: 'post',
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify({
                    "id": $("#id").val(),
                    "pw": $("#pw").val(),
                    "idSaveCheck": $("#idSaveCheck").val()
                }),
                async: false,
                success: function (res) {
                    console.log(res);
                    if (res == '1') {
                        $("#submitCheckMsg").html("아이디와 비밀번호를 다시 확인해주세요").css("display", "block");
                        return;
                    }
                    if (res == '2') {
                        alert("탈퇴하신 계정입니다");
                        $("#submitCheckMsg").html("아이디와 비밀번호를 다시 확인해주세요").css("display", "block");
                        return;
                    }
                    else {
                        location.href="/"
                        isValid = true;
                    }
                }
            });
        }
        console.log(isValid);
        return isValid;
    }

    $(document).ready(() => {
        $('#login').on('click',() => {
            formcheck();
        });

        $('#login-form').on('keypress', ( e ) => {
            if(e.key === 'Enter' || e.keyCode === '13'){
                $('#login').click();
            }
        })
    })
</script>

<body>

<section class="py-md-0">
    <div class="image image-overlay" style="background-image:url(/user/images/main_test1.png)"></div>
    <div class="container">
        <div class="row justify-content-center align-items-center vh-md-100">
            <div class="col-md-10 col-lg-5">
                <div class="accordion accordion-portal" id="accordionExample">
                    <div id="loginPopup" class="card active">
                        <div class="card-header" id="headingOne">
                            <h2 style="padding: 15px 30px;">
                                LOG IN
                            </h2>
                        </div>


                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne"
                                 data-parent="#accordionExample">
                                <div class="card-body" id="login-form">
                                    <div class="row mt-2">
                                        <div class="form-group col-12">
                                            <label for="id">ID</label>
                                            <input type="text" class="form-control"
                                                   id="id" name="id"  value="${saved_id}">
                                            <div id="idCheckMsg" class="invalid-feedback"></div>
                                        </div>
                                        <div class="form-group col-12 mt-1">
                                            <label for="pw">Password</label>
                                            <input type="password" class="form-control"
                                                   id="pw" name="pw">
                                            <div id="pwdCheckMsg" class="invalid-feedback"></div>
                                        </div>
                                        <div class="col-12 mt-1">
                                            <div class="custom-control custom-switch mb-2">
                                                <input type="checkbox" class="custom-control-input"
                                                       id="idSaveCheck" name="idSaveCheck"
                                                ${!empty saved_id ? 'checked' : ''} onclick="checkBox()">
                                                <label class="custom-control-label"
                                                       for="idSaveCheck">Remember ID</label>
                                            </div>
                                        </div>
                                        <div class="form-group col-12 mt-1">
                                            <a href="/idFind" style="color: #555555;" class="eyebrow">FIND ID | </a>
                                            <a href="/pwFind" style="color: #555555; " class="eyebrow">FIND Password</a>
                                        </div>
                                        <div class="col-12 mt-2">
                                            <input type="button" value="LOG IN" alt="LOG IN" id="login"
                                                   class="btn btn-block btn-primary"/>
                                            <div id="submitCheckMsg" class="invalid-feedback"></div>
                                        </div>
                                        <div class="col-12 mt-2">
                                            <a href="/signUp" class="btn btn-block btn-primary"
                                               style="background-color: #79AC78; border-bottom-color: #79AC78; border-top-color: #79AC78; border-left-color: #79AC78; border-right-color : #79AC78;">SIGN UP</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>

</html>
