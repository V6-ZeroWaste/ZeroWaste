
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
  <title>soaff find</title>
  <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
  <script>
    let timerInterval;
    let key = '';

    function startTimer(duration) {
      let time = duration;
      timerInterval = setInterval(function () {
        let min = parseInt(time / 60);
        let sec = time % 60;
        document.getElementById("timer2").innerHTML = min + "분 " + sec + "초";
        time--;
        if (time < 0) {
          clearInterval(timerInterval);
          document.getElementById("timer2").innerHTML = "시간초과";
          key = 'expired';
        }
      }, 1000);
    }

    function resetTimer() {
      clearInterval(timerInterval);
      startTimer(180);
    }

    window.onload = function (){
      startTimer(180);
      sendemail();
    };

    $(function() {
      $('#emailCheck_btn').on('click', function() {
        resetTimer();
        $('#emailVerification').show();
      });

      $('#submitBtn').on('click', function() {
        checkemail();
      });

      $('#email_btn').on('click', function () {
        if (!$('#email_id').val() || !$('#email_domain').val()) {
          $('#email_idErrorMsg').html('이메일을 입력해주세요').css("display", "block");
        } else {
          $('#email_idErrorMsg').css("display", "none");
          $(this).text('재전송');
          $('#emailVerification').show();
          sendemail();
          resetTimer();
        }
      });
    });

    function checkemail() {
      let email = "<c:out value='${find.email}'/>";
      let insertKey = $('#emailcheck_id').val();
      if (key === 'expired') {
        $('#emailcheck_idErrorMsg').html("만료된 인증코드입니다").css("display", "block");
        $('#emailcheck_id').focus();
        return;
      }
      if (key === 'asigned') {
        $('#emailcheck_idErrorMsg').html("이미 승인되었습니다").css("display", "block");
        return;
      }
      if (!insertKey) {
        $('#emailcheck_idErrorMsg').html("인증코드를 입력해 주세요").css("display", "block");
        return;
      }
      $.ajax({
        url: '/email/checkMail',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
          email: email,
          insertKey: insertKey,
          key: key
        }),
        success: function (res) {
          if (res === "1") {
            $('#emailcheck_idErrorMsg').css("display", "none");
            alert("인증 성공");
            clearInterval(timerInterval);
            key = 'asigned';
            $("#frmPwFindEmail").submit();
          } else {
            $('#emailcheck_idErrorMsg').html("인증코드가 다릅니다").css("display", "block");
            $('#emailcheck_id').focus();
          }
        },
        error: function (err) {
          $('#emailcheck_idErrorMsg').html("인증 처리 중 오류가 발생했습니다").css("display", "block");
        }
      });
    }

    function sendemail() {
      let email = "<c:out value='${find.email}'/>";
      $.ajax({
        url: '/email/sendMail',
        method: 'POST',
        contentType: 'text/plain',
        data: email,
        success: function (res) {
          alert("인증코드가 발송되었습니다.");
          key = res;
        },
        error: function (err) {
          alert("이메일 전송 중 오류가 발생했습니다.");
        }
      });
    }
  </script>
</head>
<body>
<section class="py-md-0">
  <div class="container">
    <div class="row justify-content-center align-items-center vh-md-100">
      <div class="col-md-10 col-lg-6">
        <div class="card active">
          <div class="card-header" id="headingOne">
            <h6 class="mb-0">
              <p style="color: #68ae68"><strong>Email Verification</strong></p>
            </h6>
          </div>
          <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
            <div class="card-body" style="border : 1px #c2c2c2 solid">
              <div class="form-group">
                <ul class="list-group list-group-minimal mb-2">
                  <li class="list-group-item d-flex justify-content-center align-items-center">
                    <span class="fs-18 mb-0" style="color: #3d733d"><strong>Email</strong></span>
                  </li>
                  <li class="list-group-item d-flex justify-content-center align-items-center">
                    <span class="fs-18 mb-0" style="color: #3d733d" id="email"><strong>${find.email}로</strong></span>
                  </li>
                  <li class="list-group-item d-flex justify-content-center align-items-center">
                    <span class="fs-18 mb-0" style="color: #3d733d"><strong>인증번호를 발송했습니다</strong></span>
                  </li>
                </ul>
              </div>
              <form id="frmPwFindEmail" method="post" action="/pwFindResubmit">
                <div class="form-group">
                  <ul class="list-group list-group-minimal mb-2">
                    <li class="list-group-item d-flex justify-content-center align-items-center">
                      <label for="emailcheck_id" class="col-sm-12 col-form-label"style="color: #3d733d"><strong>인증코드 입력</strong></label>
                    </li>
                    <li class="list-group-item d-flex justify-content-sm-center align-items-center mb-2">
                      <input type="text" class="form-control col-6" id="emailcheck_id" required>
                      <span id='timer2' class="col-3 d-flex justify-content-sm-center align-items-center" style="margin-left: 0px;"></span>
                      <button type="button" class="btn btn-primary btn-rounded pr col-3" id="emailCheck_btn">재전송</button>
                    </li>
                    <li class="list-group-item d-flex justify-content-center align-items-center">
                      <button class="btn btn-block btn-primary col-12" id="submitBtn" type="button">전송</button>
                    </li>
                      <div class="invalid-feedback col-12 d-flex align-items-center justify-content-center" id="emailcheck_idErrorMsg"></div>
                  </ul>
                </div>
              </form>
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
