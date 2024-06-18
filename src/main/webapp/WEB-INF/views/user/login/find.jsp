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
    $('#relEmail').val($('#email_id').val() + "@" + $('#email_domain').val());
    
    $(function (){
        $('#emailSel').change(function () {
            var emailSel = $(this).val();
            var email_domain = $("#email_domain");
            console.log(emailSel);
            if (emailSel === '직접입력') {
                emailSel = null;
                email_domain.attr('readonly', false);
            }
            email_domain.val(emailSel);
        });
    })
    function goFind() {
        if (fieldCheck()) {
            $('#frmFindLog').submit();
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
    <div style="background-color: #c2c2c2"></div>
    <div class="container">
        <div class="row justify-content-center align-items-center vh-md-100">
            <div class="col-md-10 col-lg-7">
                <div class="l" id="accordionExample">
                    <form id="frmFindLog">
                        <div class="card active">
                            <div class="card-header" id="headingOne">
                                <h2 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Find Id
                                    </button>
                                </h2>
                            </div>

                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                                <div class="card-body">
                                    <div class="row mt-2">
                                        <div class="form-group col-12">
                                            <label for="name">이름</label>
                                            <input type="text" class="form-control" id="name" name="name">

                                        </div>
                                        <div class="form-group col-12 mt-1">
                                            <label for="email_id">이메일</label>
                                            <%--                                        --%>
                                            <div class="col-12 div">
                                                <div class="row">
                                                    <div class="col-md-4" style="padding: 0;">
                                                        <div style="display: flex">
                                                            <input type="text" class="form-control" id="email_id" name="email_id" placeholder="이메일" aria-label="이메일입력">
                                                            <span class="col-form-label">&nbsp;&nbsp;@&nbsp;&nbsp;</span>
                                                        </div>
                                                        <div class="valid-feedback"></div>
                                                        <div class="invalid-feedback" id="email_idErrorMsg"></div>
                                                    </div>
                                                    <div class="col-md-4" style="padding: 0;">
                                                        <input type="text" class="form-control" id="email_domain" name="email_domain" placeholder="도메인이름" aria-label="도메인이름" readonly >
                                                        <div class="valid-feedback"></div>
                                                        <div class="invalid-feedback" id="email_domainErrorMsg"></div>
                                                    </div>
                                                    <div class="col-4" style="padding: 0;">
                                                        <select id="emailSel" class="custom-select" >
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
                                                    <input type="hidden" id="relEmail" name="relEmail">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-2">
                                            <button type="button" class="btn btn-block btn-primary" onclick="goFind()">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="card">
                        <div class="card-header" id="headingTwo">
                            <h2 class="mb-0">
                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    Find Password
                                </button>
                            </h2>
                        </div>
                        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                            <div class="card-body">
                                <div class="row mt-2">
                                    <div class="form-group col-12">
                                        <label for="pw_id">아이디</label>
                                        <input type="text" class="form-control form-control" id="pw_id" name="pw_id">
                                        <div class="invalid-feedback"></div>
                                    </div>
                                    <div class="form-group col-12 mt-1">
                                        <label for="pw_name">이름</label>
                                        <input type="text" class="form-control" id="pw_name" name="pw_name">
                                        <div class="invalid-feedback"></div>
                                    </div>
                                    <div class="col-12 mt-2">
                                        <button type="button" class="btn btn-block btn-primary">Submit</button>
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
