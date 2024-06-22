<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
  <link rel="stylesheet" href="/user/css/vendor.css" />
  <link rel="stylesheet" href="/user/css/style.css" />
  <title>soaff</title>
  <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <style>
    input[type=number]::-webkit-outer-spin-button,
    input[type=number]::-webkit-inner-spin-button {
      -webkit-appearance: none;
      margin: 0;
    }
  </style>
  <script>
    let timerInterval;
    let emailbtnClickedCheck = false;
    let idbtnClickedCheck = false;
    let key ='';
    let tel1Regex = /^[0-9]{3}$/;
    let tel2Regex = /^[0-9]{3,4}$/;
    let tel3Regex = /^[0-9]{4}$/;
    let emailIdRegex = /^[a-zA-Z0-9._%+-]+$/;
    let emailDomainRegex = /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    let passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    function goLogin(event) {
      event.preventDefault();
      isValid = true;
      isValid = idbtnCheck();
      // isValid = fieldCheck();
      if (isValid) {
        // $('#frm').submit();
      }
    }

    function fieldCheck() {
      var id = $('#id');
      let pwd = $('#pwd');
      let pwd_check = $('#pwd_check');
      let name = $('#name');
      let tel1 = $('#tel1');
      let tel2 = $('#tel2');
      let tel3 = $('#tel3');
      let email_id = $('#email_id');
      let email_domain = $('#email_domain');
      let zipcode = $('#zipcode');
      let addr1 = $('#addr1');
      let emailcheck_id = $('#emailcheck_id');

      let idErrorMsg = $('#idErrorMsg');
      let pwdErrorMsg = $('#pwdErrorMsg');
      let pwd_checkErrorMsg = $('#pwd_checkErrorMsg');
      let nameErrorMsg = $('#nameErrorMsg');
      let tel1ErrorMsg = $('#tel1ErrorMsg');
      let tel2ErrorMsg = $('#tel2ErrorMsg');
      let tel3ErrorMsg = $('#tel3ErrorMsg');
      let email_idErrorMsg = $('#email_idErrorMsg');
      let email_domainErrorMsg = $('#email_domainErrorMsg');
      let zipcodeErrorMsg = $('#zipcodeErrorMsg');
      let addr1ErrorMsg = $('#addr1ErrorMsg');
      let emailcheck_idErrorMsg = $('#emailcheck_idErrorMsg');
      let email_btnErrorMsg = $('#email_btnErrorMsg');

      idErrorMsg.css("display", "none");
      pwdErrorMsg.css("display", "none");
      pwd_checkErrorMsg.css("display", "none");
      nameErrorMsg.css("display", "none");
      tel1ErrorMsg.css("display", "none");
      tel2ErrorMsg.css("display", "none");
      tel3ErrorMsg.css("display", "none");
      email_idErrorMsg.css("display", "none");
      email_domainErrorMsg.css("display", "none");
      zipcodeErrorMsg.css("display", "none");
      addr1ErrorMsg.css("display", "none");
      emailcheck_idErrorMsg.css("display", "none");
      email_btnErrorMsg.css("display", "none");

      let isValid = true;

      if (!id.val()) {
        idErrorMsg.html("아이디를 입력해주세요");
        idErrorMsg.css("display", "block");
        isValid = false;
      } else if (!idbtnClickedCheck) {
        idErrorMsg.html("중복확인 버튼을 눌러주세요");
        idErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!pwd.val()) {
        pwdErrorMsg.html("비밀번호를 입력해주세요");
        pwdErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!pwd_check.val()) {
        pwd_checkErrorMsg.html("비밀번호를 입력해 주세요");
        pwd_checkErrorMsg.css("display", "block");
        isValid = false;
      }

      if (pwd.val() !== pwd_check.val() && pwd_check.val() !== '') {
        pwd_checkErrorMsg.html("비밀번호가 일치하지 않습니다");
        pwd_checkErrorMsg.css("display", "block");
        isValid = false;
      }

      if(!passwordRegex.test(pwd.val()) && pwd.val() !==''){
        pwdErrorMsg.html("8자리 이상/대문자/소문자/특수문자/숫자가 포함됩니다");
        pwdErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!name.val()) {
        nameErrorMsg.html("이름을 입력해 주세요");
        nameErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!tel1.val()) {
        tel1ErrorMsg.html("전화번호를 입력해주세요");
        tel1ErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!tel2.val()) {
        tel1ErrorMsg.html("전화번호를 입력해주세요");
        tel1ErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!tel3.val()) {
        tel1ErrorMsg.html("전화번호를 입력해주세요");
        tel1ErrorMsg.css("display", "block");
        isValid = false;
      }

      if(!tel1Regex.test(tel1.val()) && tel1.val() !==''){
        tel1ErrorMsg.html("올바른 전화번호를 입력해주세요");
        tel1ErrorMsg.css("display", "block");
        isValid = false;
      }

      if(!tel2Regex.test(tel2.val()) && tel2.val() !== ''){
        tel2ErrorMsg.html("올바른 전화번호를 입력해주세요");
        tel2ErrorMsg.css("display", "block");
        isValid = false;
      }

      if(!tel3Regex.test(tel3.val()) && tel3.val() !== ''){
        tel3ErrorMsg.html("올바른 전화번호를 입력해주세요");
        tel3ErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!email_id.val()) {
        email_idErrorMsg.html("이메일을 입력해주세요");
        email_idErrorMsg.css("display", "block");
        isValid = false;
      }

      if(!emailIdRegex.test(email_id.val()) && email_id.val() !== '' ) {
        email_idErrorMsg.html("올바른 이메일을 입력해주세요");
        email_idErrorMsg.css("display", "block");
        isValid = false;
      }

      if(!emailDomainRegex.test(email_domain.val()) && email_domain.val() !== '' ) {
        email_idErrorMsg.html("올바른 이메일을 입력해주세요");
        email_idErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!email_domain.val()) {
        email_idErrorMsg.html("이메일을 입력해주세요");
        email_idErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!emailcheck_id.val()) {
        emailcheck_idErrorMsg.html("인증을 해주세요");
        emailcheck_idErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!emailbtnClickedCheck) {
        email_btnErrorMsg.html("버튼을 눌러주세요");
        email_btnErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!zipcode.val()) {
        zipcodeErrorMsg.html("우편번호를 입력해주세요");
        zipcodeErrorMsg.css("display", "block");
        isValid = false;
      }

      if (!addr1.val()) {
        addr1ErrorMsg.html("주소를 입력해주세요");
        addr1ErrorMsg.css("display", "block");
        isValid = false;
      }

      return isValid;
    }

    function idbtnCheck() {
      let isValid = false;
      if($('#id').val())
      {
        $.ajax({
          url: '/user/user/idcheck',
          method: 'post',
          contentType: "application/json; charset=UTF-8",
          dataType: "json",
          data: JSON.stringify({
            "id": $("#id").val(),
          }),
          async: false,
          success: function(res) {
            if (res == '1') {
              $("#idErrorMsg").html("중복된 아이디입니다").css("display", "block");
              isValid = false;
              console.log(res);
            } else {
              $("#idErrorMsg").css("display", "none");
              console.log(res);
              isValid = true;
            }
          }
        });
      }
      else {
        isValid = false;
        $("#idErrorMsg").html("아이디를 먼저 입력해주세요");
        $("#idErrorMsg").css("display", "block");
      }
      return isValid;
    }


    function sendVerificationCode() {
      let email = $('#email_id').val() + "@" + $('#email_domain').val();
      $.ajax({
        url: '/email/sendMail',
        method: 'POST',
        contentType: 'text/plain',
        data: email,
        success: function(res) {
          alert("인증코드가 발송되었습니다.");
           key= res;
        },
        error: function(err) {
          alert("이메일 전송 중 오류가 발생했습니다.");
          console.log(email);
        }
      });
    }


    function checkVerificationCode() {
      let email = $('#email_id').val() + "@" + $('#email_domain').val();
      //@RequestBody String key, @RequestBody String insertKey, @RequestBody String email
      let insertKey = $('#emailcheck_id').val();
      isValid = false;
      console.log(email)
      console.log(insertKey)
      console.log(key + 'ssdsd')
      if(key ===''){
        $('#emailcheck_idErrorMsg').html("만료된 인증코드입니다").css("display", "block");
        $('#emailcheck_id').focus();
      }
      else {
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
              alert("인증 성공");
            } else {
              $('#emailcheck_idErrorMsg').html("인증코드가 다릅니다").css("display", "block");
              $('#emailcheck_id').focus();
            }
          },
          error: function (err) {
            console.log(res);
          }
        });
      }
    }


    function resetTimer() {
      clearInterval(timerInterval);
      startTimer(30);
    }

    function startTimer(duration) {
      let time = duration;
      let min = "";
      let sec = "";

      timerInterval = setInterval(function () {
        min = parseInt(time / 60);
        sec = time % 60;

        document.getElementById("timer2").innerHTML = min + "분 " + sec + "초";
        time--;
        console.log(key);
        if (time < 0) {
          clearInterval(timerInterval);
          document.getElementById("timer2").innerHTML = "시간초과";
          key = '';  // 타이머가 끝나면 인증 코드 사라짐
          console.log("만료됐어~~~")
          console.log(key);
          console.log(key);
          console.log(key);
          $('#email_btnErrorMsg').html("재전송을 눌러주세요").css("display", "block");
        }
      }, 1000);
    }

    $(function() {
      $("#id, #pwd, #pwd_check, #name, #tel1, #tel2, #tel3, #email_id, #email_domain, #zipcode, #addr1").on("change", fieldCheck);

      $('#pwd_check').on('input', function () {
        if ($('#pwd').val() !== $('#pwd_check').val()) {
          $('#pwd_checkErrorMsg').html("비밀번호가 일치하지 않습니다");
          $('#pwd_checkErrorMsg').css("display", "block");
        } else {
          $('#pwd_checkErrorMsg').css("display", "none");
        }
      });
        $('#emailSel').change(function () {
          var emailSel = $(this).val();
          console.log(emailSel);
          var email_domain = $("#email_domain");
          if (emailSel !== "직접입력") {
            email_domain.val(emailSel);
            document.getElementById("email_domain").readOnly = true
          }else{
            emailSel = null;
            email_domain.removeAttr("readonly");       // readonly 삭제
          }

        });

      $('#email_btn').on('click', function() {
        emailbtnClickedCheck = true;
        $(this).text('재전송');
        $('#emailVerification').show();
        sendVerificationCode();
        resetTimer();
      });

      $('#adr_btn').on('click', function() {
        zipcode();
      });

      $('#emailCheck_btn').on('click', function() {
        checkVerificationCode();
      });

      $('#id_btn').on('click', function () {
        idbtnClickedCheck = true;
        idbtnCheck();
      });

      $('#relEmail').val($('#email_id').val() + "@" + $('#email_domain').val());
      $('#relTel').val($('#tel1').val() + $('#tel2').val() + $('#tel3').val());
      $('#relAdd').val($('#addr1').val() + $('#addr2').val());
    });

    function zipcode() {
      new daum.Postcode({
        oncomplete: function (data) {
          var roadAddr = data.roadAddress;
          var extraRoadAddr = '';

          if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
            extraRoadAddr += data.bname;
          }
          if (data.buildingName !== '' && data.apartment === 'Y') {
            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          if (extraRoadAddr !== '') {
            extraRoadAddr = ' (' + extraRoadAddr + ')';
          }

          $('#zipcode').val(data.zonecode);
          $('#addr1').val(roadAddr);
        }
      }).open();
    }
  </script>
  <style>
    .table {
      table-layout: fixed;
    }
    .table td, .table th {
      border-top: none;
      vertical-align: middle;
      padding: 0.5rem;
    }
    .text-center {
      text-align: center;
      padding-right: 0.5rem;
    }
    .form-container {
      display: flex;
      justify-content: center;
    }
    .form-content {
      width: 100%;
      max-width: 80%;
    }
  </style>
