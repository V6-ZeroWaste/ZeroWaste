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
  <title>soaff</title>
  <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<script>

  function goPay() {
    if (fieldCheck()) {
      location.href = "/order/success";
    }

  }


  function fieldCheck() {
    let id =$('#id');
    let pwd =$('#pwd');
    let pwd_check = $('#pwd_check');
    let name =$('#name');
    let tel1 =$('#tel1');
    let tel2 =$('#tel2');
    let tel3 =$('#tel3');
    let email_id =$('#email_id');
    let email_domain = $('#email_domain');
    let zipcode =$('#zipcode');
    let addr1 =$('#addr1');


    let idErrorMsg = $('#idErrorMsg');
    let pwdErrorMsg =$('#pwdErrorMsg');
    let pwd_checkErrorMsg = $('#pwd_checkErrorMsg');
    let nameErrorMsg = $('#nameErrorMsg');
    let tel1ErrorMsg = $('#tel1ErrorMsg');
    let tel2ErrorMsg = $('#tel2ErrorMsg');
    let tel3ErrorMsg = $('#tel3ErrorMsg');
    let email_idErrorMsg = $('#email_idErrorMsg');
    let email_domainErrorMsg = $('#email_domainErrorMsg');
    let zipcodeErrorMsg = $('#zipcodeErrorMsg');
    let addr1ErrorMsg = $('#addr1ErrorMsg');

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


    let isValid = true;

    if (!id.val()) {
      idErrorMsg.html("아이디를 입력해주세요");
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
    if (!email_id.val()) {
      email_idErrorMsg.html("이메일을 입력해주세요");
      email_idErrorMsg.css("display", "block");
      email_id.focus();
      isValid = false;
    }
    if (!email_domain.val()) {
      email_domainErrorMsg.html("이메일 도메인을 입력해주세요");
      email_domainErrorMsg.css("display", "block");
      email_domain.focus();
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

  window.onload = function () {
    $("#id, #pwd, #pwd_check, #name, #tel1, #tel2, #tel3, #email_id, #email_domain,#zipcode,#addr1").on("change", fieldCheck);

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

    $('#adr_btn').on('click', () => {
      zipcode();
    });

    $('#email_btn').on('click', function() {
      var email_btn = document.getElementById('email_btn');
      email_btn.innerHTML='재전송';
      $('#emailVerification').show();
    });
  };
</script>
<script type="text/javascript">
  $(function() {
    id_btn.addEventListener('click', function() {
      console.log(con);
      var idBtnError = document.getElementById('idBtnError');
      // $.ajax({
      //   url:'/user/join/idCheck.do',
      //   data : {id:$("#id").val()},
      //   async : false,
      //   success : function(res) {
      //     console.log(res);
      //     if (res == '1') {
      //       id.setCustomValidity(idBtnError.innerHTML='중복된 아이디입니다');
      //     }
      //     else{
      //       idBtnError.setCustomValidity('');
      //       con = false;
      //     }
      //   }
      // });
    });

    $('#relEmail').val($('#email_id').val() + "@" + $('#email_domain').val());
    $('#relTel').val($('#tel1').val() + $('#tel2').val() + $('#tel3').val());
    $('#relAdd').val($('#addr1').val() + $('#addr2').val());

    // 본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function zipcode() {
      new daum.Postcode({
        oncomplete: function (data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
          var roadAddr = data.roadAddress; // 도로명 주소 변수
          var extraRoadAddr = ''; // 참고 항목 변수

          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
            extraRoadAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if (data.buildingName !== '' && data.apartment === 'Y') {
            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          if (extraRoadAddr !== '') {
            extraRoadAddr = ' (' + extraRoadAddr + ')';
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          $('#zipcode').val(data.zonecode);
          $('#addr1').val(roadAddr);
        }
      }).open();
    }

  });
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
              <div class="valid-feedback"></div>
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
              <div class="valid-feedback" ></div>
              <div class="invalid-feedback" id="pwdErrorMsg"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="pwd_check" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>비밀번호 확인</strong></label>
            <div class="col-sm-6">
              <input type="password" class="form-control" id="pwd_check" >
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="pwd_checkErrorMsg"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="name" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>이름</strong></label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="name" >
              <div class="valid-feedback">사용가능한 이름입니다</div>
              <div class="invalid-feedback" id="nameErrorMsg"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label class="col-sm-2 col-form-label" style="color: #3d733d"><strong>전화번호</strong></label>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel1" placeholder="010" >
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="tel1ErrorMsg"></div>
            </div>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel2" placeholder="1234">
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="tel2ErrorMsg"></div>
            </div>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel3" placeholder="5678" >
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="tel3ErrorMsg"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="email_id" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>이메일</strong></label>
            <div class="col-sm-2" style="padding-right: 0">
              <input type="text" class="form-control" id="email_id" placeholder="이메일" aria-label="이메일입력">
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="email_idErrorMsg"></div>
            </div>
            <span class="col-form-label">@</span>
            <div class="col-sm-2" style="padding-right: 0; padding-left: 0">
              <input type="text" class="form-control" id="email_domain" placeholder="도메인이름" aria-label="도메인이름" readonly >
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="email_domainErrorMsg"></div>
            </div>
            <div class="col-sm-2" style="padding-right: 30px; padding-left: 0">
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
            </div>
          </div>
          <div class="row mb-3" id="emailVerification" style="display: none;">
            <label for="emailcheck_id" class="col-sm-2 col-form-label">인증코드 입력</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="emailcheck_id" >
              <div class="invalid-feedback"></div>
            </div>
            <div class="col-sm-2" >
              <span class='btn btn-block btn-secondary' id='timer'></span>
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
              <button type="submit" class="btn btn-primary" onclick="goPay()">확인</button>
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
