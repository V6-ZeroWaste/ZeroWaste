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
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <title>soaff sign up</title>
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
    let idRegex = /^[a-zA-Z0-9_-]{3,16}$/;
    let tel1Regex = /^[0-9]{3}$/;
    let tel2Regex = /^[0-9]{3,4}$/;
    let tel3Regex = /^[0-9]{4}$/;
    let emailIdRegex = /^[a-zA-Z0-9._%+-]+$/;
    let emailDomainRegex = /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    let passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;


    function goLogin(event) {
      event.preventDefault();
      isValid = true;
      isValid = fieldCheck();
      if (isValid) {
        let tel = $("#tel1").val()+"-"+$("#tel2").val()+"-"+$("#tel3").val();
        let email = $("#email_id").val()+"@"+$("#email_domain").val();
        $.ajax({
          url: '/signUp',
          method: 'post',
          contentType: "application/json; charset=UTF-8",
          dataType: "json",
          data: JSON.stringify({
            "id": $("#id").val(),
            "pw": $("#pw").val(),
            "name": $("#name").val(),
            "zipcode": $("#zipcode").val(),
            "addr": $("#addr").val(),
            "addr_detail": $("#addr_detail").val(),
            "tel": tel,
            "email" : email
          }),
          async: false,
          success: function (res) {
            if (res === '0') {
              location.href="/signUp"; // 실패
            } else {
              alert("회원가입 성공");
              location.href="/login"; // 성공
            }
          }
        });
      }else{
         $("#id, #pw, #pw_check, #name, #tel1, #tel2, #tel3, #email_id, #email_domain, #zipcode, #addr").on("change", fieldCheck);
      }
    }
      function fieldCheck() {
        var id = $('#id');
        let pw = $('#pw');
        let pw_check = $('#pw_check');
        let name = $('#name');
        let tel1 = $('#tel1');
        let tel2 = $('#tel2');
        let tel3 = $('#tel3');
        let email_id = $('#email_id');
        let email_domain = $('#email_domain');
        let zipcode = $('#zipcode');
        let addr = $('#addr');
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
        if(!idRegex.test(id.val()) && id.val() !== ''){
          idErrorMsg.html("올바른 아이디를 입력해주세요");
          idErrorMsg.css("display", "block");
          isValid = false;
        }

        if (!pw.val()) {
          pwdErrorMsg.html("비밀번호를 입력해주세요");
          pwdErrorMsg.css("display", "block");
          isValid = false;
        }

        if (!pw_check.val()) {
          pwd_checkErrorMsg.html("비밀번호를 입력해 주세요");
          pwd_checkErrorMsg.css("display", "block");
          isValid = false;
        }

        if (pw.val() !== pw_check.val() && pw_check.val() !== '') {
          pwd_checkErrorMsg.html("비밀번호가 일치하지 않습니다");
          pwd_checkErrorMsg.css("display", "block");
          isValid = false;
        }

        if (!passwordRegex.test(pw.val()) && pw.val() !== '') {
          pwdErrorMsg.html("8자리 이상/대문자/소문자/특수문자/숫자가 포함되어야합니다");
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

        if (!tel1Regex.test(tel1.val()) && tel1.val() !== '') {
          tel1ErrorMsg.html("올바른 전화번호를 입력해주세요");
          tel1ErrorMsg.css("display", "block");
          isValid = false;
        }

        if (!tel2Regex.test(tel2.val()) && tel2.val() !== '') {
          tel2ErrorMsg.html("올바른 전화번호를 입력해주세요");
          tel2ErrorMsg.css("display", "block");
          isValid = false;
        }

        if (!tel3Regex.test(tel3.val()) && tel3.val() !== '') {
          tel3ErrorMsg.html("올바른 전화번호를 입력해주세요");
          tel3ErrorMsg.css("display", "block");
          isValid = false;
        }

        if (!email_id.val() || !email_domain.val()) {
          email_idErrorMsg.html("이메일을 입력해주세요");
          email_idErrorMsg.css("display", "block");
          isValid = false;
        }else{
          email_idErrorMsg.css("display", "block").css('display','none');
        }


        if (!emailIdRegex.test(email_id.val()) && email_id.val() !== '') {
          email_idErrorMsg.html("올바른 이메일을 입력해주세요");
          email_idErrorMsg.css("display", "block");
          isValid = false;
        }

        if (!emailDomainRegex.test(email_domain.val()) && email_domain.val() !== '') {
          email_idErrorMsg.html("올바른 이메일을 입력해주세요");
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
        }else{
          zipcodeErrorMsg.css("display", "none");
        }

        if (!addr.val()) {
          addr1ErrorMsg.html("주소를 입력해주세요");
          addr1ErrorMsg.css("display", "block");
          isValid = false;
        }else{
          addr1ErrorMsg.css("display", "none");
        }

        return isValid;
      }

      function idbtnCheck() {
        let isValid = false;
        if(!idRegex.test($("#id").val())){
          idErrorMsg.html("올바른 아이디를 입력해주세요");
          idErrorMsg.css("display", "block");
          let isValid = false;
        }
        if ($('#id').val()) {
          $.ajax({
            url: '/idcheck',
            method: 'post',
            contentType: "application/json; charset=UTF-8",
            dataType: "json",
            data: JSON.stringify({
              "id": $("#id").val(),
            }),
            async: false,
            success: function (res) {
              if (res == '1') {
                $("#idErrorMsg").html("중복된 아이디입니다").css("display", "block");
                isValid = false;
              } else {
                $("#idErrorMsg").html("사용가능한 아이디입니다").css("display", "block");
                isValid = true;
              }
            }
          });
        } else {
          isValid = false;
          $("#idErrorMsg").html("아이디를 먼저 입력해주세요");
          $("#idErrorMsg").css("display", "block");
        }
        return isValid;
      }


      function sendemail() {
        $("#email_id").prop("readonly", true);
        $("#email_domain").prop("readonly", true);
        $('#emailSel').off("change",addEmailSelEvent);
        eventdisable();

        let email = $('#email_id').val() + "@" + $('#email_domain').val();
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
            $("#email_id").prop("readonly", false);
            $("#email_domain").prop("readonly", false);
            eventEnable();
            $('#emailSel').on("change",addEmailSelEvent);


          }
        });
      }


      function checkemail() {
        let email = $('#email_id').val() + "@" + $('#email_domain').val();
        // @RequestBody String key, @RequestBody String insertKey, @RequestBody String email
        let insertKey = $('#emailcheck_id').val();
        isValid = false;
        if (key !== '' && key === 'expired') {
          $('#emailcheck_idErrorMsg').html("만료된 인증코드입니다").css("display", "block");
          $('#emailcheck_id').focus();
          $("#email_id").prop("readonly", false);
          $("#email_domain").prop("readonly", false);
          $('#emailSel').on("change",addEmailSelEvent);
          eventEnable();
        }
        if(key !== '' && key === 'asigned'){
          $('#emailcheck_idErrorMsg').html("이미 승인되었습니다").css("display", "block");
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
                $('#emailcheck_idErrorMsg').css("display", "none");
                alert("인증 성공");
                clearInterval(timerInterval);
                key ='asigned';
              } else {
                $("#email_id").prop("readonly", false);
                $("#email_domain").prop("readonly", false);
                $('#emailSel').on("change",addEmailSelEvent);
                eventEnable();
                if(key == "expired"){
                  $('#emailcheck_idErrorMsg').html("인증코드가 다릅니다").css("display", "block");
                }
                $('#emailcheck_idErrorMsg').html("인증코드가 다릅니다").css("display", "block");
                $('#emailcheck_id').focus();
              }
            },
            error: function (err) {
            }
          });
        }
      }


      function resetTimer() {
        clearInterval(timerInterval);
        startTimer(180);
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
          if (time < 0) {
            clearInterval(timerInterval);
            document.getElementById("timer2").innerHTML = "시간초과";
            key = 'expired';  // 타이머가 끝나면 인증 코드 사라짐
          }
        }, 1000);
      }

    function addEmailSelEvent () {
      var emailSel = $(this).val();
      var email_domain = $("#email_domain");
      if (emailSel !== "직접입력") {
        email_domain.val(emailSel);
        document.getElementById("email_domain").readOnly = true
      } else {
        emailSel = null;
        email_domain.removeAttr("readonly");       // readonly 삭제
      }
    }

    function eventdisable(){
      $('#emailSel option[value="직접입력"]').attr('disabled', 'disabled');
      $('#emailSel option[value="naver.com"]').attr('disabled', 'disabled');
      $('#emailSel option[value="gmail.com"]').attr('disabled', 'disabled');
      $('#emailSel option[value="hanmail.net"]').attr('disabled', 'disabled');
      $('#emailSel option[value="hotmail.com"]').attr('disabled', 'disabled');
      $('#emailSel option[value="korea.com"]').attr('disabled', 'disabled');
      $('#emailSel option[value="nate.com"]').attr('disabled', 'disabled');
      $('#emailSel option[value="yahoo.com"]').attr('disabled', 'disabled');
    }

    function eventEnable() {
      $('#emailSel option[value="직접입력"]').removeAttr('disabled');
      $('#emailSel option[value="naver.com"]').removeAttr('disabled');
      $('#emailSel option[value="gmail.com"]').removeAttr('disabled');
      $('#emailSel option[value="hanmail.net"]').removeAttr('disabled');
      $('#emailSel option[value="hotmail.com"]').removeAttr('disabled');
      $('#emailSel option[value="korea.com"]').removeAttr('disabled');
      $('#emailSel option[value="nate.com"]').removeAttr('disabled');
      $('#emailSel option[value="yahoo.com"]').removeAttr('disabled');
    }

      $(function () {
        //아이디
        $('#id_btn').on('click', function () {
            idbtnClickedCheck = true;
            idbtnCheck();
        });

        $('#id').on('change', function () {
          if (!idRegex.test($('#id').val()) && $('#id').val() !== '') {
            $("#idErrorMsg").html("올바른 아이디를 입력해주세요");
            $("#idErrorMsg").css("display", "block");
            isValid = false;
          }
          idbtnClickedCheck = false;
        });

        //비밀번호
        $('#pw_check').on('input', function () {
          if ($('#pw').val() !== $('#pw_check').val()) {
            $('#pwd_checkErrorMsg').html("비밀번호가 일치하지 않습니다");
            $('#pwd_checkErrorMsg').css("display", "block");
          } else {
            $('#pwd_checkErrorMsg').css("display", "none");
          }
        });

        $('#pw').on('change', function () {
          if (!passwordRegex.test($('#pw').val()) && $('#pw').val() !== '') {
            $('#pwdErrorMsg').html("8자리 이상/대문자/소문자/특수문자/숫자가 포함되어야합니다");
            $('#pwdErrorMsg').css("display", "block");
            isValid = false;
          } else {
            $('#pwdErrorMsg').css("display", "none");
          }
        });

        //이메일
        $('#emailSel').on("change",addEmailSelEvent);



        $('#email_btn').on('click', function () {
          if (!$('#email_id').val() || !$('#email_domain').val()) {
            $('#email_idErrorMsg').html('이메일을 입력해주세요').css("display", "block");
          } else {
            $('#email_idErrorMsg').css("display", "none");
            emailbtnClickedCheck = true;
            $('#email_btnErrorMsg').css("display", "none");
            $(this).text('재전송');
            $('#emailVerification').show();
            sendemail();
            resetTimer();
          }
        });

        //전화번호
        $('#tel3,#tel2,#tel1').on('change', function () {
          if (!tel3Regex.test($('#tel3').val()) && $('#tel3').val() !== '') {
            $('#tel1ErrorMsg').html("올바른 전화번호를 입력해주세요");
            $('#tel1ErrorMsg').css("display", "block");
            isValid = false;
          } else if (!tel1Regex.test($('#tel1').val()) && $('#tel1').val() !== '') {
            $('#tel1ErrorMsg').html("올바른 전화번호를 입력해주세요");
            $('#tel1ErrorMsg').css("display", "block");
            isValid = false;
          } else if (!tel2Regex.test($('#tel2').val()) && $('#tel2').val() !== '') {
            $('#tel1ErrorMsg').html("올바른 전화번호를 입력해주세요");
            $('#tel1ErrorMsg').css("display", "block");
            isValid = false;
          } else {
            $('#tel1ErrorMsg').css("display", "none");
          }
        });

        //주소
        $('#adr_btn').on('click', function () {
          zipcode();
        });

        //이메일
        $('#emailCheck_btn').on('click', function () {
          checkemail();
        });

        $('#email').val($('#email_id').val() + "@" + $('#email_domain').val());
        $('#tel').val($('#tel1').val() + $('#tel2').val() + $('#tel3').val());
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
            $('#addr').val(roadAddr);
          }
        }).open();
      };
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
      font-family : "Open Sans", sans-serif;
      font-size: 18px;
    }
    .form-container {
      display: flex;
      justify-content: center;
    }
    .form-content {
      width: 100%;
      max-width: 80%;
    }
    .btn btn-primary btn-rounded{
      font-size: 16px;
      font-family: "Noto Sans KR", sans-serif;
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
        <h1>Sign UP</h1>
      </div>
    </div>
  </div>
</section>

<section class="pt-5">

  <div class="container form-container">
    <div class="form-content">
<%--      <form action="/user/user/signUp" method="POST" name="frm" id="frm">--%>
        <table class="table">
          <tr>
            <td class="text-center" style="color: #3d733d; width: 30%;"><strong>User ID</strong></td>
            <td colspan="2" class="col-8">
              <input type="text" class="form-control col-6 d-lg-inline-block" id="id" name="id">
              <button type="button" class="btn btn-primary btn-rounded ml-1" id="id_btn">중복확인</button>
              <div class="invalid-feedback" id="idErrorMsg"></div>
            </td>
          </tr>
          <tr>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>Password</strong></td>
            <td colspan="3" class="col-4">
              <input type="password" class="form-control" id="pw" name="pw">
              <div class="invalid-feedback" id="pwdErrorMsg"></div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>Confirm Password</strong></td>
            <td colspan="3" class="col-4">
              <input type="password" class="form-control" id="pw_check">
              <div class="invalid-feedback" id="pwd_checkErrorMsg"></div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>User Name</strong></td>
            <td colspan="3" class="col-4">
              <input type="text" class="form-control" id="name">
              <div class="invalid-feedback" id="nameErrorMsg"></div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>Tel</strong></td>
            <td colspan="3" class="col-4">
              <div class="form-row">
                <div class="col">
                  <input type="number" class="form-control" id="tel1" placeholder="">
                  <div class="invalid-feedback" id="tel1ErrorMsg"></div>
                </div>
                <div class="col">
                  <input type="number" class="form-control" id="tel2" placeholder="">
                  <div class="invalid-feedback" id="tel2ErrorMsg"></div>
                </div>
                <div class="col">
                  <input type="number" class="form-control" id="tel3" placeholder="">
                  <div class="invalid-feedback" id="tel3ErrorMsg"></div>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td class="text-center" style="color: #3d733d;"><strong>Email</strong></td>
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
            <td class="text-center" style="color: #3d733d;"><strong>Address</strong></td>
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
              <input type="text" class="form-control" id="addr" readonly>
              <div class="invalid-feedback" id="addr1ErrorMsg"></div>
            </td>
          </tr>
          <tr>
            <td></td>
            <td colspan="3" class="col-4">
              <input type="text" class="form-control" id="addr_detail">
              <div class="valid-feedback"></div>
            </td>
          </tr>
          <tr>
            <td class="text-center"></td>
            <td colspan="2" class="d-flex align-items-center justify-content-end" style="width: 622.4px;padding: 15px">
              <button type="button" class="btn btn-secondary mr-3" onclick="history.back();">취소</button>
              <button type="button" class="btn btn-primary" onclick="goLogin(event)">확인</button>
            </td>
          </tr>
        </table>
<%--      </form>--%>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
