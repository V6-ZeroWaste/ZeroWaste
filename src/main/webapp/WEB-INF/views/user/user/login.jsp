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
    <title>soaff</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<script>

    function loginCheck(event) {
    	event.preventDefault();
        let id = $("#id");
        let pw = $("#pw");
        let idCheckMsg = $("#idCheckMsg");
        let pwdCheckMsg = $("#pwdCheckMsg");

        idCheckMsg.css("display", "none");
        pwdCheckMsg.css("display", "none");

        let isValid = true;

        if (!id.val()) {
            idCheckMsg.html("아이디를 입력해주세요");
            idCheckMsg.css("display", "block");
            id.focus();
            isValid = false;
        }

        if (!pw.val()) {
            pwdCheckMsg.html("비밀번호를 입력해주세요");
            pwdCheckMsg.css("display", "block");
            if (isValid) {
                pw.focus();
            }
            isValid = false;
        }
	      $.ajax({
	        url: '/user/user/login',
	        data: {
	        	id: $("#id").val(),
	        	pw: $("#pw").val()	
	        },
	        async: false,
	        success: function (res) {
	          if (res == '1') {
	            $("#idCheckMsg").html("중복된 아이디입니다").css("display", "block");
	            console.log(1);
	            isValid = false;
	          } else {
	            isValid = true;
	          }
	        }
	      });
	      return isValid;
	    }
        
    window.onload = function() {
         var savedId = document.getElementById("savedId").value;
         if (savedId) {
             document.getElementById("id").value = savedId;
             document.getElementById("saved_id").checked = true;
         }
     }


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

                        <form action="/user/user/login" method="post" id="loginBorard" name="loginBoard"
                              onsubmit="return loginCheck(event);">
                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne"
                                 data-parent="#accordionExample">
                                <div class="card-body">
                                    <div class="row mt-2">
                                        <div class="form-group col-12">
                                            <label for="id">ID</label>
                                            <input type="text" class="form-control"
                                                   id="id" onchange="loginCheck();"name="id">
                                            <div id="idCheckMsg" class="invalid-feedback"></div>
                                        </div>
                                        <div class="form-group col-12 mt-1">
                                            <label for="pw">Password</label>
                                            <input type="password" class="form-control"
                                                   id="pw" onchange="loginCheck();" name="pw">
                                            <div id="pwdCheckMsg" class="invalid-feedback"></div>
                                        </div>
                                        <div class="col-12 mt-1">
                                            <div class="custom-control custom-switch mb-2">
                                                <input type="checkbox" class="custom-control-input"
                                                       id="saved_id" name="saved_id" value="yes">
                                                <label class="custom-control-label"
                                                       for="customSwitch1">Remeber ID</label>
                                            </div>
                                        </div>
                                        <div class="form-group col-12 mt-1">
                                            <a href="/user/user/user/find?idFind" style="color: #555555;">아이디 찾기 | </a>
                                            <a href="/user/user/user/find?pwdFind" style="color: #555555;">비밀번호 찾기</a>
                                        </div>
                                        <div class="col-12 mt-2">
                                            <input type="submit" value="LOG IN" alt="LOG IN"
                                                   class="btn btn-block btn-primary"/>
                                        </div>
                                        <div class="col-12 mt-2">
                                            <a href="/user/user/signUp" class="btn btn-block btn-primary"
                                               style="background-color: #79AC78; border-bottom-color: #79AC78; border-top-color: #79AC78; border-left-color: #79AC78; border-right-color : #79AC78;  ">계정
                                                생성</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>

</html>