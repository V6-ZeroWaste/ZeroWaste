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
        $(function() {
            $('#emailSel').change(function() {
                var emailSel = $(this).val();
                var email_domain = $("#email_domain");
                console.log(emailSel);
                if (emailSel === '직접입력') {
                    emailSel = null;
                    email_domain.attr('readonly', false);
                }
                email_domain.val(emailSel);
            });
        });

        window.addEventListener('load', function() {
            var forms = document.querySelectorAll('.needs-validation');
            (function() {
                'use strict';

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                    .forEach(function(form) {
                        console.log(form);
                        form.addEventListener('submit', function(event) {
                            if (!check()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }

                            form.classList.add('was-validated');
                        }, false);
                    });
            })();
        });

        function check() {
            var con = true;
            var name = $('#name').val();
            var email = $('#relEmail').val($('#email_id').val() + "@" + $('#email_domain').val());
            $.ajax({
                type: 'POST',
                url: '/user/login/loginFind',
                data: { name: name,
                        email: email},
                async: false,
                success: function(res) {
                    console.log(res);
                    if (res == '1') {

                        con = false;
                    }
                }
            });
            return con;
        }
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
                        <form action="/user/login/loginFind" method="POST" name="frm" id="frm" class="row mt-2 needs-validation" novalidate>
                            <div class="form-group col-12 mb-2">
                                <label for="name">이름</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                                <div id="idcheckResponse"></div>
                            </div>
                            <div class="form-group col-12">
                                <label for="email_id">이메일</label>
                            </div>
                            <div class="form-group col-4" style="padding-right: 0">
                                <input type="text" class="form-control" id="email_id" placeholder="이메일" aria-label="이메일입력" required>
                            </div>
                            <span class="input-group-text" style="padding-left: 7.5px; padding-right: 7.5px" id="basic-addon1">@</span>
                            <div class="form-group col-4" style="padding: 0">
                                <input type="text" class="form-control" id="email_domain" placeholder="도메인이름" aria-label="도메인이름" readonly required>
                            </div>
                            <div class="form-group col-3" style="padding-right: 0; padding-left: 0">
                                <select id="emailSel" class="custom-select" required>
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
                            <div class="col-12 mt-3">
                                <button class="btn btn-block btn-primary" id="btn" type="submit">Log In</button>
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
