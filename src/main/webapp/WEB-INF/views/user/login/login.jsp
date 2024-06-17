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
<script type="text/javascript">
  $(function() {

    function timer() {
      var time = 180; // 기준시간 작성 (3분 = 180초)
      var min = ""; // 분
      var sec = ""; // 초

      // setInterval(함수, 시간) : 주기적인 실행
      var x = setInterval(function () {
        // parseInt() : 정수를 반환
        min = parseInt(time / 60); // 몫을 계산
        sec = time % 60; // 나머지를 계산

        document.getElementById("timer").innerHTML = min + "분 " + sec + "초";
        time--;

        // 타임아웃 시
        if (time < 0) {
          clearInterval(x); // setInterval() 실행을 끝냄
          document.getElementById("timer").innerHTML = "시간초과";
        }
      }, 1000);
    }

    $('#email_btn').on('click', function() {
      var email_btn = document.getElementById('email_btn');
      email_btn.innerHTML='재전송';
      $('#emailVerification').show();
      timer();
    });

    $('#adr_btn').on('click', () => {
      zipcode();
    });

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

    window.addEventListener('load', function () {
      var forms = document.querySelectorAll('.needs-validation');
      var idBtnError = document.getElementById('idBtnError');
      var pwCheckError = document.getElementById('pwCheckError');
      var addrError = document.getElementById('addrError');
      var con = true;
      (function () {
        'use strict';

        // Fetch all the forms we want to apply custom Bootstrap validation styles to

        // Loop over them and prevent submission
        Array.prototype.slice.call(forms)
                .forEach(function (form) {
                  console.log(form);
                  var event = true;
                  pwError();


                  form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                      addrErrorCheck();
                      event.preventDefault();
                      event.stopPropagation();
                    }

                    form.classList.add('was-validated');
                  }, false);
                });
      })();

      // 비밀번호와 비밀번호 확인 필드가 일치하는지 확인
      function pwError(){
        pwd_check.addEventListener('input',function () {
          if (pwd.value !== pwd_check.value) {
            pwd_check.setCustomValidity(pwCheckError.innerHTML='비밀번호와 일치하지 않습니다');
          }
          else {
            pwd_check.setCustomValidity('');
          }
        });
      }

      // 주소 필드 유효성 검사 추가
      function addrErrorCheck() {
        var zipcode = document.getElementById('zipcode');
        var addr1 = document.getElementById('addr1');
        if (zipcode.value === '') {
          $('#zipcode').addClass('is-invalid');
        }else{
          zipcodeChange();
        }

      }
      function zipcodeChange() {
        var zipcode = document.getElementById('zipcode');
        zipcode.addEventListener('input', function() {
          if (zipcode.value !== '') {
            $('#zipcode').removeClass('is-invalid').addClass('is-valid');
          } else {
            $('#zipcode').removeClass('is-valid').addClass('is-invalid');
          }
        });
      }

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
    });
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
        <form action="/user/join" method="POST" name="frm" id="frm" class="needs-validation" novalidate>

          <%--아이디 기입을 하지 않은경우--%>
          <div class="row mb-3">
            <label for="id" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>아이디</strong></label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="id" name="id" required>
              <div class="valid-feedback">사용가능한 아이디입니다.</div>
              <div class="invalid-feedback" id="idBtnError"></div>
            </div>
            <div class="col-sm-2">
              <button type="button" class="btn btn-primary btn-rounded" id="id_btn">중복확인</button>
            </div>
          </div>

          <div class="row mb-3" style="margin-bottom: 0;">
            <label for="pwd" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>비밀번호</strong></label>
            <div class="col-sm-6">
              <input type="password" class="form-control" id="pwd" required>
              <div class="valid-feedback" id="pwError">사용가능한 비밀번호 입니다.</div>
              <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="pwd_check" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>비밀번호 확인</strong></label>
            <div class="col-sm-6">
              <input type="password" class="form-control" id="pwd_check" required>
              <div class="valid-feedback">비밀번호가 일치합니다</div>
              <div class="invalid-feedback" id="pwCheckError">비밀번호 확인을 입력해주세요.</div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="name" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>이름</strong></label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="name" required pattern="^[a-zA-Z가-힣]+$" >
              <div class="valid-feedback">사용가능한 이름입니다</div>
              <div class="invalid-feedback" id="nameError">올바른 이름을 입력해주세요.</div>
            </div>
          </div>

          <div class="row mb-3">
            <label class="col-sm-2 col-form-label" style="color: #3d733d"><strong>전화번호</strong></label>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel1" placeholder="010" required pattern="\d{2,3}">
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="tel1Error">전화번호를 입력해주세요.</div>
            </div>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel2" placeholder="1234" required pattern="\d{3,4}">
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="tel2Error"></div>
            </div>
            <div class="col-sm-2">
              <input type="text" class="form-control" id="tel3" placeholder="5678" required pattern="\d{3,4}">
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="tel3Error"></div>
            </div>
          </div>

          <div class="row mb-3">
            <label for="email_id" class="col-sm-2 col-form-label" style="color: #3d733d"><strong>이메일</strong></label>
            <div class="col-sm-2" style="padding-right: 0">
              <input type="text" class="form-control" id="email_id" placeholder="이메일" aria-label="이메일입력" required pattern="^[a-zA-Z0-9._-]+$">
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="emailIdError">이메일을 입력해주세요.</div>
            </div>
            <span class="col-form-label">@</span>
            <div class="col-sm-2" style="padding-right: 0; padding-left: 0">
              <input type="text" class="form-control" id="email_domain" placeholder="도메인이름" aria-label="도메인이름" readonly required pattern="^[a-zA-Z0-9.-]+$">
              <div class="valid-feedback"></div>
              <div class="invalid-feedback" id="emailDomainError">도메인을 입력해주세요.</div>
            </div>
            <div class="col-sm-2" style="padding-right: 30px; padding-left: 0">
              <div class="form-group mb-1">
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
                <div class="valid-feedback"></div>
                <div class="invalid-feedback"></div>
              </div>
            </div>

            <div class="col-sm-3" style="padding-left: 0px">
              <button type="button" class="btn btn-primary btn-rounded" id="email_btn">인증코드</button>
            </div>
          </div>
          <div class="row mb-3" id="emailVerification" style="display: none;">
            <label for="emailcheck_id" class="col-sm-2 col-form-label">인증코드 입력</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="emailcheck_id" required>
              <div class="invalid-feedback">올바른 인증코드를 입력해주세요</div>
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
              <input type="text" class="form-control" id="zipcode" readonly required>
              <div class="invalid-feedback" id="addrSuccess">우편번호를 눌러주세요</div>
            </div>
            <div class="col-sm-2">
              <button type="button" class="btn btn-primary btn-rounded" id="adr_btn" >우편번호</button>
            </div>
          </div>
          <div class="row mb-3">
            <label for="addr1" class="col-sm-2 col-form-label"></label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="addr1" readonly required>
              <div class="invalid-feedback" id="addrError"></div>
            </div>
          </div>
          <div class="row mb-3">
            <label for="addr2" class="col-sm-2 col-form-label"></label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="addr2">
              <div class="valid-feedback">선택사항입니다</div>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-2">
              <button type="button" class="btn btn-primary" onclick="history.back();">취소</button>
            </div>
            <div class="col-sm-2">
              <button type="submit" class="btn btn-primary">확인</button>
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
