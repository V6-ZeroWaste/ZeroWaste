<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    let timerInterval;

    function startTimer(duration) {
      let time = duration;
      let min = "";
      let sec = "";

      timerInterval = setInterval(function () {
        min = parseInt(time / 60);
        sec = time % 60;

        document.getElementById("timer").innerHTML = min + "분 " + sec + "초";
        time--;

        if (time < 0) {
          clearInterval(timerInterval);
          document.getElementById("timer").innerHTML = "시간초과";
        }
      }, 1000);
    }

    function resetTimer() {
      clearInterval(timerInterval);
      startTimer(180);
    }

    window.addEventListener('load', function() {
      var forms = document.querySelectorAll('.needs-validation');
      (function() {
        'use strict';

        Array.prototype.slice.call(forms)
                .forEach(function(form) {
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

      // 타이머 시작
      startTimer(180);
    });

    function check() {
      var con = true;
      var name = $('#name').val();
      var email = $('#relEmail').val($('#email_id').val() + "@" + $('#email_domain').val());
      $.ajax({
        type: 'POST',
        url: '/user/login/loginFind',
        data: { name: name, email: email },
        async: false,
        success: function(res) {
          if (res == '1') {
            con = false;
          }
        }
      });
      return con;
    }

    $(function() {
      $('#emailCheck_btn').on('click', function() {
        resetTimer(); // 타이머를 재시작합니다.
        $('#emailVerification').show();
      });
    });
  </script>
</head>
<body>
<section class="py-md-0">
  <div class="container">
    <div class="row justify-content-center align-items-center vh-md-100">
      <div class="col-md-10 col-lg-6">
        <div class="card-header" id="headingOne">
          <h6 class="mb-0">
            <p style="color: #68ae68"><strong>이메일 인증</strong></p>
          </h6>
        </div>
        <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
          <div class="card-body" style="border : 1px #c2c2c2 solid">
            <div class="form-group">
              <ul class="list-group list-group-minimal mb-2">
                <li class="list-group-item d-flex justify-content-center align-items-center">
                  <span class="fs-18 mb-0" style="color: #3d733d"><strong>이메일</strong></span>
                </li>
                <li class="list-group-item d-flex justify-content-center align-items-center">
                  <span class="fs-18 mb-0" style="color: #3d733d"><strong>(${vo.email}shseo232@gmail.com)로</strong></span>
                </li>
                <li class="list-group-item d-flex justify-content-center align-items-center">
                  <span class="fs-18 mb-0" style="color: #3d733d"><strong>인증번호를 발송했습니다</strong></span>
                </li>
              </ul>
            </div>
            <form action="/user/login/passwordReSubmit" class="row">
              <div class="row" id="emailVerification">
                <label for="emailcheck_id" class="col-sm-12 col-form-label"style="color: #3d733d"><strong>인증코드 입력</strong></label>
                <div class="form-group col-6" style="padding-right: 0">
                  <input type="text" class="form-control" id="emailcheck_id" required>
                </div>
                <div class="form-group col-3 justify-content-lg-center d-flex" style="padding-left: 0;padding-right: 0">
                  <button type="button" class="btn btn-primary btn-rounded" id="emailCheck_btn">재전송</button>
                </div>
                <div class="form-group col-3" style="padding-right: 15px; padding-left: 0">
                  <span class='btn btn-block btn-secondary' id='timer'></span>
                </div>
                <div class="col-12 mt-3">
                  <button class="btn btn-block btn-primary" id="btn" type="submit">확인</button>
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
