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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <title>soaff find</title>
  <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
  <script>
    // 전역 변수 선언
    let isValid = true;

    $(function (){
      // 입력 필드 변경 시 유효성 검사
      $("#pwd, #pwd_check").on("input", function (){
        validatePasswords();
      });
    });

    function goResubmit(event) {
      // 폼 방지
      event.preventDefault();
      // 유효성 검사
      validatePasswords();

      if(isValid){
        let pwd_usedErrorMsg = $('#pwd_usedErrorMsg');
        let pw = $('#pwd').val();
        $.ajax({
          url: "/pwNewCheck",
          method: 'POST',
          contentType: 'application/json',
          data: JSON.stringify({
              pw : pw
          }),
          async: false,
          success : function (res){
            if(res == "1")
            {
                // alert("1");
              pwd_usedErrorMsg.html('이미 사용중이신 비밀번호입니다. 새로운 비밀번호를 입력해주세요').css("display","block");
            }else if(res == "2"){
                // alert("2");
              alert("비밀번호 변경 완료");
              location.href="/";
            }else{
                alert("3");
              pwd_usedErrorMsg.html('비밀번호 변경 실패').css("display","block");
            }
          }
        })

      }
    }

    function validatePasswords() {
      let passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
      let pwd = $('#pwd').val();
      let pwd_check = $('#pwd_check').val();
      let pwdErrorMsg = $('#pwdErrorMsg');
      let pwd_checkErrorMsg = $('#pwd_checkErrorMsg');

      isValid = true; // 초기화

      pwdErrorMsg.css("display", "none");
      pwd_checkErrorMsg.css("display", "none");

      if(!pwd){
        pwdErrorMsg.html("비밀번호를 입력해주세요");
        pwdErrorMsg.css("display", "block");
        isValid = false;
      }

      if(!pwd_check){
        pwd_checkErrorMsg.html("비밀번호를 입력해주세요");
        pwd_checkErrorMsg.css("display", "block");
        isValid = false;
      }

      if(pwd && pwd_check && pwd !== pwd_check){
        pwd_checkErrorMsg.html("비밀번호와 일치해야합니다");
        pwd_checkErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!passwordRegex.test(pwd) && pwd !== '') {
        pwdErrorMsg.html("8자리 이상/대문자/소문자/특수문자/숫자가 포함되어야합니다");
        pwdErrorMsg.css("display", "block");
        isValid = false;
      }
    }
  </script>
</head>
<body>
<section class="py-md-0">
    <div class="image image-overlay" style="background-image:url(/user/images/main_test1.png)"></div>
  <div class="container">
    <div class="row justify-content-center align-items-center vh-md-100">
      <div class="col-md-10 col-lg-6">
        <div class="card active">
          <div class="card-header" id="headingOne" style="background-color: #FFFFFF">
            <h6 class="mb-0">
              <p style="color: #68ae68;  font-size: 16px" class="eyebrow"><strong>Change Password</strong></p>
            </h6>
          </div>
          <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample" style="background-color: #FFFFFF">
            <div class="card-body">
<%--              <form method="POST" name="frm" id="frm" class="row mt-2 needs-validation" novalidate>--%>
                <div class="form-group col-12 mb-2">
                  <label for="pwd" style="color: #3d733d; font-size: 14px"><strong>New Password</strong></label>
                  <input type="password" class="form-control" id="pwd" name="pwd" required>
                  <div class="invalid-feedback" id="pwdErrorMsg"></div>
                </div>
                <div class="form-group col-12 mb-2">
                  <label for="pwd_check" style="color: #3d733d; font-size: 14px"><strong>Confirm Password</strong></label>
                  <input type="password" class="form-control" id="pwd_check" name="pwd_check" required>
                  <div class="invalid-feedback" id="pwd_checkErrorMsg"></div>
                </div>
                <div class="col-12 mt-3">
                  <div class="invalid-feedback" id="pwd_usedErrorMsg"></div>
                  <button class="btn btn-block btn-primary" id="btn" onclick="goResubmit(event);" style="font-family: 'Noto Sans KR', sans-serif; font-size: 16px">제출</button>
                </div>
<%--              </form>--%>
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