</head>
<body>
<br>
<br>
<br>
<section>
  <div class="container">
    <div class="row">
      <div class="col text-center">
        <h1>Sign In</h1>
      </div>
    </div>
  </div>
</section>

<section class="pt-5">
  <div class="container form-container">
    <div class="form-content">
      <form action="/user/join" method="POST" name="frm" id="frm">
        <table class="table">
          <tr>
            <td class="text-center" style="color: #3d733d; width: 30%;"><strong>아이디</strong></td>
            <td colspan="2" class="col-8">
              <input type="text" class="form-control col-6 d-lg-inline-block" id="id" name="id">
              <button type="button" class="btn btn-primary btn-rounded ml-1" id="id_btn">중복확인</button>
              <div class="invalid-feedback" id="idErrorMsg"></div>
            </td>
          </tr>
          <tr>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>비밀번호</strong></td>
            <td colspan="3" class="col-4">
              <input type="password" class="form-control" id="pwd">
              <div class="invalid-feedback" id="pwdErrorMsg"></div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>비밀번호 확인</strong></td>
            <td colspan="3" class="col-4">
              <input type="password" class="form-control" id="pwd_check">
              <div class="invalid-feedback" id="pwd_checkErrorMsg"></div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>이름</strong></td>
            <td colspan="3" class="col-4">
              <input type="text" class="form-control" id="name">
              <div class="invalid-feedback" id="nameErrorMsg"></div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>전화번호</strong></td>
            <td colspan="3" class="col-4">
              <div class="form-row">
                <div class="col">
                  <input type="number" class="form-control" id="tel1" placeholder="010">
                  <div class="invalid-feedback" id="tel1ErrorMsg"></div>
                </div>
                <div class="col">
                  <input type="number" class="form-control" id="tel2" placeholder="1234">
                  <div class="invalid-feedback" id="tel2ErrorMsg"></div>
                </div>
                <div class="col">
                  <input type="number" class="form-control" id="tel3" placeholder="5678">
                  <div class="invalid-feedback" id="tel3ErrorMsg"></div>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>이메일</strong></td>
            <td colspan="3" class="col-4">
              <div class="form-row">
                <div class="col">
                  <input type="text" class="form-control" id="email_id" placeholder="" aria-label="이메일입력">
                  <div class="invalid-feedback" id="email_idErrorMsg"></div>
                </div>
                <span class="col-form-label p-0 d-flex justify-content-center align-items-center" style="height:53px;">&nbsp;&nbsp;@&nbsp;&nbsp;</span>
                <div class="col">
                  <input type="text" class="form-control" id="email_domain" placeholder="" aria-label="도메인이름">
                  <div class="invalid-feedback" id="email_domainErrorMsg"></div>
                </div>
                <div class="col">
                  <select id="emailSel" class="custom-select">
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
                <div class="col">
                  <button type="button" class="btn btn-primary btn-rounded " id="email_btn">인증코드</button>
                  <div class="invalid-feedback" id="email_btnErrorMsg"></div>
                </div>
              </div>
            </td>
          </tr>
          <tr id="emailVerification" style="display: none;">
            <td class="text-center" style="color: #3d733d;"><strong>인증코드 입력</strong></td>
            <td colspan="3" class="col-4">
              <div class="form-row">
                <div class="col">
                  <input type="text" class="form-control" id="emailcheck_id">
                  <div class="invalid-feedback" id="emailcheck_idErrorMsg"></div>
                </div>
                <div class="col d-flex justify-content-center align-items-center" style="height:53px;">
                  <span id='timer2'></span>
                </div>
                <div class="col">
                  <button type="button" class="btn btn-primary btn-rounded" id="emailCheck_btn">인증확인</button>
                </div>
                <div class="col"></div>
              </div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>주소</strong></td>
            <td colspan="3" class="col-4">
              <div class="form-row">
                <div class="col">
                  <input type="text" class="form-control" id="zipcode" readonly>
                  <div class="invalid-feedback" id="zipcodeErrorMsg"></div>
                </div>
                <div class="col">
                  <button type="button" class="btn btn-primary btn-rounded" id="adr_btn">우편번호</button>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td></td>
            <td colspan="3" class="col-4">
              <input type="text" class="form-control" id="addr1" readonly>
              <div class="invalid-feedback" id="addr1ErrorMsg"></div>
            </td>
          </tr>
          <tr>
            <td></td>
            <td colspan="3" class="col-4">
              <input type="text" class="form-control" id="addr2">
              <div class="valid-feedback"></div>
            </td>
          </tr>
          <tr>
            <td class="text-center"></td>
            <td></td>
            <td colspan="2">
              <button type="button" class="btn btn-primary" onclick="history.back();">취소</button>
              <button type="button" class="btn btn-primary" onclick="goLogin(event)">확인</button>
            </td>
          </tr>
        </table>
        <input type="hidden" id="relEmail" name="relEmail">
        <input type="hidden" id="relTel" name="relTel">
        <input type="hidden" id="relAdd" name="relAdd">
      </form>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
