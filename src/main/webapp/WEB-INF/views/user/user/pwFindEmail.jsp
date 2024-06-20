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

        document.getElementById("timer2").innerHTML = min + "분 " + sec + "초";
        time--;

        if (time < 0) {
          clearInterval(timerInterval);
          document.getElementById("timer2").innerHTML = "시간초과";
        }
      }, 1000);
    }

    function resetTimer() {
      clearInterval(timerInterval);
      startTimer(180);
    }

    window.onload = function (){
      startTimer(180);
    };

    $(function() {
      $('#emailCheck_btn').on('click', function() {
        resetTimer(); // 타이머를 재시작합니다.
        $('#emailVerification').show();
      });

      $('#submitBtn').on('click', function() {
        validateEmailCode();
      });
    });

    function validateEmailCode() {
      let emailCode = $('#emailcheck_id').val();
      let errorMsg = $('#pwFindEmailSubmitErrorMsg');
      errorMsg.css("display", "none");

      if (!emailCode) {
        errorMsg.html("인증코드를 입력해 주세요");
        errorMsg.css("display", "block");
        return;
      }

      $.ajax({
        type: 'POST',
        url: '/user/login/verifyEmailCode',
        data: { code: emailCode },
        success: function(res) {
          if (res == '0') {
            errorMsg.html("인증코드가 일치하지 않습니다");
            errorMsg.css("display", "block");
          } else {
            // Handle success scenario (e.g., navigate to the next page or show success message)
            window.location.href = '/nextPage'; // replace with your actual success action
          }
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
              <form>
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
                      <button class="btn btn-block btn-primary" id="submitBtn" type="button">확인</button>
                      <div class="invalid-feedback" id="pwFindEmailSubmitErrorMsg"></div>
                    </li>
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
