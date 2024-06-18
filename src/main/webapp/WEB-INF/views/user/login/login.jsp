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
</head>
<script>
  let timerInterval;
  let emailbtnClickedCheck = false;
  let idbtnClickedCheck = false;
  let verificationCode = '';
  let tel1Regex = /^[0-9]{3}$/;
  let tel2Regex = /^[0-9]{3,4}$/;
  let tel3Regex = /^[0-9]{4}$/;
  let emailIdRegex = /^[a-zA-Z0-9._%+-]+$/;
  let emailDomainRegex = /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  let passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

  function goLogin() {
    if (fieldCheck()) {
      $('#frm').submit();
    }
  }

  function fieldCheck() {
    let id = $('#id');
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
    let email_btn = $('#email_btn');

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
      id.focus();
      isValid = false;
    } else if (!idbtnClickedCheck) {
      idErrorMsg.html("중복확인 버튼을 눌러주세요");
      idErrorMsg.css("display", "block");
      id.focus();
      isValid = false;
    } else if (!idbtnCheck()) {
      idErrorMsg.html("아이디가 중복 되었습니다");
      idErrorMsg.css("display", "block");
      id.focus();
      isValid = false;
    }

    if (!pwd.val()) {
      pwdErrorMsg.html("비밀번호를 입력해주세요");
      pwdErrorMsg.css("display", "block");
      pwd.focus();
      isValid = false;
    }

    if (!pwd_check.val()) {
      pwd_checkErrorMsg.html("비밀번호를 입력해 주세요");
      pwd_checkErrorMsg.css("display", "block");
      pwd_check.focus();
      isValid = false;
    }
    pwd_check.on('input',function (){
    if (pwd_check.val() !== pwd.val() && !pwd.val() !=='') {
      pwd_checkErrorMsg.html("비밀번호가 일치하지 않습니다");
      pwd_checkErrorMsg.css("display", "block");
      pwd_check.focus();
      isValid = false;
    }
    });

    if(!passwordRegex.test(pwd.val()) && pwd.val() !==''){
      pwdErrorMsg.html("8자리 이상/대문자/소문자/특주문자/숫자가 포함됩니다");
      pwdErrorMsg.css("display", "block");
      pwd.focus();
      isValid = false;
    }

    if (!name.val()) {
      nameErrorMsg.html("이름을 입력해 주세요");
      nameErrorMsg.css("display", "block");
      name.focus();
      isValid = false;
    }

    if (!tel1.val()) {
      tel1ErrorMsg.html("전화번호를 입력해주세요");
      tel1ErrorMsg.css("display", "block");
      tel1.focus();
      isValid = false;
    }

    if (!tel2.val()) {
      tel2ErrorMsg.html("전화번호를 입력해주세요");
      tel2ErrorMsg.css("display", "block");
      tel2.focus();
      isValid = false;
    }

    if (!tel3.val()) {
      tel3ErrorMsg.html("전화번호를 입력해주세요");
      tel3ErrorMsg.css("display", "block");
      tel3.focus();
      isValid = false;
    }

    if(!tel1Regex.test(tel1.val()) && tel1.val() !==''){
      tel1ErrorMsg.html("올바른 전화번호를 입력해주세요");
      tel1ErrorMsg.css("display", "block");
      tel1.focus();
      isValid = false;
    }

    if(!tel2Regex.test(tel2.val()) && tel2.val() !== ''){
      tel2ErrorMsg.html("올바른 전화번호를 입력해주세요");
      tel2ErrorMsg.css("display", "block");
      tel2.focus();
      isValid = false;
    }

    if(!tel3Regex.test(tel3.val()) && tel3.val() !== ''){
      tel3ErrorMsg.html("올바른 전화번호를 입력해주세요");
      tel3ErrorMsg.css("display", "block");
      tel3.focus();
      isValid = false;
    }

    if (!email_id.val()) {
      email_idErrorMsg.html("이메일을 입력해주세요");
      email_idErrorMsg.css("display", "block");
      email_id.focus();
      isValid = false;
    }

    if(!emailIdRegex.test(email_id.val()) && email_id.val() !== '' ) {
      email_id.html("올바른 이메일을 입력해주세요");
      email_id.css("display", "block");
      email_id.focus();
      isValid = false;
    }

    if(!emailDomainRegex.test(email_domain.val()) && email_domain.val() !== '' ) {
      email_domain.html("올바른 도메인을 입력해주세요");
      email_domain.css("display", "block");
      email_domain.focus();
      isValid = false;
    }

    if (!email_domain.val()) {
      email_domainErrorMsg.html("도메인을 입력해주세요");
      email_domainErrorMsg.css("display", "block");
      email_domain.focus();
      isValid = false;
    }

    if (!emailcheck_id.val()) {
      emailcheck_idErrorMsg.html("인증코드를 입력해주세요");
      emailcheck_idErrorMsg.css("display", "block");
      emailcheck_id.focus();
      isValid = false;
    } else if (emailcheck_id.val() !== verificationCode) {
      emailcheck_idErrorMsg.html("인증코드가 다릅니다");
      emailcheck_idErrorMsg.css("display", "block");
      emailcheck_id.focus();
      isValid = false;
    }

    if (!emailbtnClickedCheck) {
      email_btnErrorMsg.html("인증코드 버튼을 눌러주세요");
      email_btnErrorMsg.css("display", "block");
      emailcheck_id.focus();
      isValid = false;
    }

    if (!zipcode.val()) {
      zipcodeErrorMsg.html("주소를 입력해주세요");
      zipcodeErrorMsg.css("display", "block");
      zipcode.focus();
      isValid = false;
    }

    if (!addr1.val()) {
      addr1ErrorMsg.html("주소를 입력해주세요");
      addr1ErrorMsg.css("display", "block");
      addr1.focus();
      isValid = false;
    }



    return isValid;
  }

  // 아이디 중복 확인
  function idbtnCheck() {
    let isValid = false;
    $.ajax({
      url: '/user/join/idCheck.do',
      data: {id: $("#id").val()},
      async: false,
      success: function (res) {
        if (res == '1') {
          $("#idErrorMsg").html("중복된 아이디입니다").css("display", "block");
          isValid = false;
        } else {
          $("#idErrorMsg").css("display", "none");
          isValid = true;
        }
      }
    });
    return isValid;
  }

  // 이메일 인증코드 부분
  function sendVerificationCode() {
    let email = $('#email_id').val() + "@" + $('#email_domain').val();
    $.ajax({
      url: '/sendVerificationCode',
      method: 'POST',
      data: {email: email},
      success: function (res) {
        verificationCode = res.verificationCode;
        alert("인증코드가 발송되었습니다.");
      }
    });
  }

  //재시작 타이머
  function resetTimer() {
    clearInterval(timerInterval);
    startTimer(180);
  }
  //타이머
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
        verificationCode = '';  // 타이머가 끝나면 인증 코드 무효화
      }
    }, 1000);
  }

  $(document).ready(function() {
    $("#id, #pwd, #pwd_check, #name, #tel1, #tel2, #tel3, #email_id, #email_domain, #zipcode, #addr1").on("change", fieldCheck);

    //이메일 도메인 값 선택 반영
    $('#emailSel').change(function () {
      var emailSel = $(this).val();
      var email_domain = $("#email_domain");
      if (emailSel === '직접입력') {
        emailSel = null;
        email_domain.attr('readonly', false);
      }
      email_domain.val(emailSel);
    });

    //이메일 재전송 클릭
    $('#email_btn').on('click', function() {
      emailbtnClickedCheck = true;
      $(this).text('재전송');
      $('#emailVerification').show();
      sendVerificationCode();
      resetTimer();
    });

    //우편주소 클릭
    $('#adr_btn').on('click', function() {
      zipcode();
    });

    //이메일 인증 성공
    $('#emailCheck_btn').on('click', function() {
      if ($('#emailcheck_id').val() === verificationCode) {
        alert("인증 성공");
      } else {
        $('#emailcheck_idErrorMsg').html("인증코드가 다릅니다").css("display", "block");
        $('#emailcheck_id').focus();
      }
    });

    //아이디 버튼 클릭했는지 안 했는지
    $('#id_btn').on('click', function () {
      idbtnClickedCheck = true;
      idbtnCheck();
    });

    //이메일 , 전화번호. 주소 다 합쳐서 보냄
    $('#relEmail').val($('#email_id').val() + "@" + $('#email_domain').val());
    $('#relTel').val($('#tel1').val() + $('#tel2').val() + $('#tel3').val());
    $('#relAdd').val($('#addr1').val() + $('#addr2').val());
  });

  //우편주소 api
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
<body>
<!-- breadcrumbs -->
<section class="breadcrumbs separator-bottom">
  <div class="container">
    <div class="row">
      <div class="col">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item"><a href="listing-sidebar.html">Shop</a></li>
            <li class="breadcrumb-item active" aria-current="page">Checkout</li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</section>

