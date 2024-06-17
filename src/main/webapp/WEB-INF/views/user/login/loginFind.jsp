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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>soaff</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<script>

    function goFind() {
        if (fieldCheck()) {
            location.href = "/user/login/login";
        }

    }


    function fieldCheck() {
        let name = $("#name");
        let email = $("#email");
        let emailSel = $("#emailSel");

        let nameCheckMsg = $("#nameCheckMsg");
        let emailCheckMsg = $("#emailCheckMsg");
        let emailSelCheckMsg = $("#emailSelCheckMsg");
        
        nameCheckMsg.css("display", "none");
        emailCheckMsg.css("display", "none");
        emailSelCheckMsg.css("display", "none");

        let isValid = true;

        if (!name.val()) {
        	nameCheckMsg.html("이름을 입력해주세요");
        	nameCheckMsg.css("display", "block");
        	name.focus();
            isValid = false;
        }


        if (!email.val() || !emailSel.val()) {
        	emailCheckMsg.html("주소를 입력해 주세요");
        	emailCheckMsg.css("display", "block");
        	email.focus();
            isValid = false;
        }
        
        return isValid;
    }

    window.onload = function () {
        $("#name, #email, #emailSel").on("change", fieldCheck);

    };

</script>
</head>
<body>
<section class="py-md-0">
    <div class="container">
        <div class="row justify-content-center align-items-center vh-md-100">
            <div class="col-md-10 col-lg-6">
                <div class="card-header" id="headingOne">
                    <h6 class="mb-0">
                        <p style="color: #68ae68"><strong>아이디 찾기</strong></p>
                    </h6>
                </div>
                <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                    <div class="card-body">
                        <form action="" method="POST" name="frm" id="frm" class="row mt-2">
                            <div class="form-group col-12 mb-2">
                                <label for="name">이름</label>
                                <input type="text" class="form-control" id="name" name="name" >
                                <div id="nameCheckMsg" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-12">
                                <label for="email_id">이메일</label>
                                
                            </div>
                            <div class="form-group col-4" style="padding-right: 0">
                            
                                <input type="text" class="form-control" id="email_id" placeholder="이메일" aria-label="이메일입력">
                            </div>
                            <span class="input-group-text" style="padding-left: 7.5px; padding-right: 7.5px" id="basic-addon1">@</span>
                            <div class="form-group col-4" style="padding: 0">
                                <input type="text" class="form-control" id="email_domain" placeholder="도메인이름" aria-label="도메인이름" readonly>
                            </div>
                            <div class="form-group col-3" style="padding-right: 0; padding-left: 0">
                                <select id="emailSel" class="custom-select">
                                    <option value="">선택-</option>
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
                            <div id="emailCheckMsg" class="invalid-feedback"></div>
                            
                            <input type="hidden" id="relEmail" name="relEmail">
                            <div class="col-12 mt-3">
                                <button class="btn btn-block btn-primary" id="searchIdBtn" onclick="goFind();">아이디 조회</button>
                            </div>
                            <div class="col-12 mt-2" style="text-align: right;">
                                <a class="nav-link" href="#!">비밀번호 찾기</a>
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
