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

    let emailIdRegex = /^[a-zA-Z0-9._%+-]+$/;
    let emailDomainRegex = /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    $(function (){
        $('#emailSel').change(function () {
            var emailSel = $(this).val();
            var id_email_domain = $("#id_email_domain");
            if (emailSel === '직접입력') {
                id_email_domain.attr('readonly', false);
                id_email_domain.val('');
            } else {
                id_email_domain.attr('readonly', true);
                id_email_domain.val(emailSel);
            }
        });
    });

    function goFindId() {
        let idErrorMsg = $("#idErrorMsg");
        let dupCheck = false;
        let id = $("#id_name").val();
        let email = $('#id_email_id').val() + "@" + $('#id_email_domain').val();
        if (fieldCheckId()) {
            $.ajax({
                url: '/user/join/idCheck.do',
                data: {
                    id: id,
                    email : email
                },
                async: false,
                success: function (res) {
                    if (res == '1') {
                        idErrorMsg.html("중복된 아이디입니다").css("display", "block");
                        dupCheck = false;
                    } else {
                        idErrorMsg.css("display", "none");
                        dupCheck = true;
                    }
                },
                error:function (){
                    console.log(email);
                    console.log(id);
                }
            });
            if(dupCheck){
                $('#frmFindId').submit();
            }
            else{
                idErrorMsg.focus();
            }
        }
    }


    function fieldCheckId() {
        let id_name = $("#id_name");
        let id_email_id = $("#id_email_id");
        let id_email_domain = $("#id_email_domain");

        let id_nameErrorMsg = $("#id_nameErrorMsg");
        let id_email_idErrorMsg = $("#id_email_idErrorMsg");
        let id_email_domainErrorMsg = $("#id_email_domainErrorMsg");

        id_nameErrorMsg.css("display", "none");
        id_email_idErrorMsg.css("display", "none");
        id_email_domainErrorMsg.css("display", "none");

        let isValid = true;

        if (!id_name.val()) {
            id_nameErrorMsg.html("이름을 입력해주세요");
            id_nameErrorMsg.css("display", "block");
            id_name.focus();
            isValid = false;
        }


        if (!id_email_id.val()) {
            id_email_idErrorMsg.html("이메일을 입력해 주세요");
            id_email_idErrorMsg.css("display", "block");
            id_email_id.focus();
            isValid = false;
        }

        if (!id_email_domain.val()) {
            id_email_domainErrorMsg.html("도메인을 입력해 주세요");
            id_email_domainErrorMsg.css("display", "block");
            id_email_domain.focus();
            isValid = false;
        }

        return isValid;
    }

    function goFindPw() {
        let pw_SubmitErrorMsg = $("#pw_SubmitErrorMsg");
        let dupCheck = false;

        if (fieldCheckPw()) {
            $.ajax({
                url: '/user/join/idCheck.do',
                data: {  id: $("#pw_id").val(),
                         name :  $("#pw_name").val()
                },
                async: false,
                success: function (res) {
                    if (res == '1') {
                        pw_SubmitErrorMsg.html("올바른 값을 입력해주세요").css("display", "block");
                    } else {
                        pw_SubmitErrorMsg.css("display", "none");
                        dupCheck = true;
                    }
                }
            });
            if(dupCheck){
                $('#frmFindPw').submit();
            }
            else{
                pw_SubmitErrorMsg.focus();
            }
        }
    }


    function fieldCheckPw() {
        let pw_id = $("#pw_id");
        let pw_name = $("#pw_name");

        let pw_idErrorMsg = $("#pw_idErrorMsg");
        let pw_nameErrorMsg = $("#pw_nameErrorMsg");


        pw_idErrorMsg.css("display", "none");
        pw_nameErrorMsg.css("display", "none");

        let isValid = true;

        if (!pw_id.val()) {
            pw_idErrorMsg.html("아이디를 입력해주세요");
            pw_idErrorMsg.css("display", "block");
            pw_id.focus();
            isValid = false;
        }


        if (!pw_name.val()) {
            pw_nameErrorMsg.html("이름을 입력해 주세요");
            pw_nameErrorMsg.css("display", "block");
            pw_name.focus();
            isValid = false;
        }

        return isValid;
    }


    $(function () {

    });
    window.onload = function () {
        $("#name, #email_id, #email_domain").on("change", function (){
            fieldCheckId();
        });
        $("#id, #name").on("change", function (){
            fieldCheckPw();
        });
    }

</script>
</head>
<body>
<section class="py-md-0">
    <div style="background-color: #c2c2c2"></div>
    <div class="container">
        <div class="row justify-content-center align-items-center vh-md-100">
            <div class="col-md-10 col-lg-7">
                <div class="l" id="accordionExample">
                    <form id="frmFindId">
                        <div class="card active">
                            <div class="card-header" id="headingOne">
                                <h2 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Find Id
                                    </button>
                                </h2>
                            </div>

                            <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
                                <div class="card-body">
                                    <div class="row mt-2">
                                        <div class="form-group col-12">
                                            <label for="id_name">이름</label>
                                            <input type="text" class="form-control" id="id_name" name="id_name">
                                            <div class="invalid-feedback" id="id_nameErrorMsg"></div>
                                        </div>
                                        <div class="form-group col-12 mt-1">
                                            <label for="id_email_id">이메일</label>
                                            <%--                                        --%>
                                            <div class="col-12 div">
                                                <div class="row">
                                                    <div class="col-md-4" style="padding: 0;">
                                                        <div style="display: flex">
                                                            <input type="text" class="form-control" id="id_email_id" name="id_email_id" placeholder="이메일" aria-label="이메일입력">
                                                            <span class="col-form-label">&nbsp;&nbsp;@&nbsp;&nbsp;</span>
                                                        </div>
                                                        <div class="valid-feedback"></div>
                                                        <div class="invalid-feedback" id="id_email_idErrorMsg"></div>
                                                    </div>
                                                    <div class="col-md-4" style="padding: 0;">
                                                        <input type="text" class="form-control" id="id_email_domain" name="id_email_domain" placeholder="도메인이름" aria-label="도메인이름" readonly >
                                                        <div class="valid-feedback"></div>
                                                        <div class="invalid-feedback" id="id_email_domainErrorMsg"></div>
                                                    </div>
                                                    <div class="col-4" style="padding: 0;">
                                                        <select id="emailSel" class="custom-select" >
                                                            <option value="직접입력" selected>직접입력</option>
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
                                            <div class="invalid-feedback" id="id_SubmitErrorMsg"></div>
                                            <button type="button" class="btn btn-block btn-primary" onclick="goFindId()">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <form id="frmFindPw">
                        <div class="card">
                            <div class="card-header" id="headingTwo">
                                <h2 class="mb-0">
                                    <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        Find Password
                                    </button>
                                </h2>
                            </div>
                            <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordionExample">
                                <div class="card-body">
                                    <div class="row mt-2">
                                        <div class="form-group col-12">
                                            <label for="pw_id">아이디</label>
                                            <input type="text" class="form-control form-control" id="pw_id" name="pw_id">
                                            <div class="invalid-feedback" id="pw_idErrorMsg"></div>
                                        </div>
                                        <div class="form-group col-12 mt-1">
                                            <label for="pw_name">이름</label>
                                            <input type="text" class="form-control" id="pw_name" name="pw_name">
                                            <div class="invalid-feedback" id="pw_nameErrorMsg"></div>
                                        </div>
                                        <div class="col-12 mt-2">
                                            <div class="invalid-feedback" id="pw_SubmitErrorMsg"></div>
                                            <button type="button" class="btn btn-block btn-primary" onclick="goFindPw()">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