<!-- hero -->
<section>
  <div class="container">
    <div class="row">
      <div class="col text-center">
        <h1>Sign In</h1>
      </div>
    </div>
  </div>
</section>

<!-- listing -->
<section class="pt-5">
  <div class="container">
    <div class="row">
      <div class="col col-lg-2">
      </div>
      <!-- content -->
      <div class="col col-lg-10">
        <form action="/user/join" method="POST" name="frm" id="frm">

          <%--아이디 기입을 하지 않은경우--%>
          <div class="row mb-3">
            <label for="id" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>아이디</strong></label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="id" name="id" >
              <div class="invalid-feedback" id="idErrorMsg"></div>
            </div>
            <div class="col-sm-2">
              <button type="button" class="btn btn-primary btn-rounded" id="id_btn">중복확인</button>
            </div>
          </div>

          <div class="row mb-3" style="margin-bottom: 0;">
            <label for="pwd" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>비밀번호</strong></label>
            <div class="col-sm-6">
              <input type="password" class="form-control" id="pwd" >
              <div class="invalid-feedback" id="pwdErrorMsg"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="pwd_check" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>비밀번호 확인</strong></label>
            <div class="col-sm-6">
              <input type="password" class="form-control" id="pwd_check" >
              <div class="invalid-feedback" id="pwd_checkErrorMsg"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="name" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>이름</strong></label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="name" >
              <div class="invalid-feedback" id="nameErrorMsg"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label class="col-sm-2 col-form-label" style="color: #3d733d"><strong>전화번호</strong></label>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel1" placeholder="010" >
              <div class="invalid-feedback" id="tel1ErrorMsg"></div>
            </div>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel2" placeholder="1234">
              <div class="invalid-feedback" id="tel2ErrorMsg"></div>
            </div>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel3" placeholder="5678" >
              <div class="invalid-feedback" id="tel3ErrorMsg"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="email_id" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>이메일</strong></label>
            <div class="col-sm-2 pr-0">
              <input type="text" class="form-control" id="email_id" placeholder="이메일" aria-label="이메일입력">
              <div class="invalid-feedback" id="email_idErrorMsg"></div>
            </div>
            <span class="col-form-label p-0">&nbsp;&nbsp;@&nbsp;&nbsp;</span>
            <div class="col-2 pr-0 pl-0">
              <input type="text" class="form-control" id="email_domain" placeholder="도메인이름" aria-label="도메인이름" readonly >
              <div class="invalid-feedback" id="email_domainErrorMsg"></div>
            </div>
            <div class="col-2" style="padding-right: 30px; padding-left: 0">
              <div class="form-group mb-1">
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
            </div>

            <div class="col-sm-3" style="padding-left: 0px">
              <button type="button" class="btn btn-primary btn-rounded" id="email_btn">인증코드</button>
              <div class="invalid-feedback" id="email_btnErrorMsg"></div>
            </div>
          </div>
          <div class="row mb-3" id="emailVerification" style="display: none;">
            <label for="emailcheck_id" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>인증코드 입력</strong></label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="emailcheck_id" >
              <div class="invalid-feedback" id="emailcheck_idErrorMsg"></div>
            </div>
            <div class="form-group col-1 d-flex justify-content-sm-center align-items-center" style="padding-right: 15px; padding-left: 0">
              <span id='timer2'></span>
            </div>

            <div class="col-sm-2">
              <button type="button" class="btn btn-primary btn-rounded" id="emailCheck_btn" >인증확인</button>
            </div>
          </div>

          <div class="row mb-3">
            <label for="zipcode" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>주소</strong></label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="zipcode" readonly >
              <div class="invalid-feedback" id="zipcodeErrorMsg"></div>
            </div>
            <div class="col-sm-2">
              <button type="button" class="btn btn-primary btn-rounded" id="adr_btn" >우편번호</button>
            </div>
          </div>
          <div class="row mb-3">
            <label for="addr1" class="col-sm-2 col-form-label"></label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="addr1" readonly >
              <div class="invalid-feedback" id="addr1ErrorMSg"></div>
            </div>
          </div>
          <div class="row mb-3">
            <label for="addr2" class="col-sm-2 col-form-label"></label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="addr2">
              <div class="valid-feedback" ></div>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-2">
              <button type="button" class="btn btn-primary" onclick="history.back();">취소</button>
            </div>
            <div class="col-sm-2">
              <button type="button" class="btn btn-primary" onclick="goLogin()">확인</button>
            </div>
          </div>
          <input type="hidden" id="relEmail" name="relEmail">
          <input type="hidden" id="relTel" name="relTel">
          <input type="hidden" id="relAdd" name="relAdd">
        </form>
      </div>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
