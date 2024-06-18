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
  // var dupCheck = false;
  // function goSave() {
  //   //아이디를 입력 안 했을떄
  //   if ($("#id").val() == '') {
  //     var idRes = document.getElementById("idRes");
  //     idRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     $("#id").focus();
  //     return;
  //   } else {
  //   }
  //
  //   // var con = true;
  //   // $.ajax({
  //   //   url:'/user/join/idCheck.do',
  //   //   data : {id:$("#id").val()},
  //   //   async : false,
  //   //   success : function(res) {
  //   //     console.log(res);
  //   //     if (res == '1') {
  //   //       alert('중복된 아이디입니다.\r\n다른 이메일을 입력해 주세요');
  //   //       con = false;
  //   //       return;
  //   //     }
  //   //   }
  //   // });
  //
  //   // if (!con) return;
  //   //비밀번호를 입력 안 했을떄
  //   if ($("#pw").val() == '') {
  //     var idRes = document.getElementById("idRes");
  //     idRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('비밀번호를 입력하세요');
  //     $("#pw").focus();
  //     return;
  //   }
  //   //비밀번호가 같은지
  //   if ($("#pw").val() != $("#pw_check").val()) {
  //     var pwRes = document.getElementById("pwRes");
  //     pwRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('비밀번호를 확인하세요');
  //     return;
  //   }
  //   var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/;
  //   if ($("#pwd").val().match(reg) == null) {
  //     var pwRes = document.getElementById("pwRes");
  //     pwRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('비밀번호는 영문+숫자 조합으로 8자이상 입력하세요');
  //     $("#pwd").val('');
  //     $("#pwd_check").val('');
  //     return;
  //   }
  //   if ($("#name").val() == '') {
  //     var nameRes = document.getElementById("nameRes");
  //     nameRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('이름을 입력하세요');
  //     $("#name").focus();
  //     return;
  //   }
  //
  //   if ($("#email_id").val() == '') {
  //     var emailRes = document.getElementById("emailRes");
  //     emailRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('이메일을 입력하세요');
  //     $("#email").focus();
  //     return;
  //   }
  //   if ($("#email_domain").val() == '') {
  //     var email_domain = document.getElementById("email_domain");
  //     email_domain.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('도메인을 입력하세요');
  //     $("#email").focus();
  //     return;
  //   }
  //
  //
  //
  //   if ($("#tel1").val() == '' || $("#tel2").val() == '' || $("#tel3").val() == '' ) {
  //     var idRes = document.getElementById("idRes");
  //     idRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('번호를 입력하세요 ');
  //     $("#email").focus();
  //     return;
  //   }
  //
  //   // ^(\d{2,3})-(\d{3,4})-(\d{4})$
  //   var reg = /^(\d{2,3})$/;
  //   if ($("#tel1").val().match(reg) == null) {
  //     var idRes = document.getElementById("idRes");
  //     idRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('올바른 전화번호를 입력하세요');
  //     $("#tel1").val('');
  //     return;
  //   }
  //
  //   var reg = /^(\d{3,4})$/;
  //   if ($("#tel2").val().match(reg) == null) {
  //     var idRes = document.getElementById("idRes");
  //     idRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('올바른 전화번호를 입력하세요');
  //     $("#tel2").val('');
  //     return;
  //   }
  //
  //   var reg = /^(\d{4})$/;
  //   if ($("#tel3").val().match(reg) == null) {
  //     var idRes = document.getElementById("idRes");
  //     idRes.innerHTML='<span style="color:#27a8ae;">올바른 아이디를 입력하세요</span>'
  //     alert('올바른 전화번호를 입력하세요');
  //     $("#tel3").val('');
  //     return;
  //   }
  //
  //
  //
  //   let relTel = $("#tel1").val() + $("#tel2").val() + $("#tel3").val();
  //   // console.log($("#tel").val(relTel));
  //   // console.log(typeof (relTel));
  //
  //   var reg = /^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.[a-zA-Z]{2,6}$/;
  //   let relEmail = $("#email_id").val() + "@" + $("#email_domain").val();
  //   // console.log($("#relEmail").val(relEmail))
  //   // console.log(typeof (relEmail));
  //   if (relEmail.match(reg) == null) {
  //     var emailResRes = document.getElementById("emailResRes");
  //     emailResRes.innerHTML='<span style="color:red;">올바른 아이디를 입력하세요</span>'
  //     alert('올바른 이메일 도메인을 입력하세요');
  //     $("#email_domain").val('');
  //     $("#email_id").val('');
  //     return;
  //   }
  //
  //
  //   // 전송
  //   $("#frm").submit();
  // }
  //
  $(function(){
  //  $('#checkId').on('click',function (){
  //    var con = true;
  //    $.ajax({
  //      url:'/user/join/idCheck.do',
  //      data : {id:$("#id").val()},
  //      async : false,
  //      success : function(res) {
  //        console.log(res);
  //        if (res == '1') {
  //          alert('중복된 아이디입니다.\r\n다른 아이디를 입력해 주세요');
  //          con = false;
  //          return;
  //        }
  //      }
  //    });
  //    if (!con) return;
  //  });
  //
  //   $('#pwd_check').on('input',function (){
  //     var pw1Res = document.getElementById("pw1Res");
  //     if($('#pwd').val() !== $(this).val()){
  //       pw1Res.innerHTML = '<span style="color:red; font-size: 10px;" >입력한 비밀번호와 맞지 않습니다.</span>';
  //     } else {
  //       pw1Res.innerHTML = ''; // 메시지를 삭제합니다.
  //     }
  //   });
  //
  //
  //
  //   $('#adr_btn').on('click', () => {
  //     zipcode();
  //   });
  //
  //   $('#emailSel').change(function (){
  //     var emailSel = $(this).val();
  //     var email_domain = $("#email_domain");
  //     console.log(emailSel);
  //     if (emailSel === '직접입력'){
  //       emailSel = null;
  //       email_domain.attr('readonly',false);
  //     }
  //     email_domain.val(emailSel);
  //   })
  //
  //
  //
  //   $('#checkMail').on('click',function(event){
  //     $.ajax({
  //       type:"POST",
  //       url:"/user/",
  //       data: {
  //
  //       }
  //     })
  //   })

    // $('#checkId').on('click',function (event){
    //   $.ajax({
    //     type: "POST",
    //     url: "/qna/updateReply",
    //     data: {
    //       qna_no: qna_no,
    //       reply: reply
    //     },
    //     success: function(response) {
    //       if (response === 1) {
    //         alert("답변이 등록/수정되었습니다.");
    //         location.reload();
    //       } else {
    //         alert("답변 등록/수정에 실패했습니다.");
    //       }
    //     },
    //     error: function() {
    //       alert("서버와의 통신 중 오류가 발생했습니다.");
    //     }
    //   });
    // });
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
      function zipcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
          var roadAddr = data.roadAddress; // 도로명 주소 변수
          var extraRoadAddr = ''; // 참고 항목 변수

          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraRoadAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if(data.buildingName !== '' && data.apartment === 'Y'){
            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          if(extraRoadAddr !== ''){
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
<%--        <div class="row">--%>
<%--          <div class="col">--%>
<%--            <div class="tab-content" id="myTabContent">--%>
              <form action="/user/join" method="POST" name="frm" id="frm">
                <div class="row mb-1">
                  <div class="col-sm-2">
                  </div>
                  <div class="col-sm-4 check-input" id="idRes">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="id" class="col-sm-2 col-form-label">아이디</label>
                  <div class="col-sm-4">
                    <input type="text" class="form-control is-valid " id="id">
                  </div>
                  <div class="col-sm-2">
                    <button type="button" class="btn btn-primary btn-rounded" id="checkId">중복확인</button>
                  </div>
                </div>

                <div class="row mb-1">
                  <div class="col-sm-2">
                  </div>
                  <div class="col-sm-4" id="pwRes">

                  </div>
                </div>
                <div class="row mb-3" style="margin-bottom: 0;">
                  <label for="pwd" class="col-sm-2 col-form-label" >비밀번호</label>
                  <div class="col-sm-6">
                    <input type="password" class="form-control is-valid" id="pwd" required>
                  </div>
                </div>
                <div class="row mb-1">
                  <div class="col-sm-2">
                  </div>
                  <div class="col-sm-4" id="pw1Res">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="pwd_check" class="col-sm-2 col-form-label" >비밀번호 확인</label>
                  <div class="col-sm-6">
                    <input type="password" class="form-control is-valid" id="pwd_check" required>
                  </div>
                </div>

                <div class="row mb-1">
                  <div class="col-sm-2">
                  </div>
                  <div class="col-sm-4" id="nameRes">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="name" class="col-sm-2 col-form-label">이름</label>
                  <div class="col-sm-6">
                    <input type="text" class="form-control is-valid" id="name" required>
                  </div>
                </div>

                <div class="row mb-1">
                  <div class="col-sm-2">
                  </div>
                  <div class="col-sm-4" id="telRes">
                  </div>
                </div>
                <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">전화번호</label>
                  <div class="col-sm-2">
                    <input type="text" class="form-control is-valid" id="tel1" placeholder="010" required>
                  </div>
                  <div class="col-sm-2">
                    <input type="text" class="form-control is-valid" id="tel2" placeholder="1234" required>
                  </div>
                  <div class="col-sm-2">
                    <input type="text" class="form-control is-valid" id="tel3" placeholder="5678" required>
                  </div>
                </div>

                <div class="row mb-1">
                  <div class="col-sm-2">
                  </div>
                  <div class="col-sm-4" id="emailRes">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="email_id" class="col-sm-2 col-form-label">이메일</label>
                  <div class="col-sm-2" style="padding-right: 0">
                    <input type="email" class="form-control is-valid" id="email_id" placeholder="Username" aria-label="Username">
                  </div>
                  <span class="col-form-label">@</span>
                  <div class="col-sm-2" style="padding-right: 0; padding-left: 0">
                    <input type="email" class="form-control is-valid" id="email_domain" placeholder="Username" aria-label="Username" readonly required>
                  </div>
                  <div class="col-sm-2" style="padding-right: 30px; padding-left: 0">
                    <div class="form-group mb-1">
                      <select id="emailSel" class="custom-select">
                        <option value="">-선택-</option>
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
                    <button type="button" class="btn btn-primary btn-rounded" id="checkMail">인증코드</button>
                  </div>

                </div>
                <div class="row mb-1">
                  <div class="col-sm-2"></div>
                  <div class="col-sm-4" id="addRes">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="zipcode" class="col-sm-2 col-form-label">주소</label>
                  <div class="col-sm-4">
                    <input type="text" class="form-control is-valid" id="zipcode" readonly required>
                  </div>
                  <div class="col-sm-2">
                    <button type="button" class="btn btn-primary btn-rounded" id="adr_btn">우편번호</button>
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="addr1" class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-6">
                    <input type="text" class="form-control is-valid" id="addr1" readonly required>
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="addr2" class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-6">
                    <input type="text" class="form-control" id="addr2">
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-sm-3">
                  </div>
                  <div class="col-sm-2">
                    <button type="button" class="btn btn-primary" onclick="history.back();">취소</button>
                  </div>
                  <div class="col-sm-2">
                    <button type="button" class="btn btn-primary" onclick="goSave()">확인</button>
                  </div>
                </div>
                <input type="hidden" id="relEmail" name="relEmail">
                <input type="hidden" id="tel" name="relTel">
                <input type="hidden" id="add" name="relAdd">
              </form>
            </div>
          </div>
        </div>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>
</section>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>