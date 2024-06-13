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
  $(function(){
      
      $('#adr_btn').on('click', () => {
          zipcode();
      });

      var checkMailBtn = document.getElementById('checkMail');
      checkMailBtn.addEventListener('click', () => {
          handleCheckMail();
      });

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

      function handleCheckMail() {
          // Add your mail checking logic here
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
            <div class="row">
              <div class="col">
                <div class="tab-content" id="myTabContent">
                  <form>
                    <div class="row mb-3">
                      <label for="inputEmail" class="col-sm-2 col-form-label">아이디</label>
                      <div class="col-sm-4">
                        <input type="email" class="form-control" id="inputEmail">
                      </div>
                      <div class="col-sm-2">
                     <button type="button" class="btn btn-primary btn-rounded">중복확인</button>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
                      <div class="col-sm-6">
                        <input type="password" class="form-control" id="inputPassword">
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label for="inputPasswordConfirm" class="col-sm-2 col-form-label">비밀번호 확인</label>
                      <div class="col-sm-6">
                        <input type="password" class="form-control" id="inputPasswordConfirm">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="inputName" class="col-sm-2 col-form-label">이름</label>
                      <div class="col-sm-6">
                        <input type="text" class="form-control" id="inputName">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="inputTel" class="col-sm-2 col-form-label">전화번호</label>
                      <div class="col-sm-2">
                        <input type="text" class="form-control" id="tel1" placeholder="010">
                      </div>
                      <div class="col-sm-2">
                        <input type="text" class="form-control" id="tel2" placeholder="1234">
                      </div>
                      <div class="col-sm-2">
                        <input type="text" class="form-control" id="tel3" placeholder="5678">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="inputEmail2" class="col-sm-2 col-form-label">이메일</label>
                      <div class="col-sm-2" style="padding-left: 15px; padding-right: 0px;">
                        <input type="text" class="form-control" id="inputEmail2" placeholder="Username" aria-label="Username">
                      </div>
                      <span class="col-form-label">@</span>
                      <div class="col-sm-2" style="padding-right: 0px;">
                        <div class="form-group mb-1" style="padding-left: 0px; padding-right: 30px;">
	                      <select id="exampleInput-5" class="custom-select">
	                        <option selected>선택 사항</option>
	                        <option value="1">One</option>
	                        <option value="2">Two</option>
	                        <option value="3">Three</option>
	                      </select>
                   		 </div>
                      </div>
          
                      <div class="col-sm-2" style="padding-left: 0px">
                     	<button type="button" class="btn btn-primary btn-rounded" id="checkMail" onclick="handleCheckMail()">인증코드 발송</button>
                      </div>

                    </div>
                    <div class="row mb-3">
                      <label for="inputAddress1" class="col-sm-2 col-form-label">주소</label>
                      <div class="col-sm-4">
                        <input type="text" class="form-control" id="zipcode">
                      </div>
                      <div class="col-sm-2">
                     <button type="button" class="btn btn-primary btn-rounded" id="adr_btn">우편번호</button>
                      </div>
                    </div>
                         <div class="row mb-3">
                      <label for="inputAddress1" class="col-sm-2 col-form-label"></label>
                      <div class="col-sm-6">
                        <input type="text" class="form-control" id="addr1">
                      </div>
                    </div>
                         <div class="row mb-3">
                      <label for="inputAddress1" class="col-sm-2 col-form-label"></label>
                      <div class="col-sm-6">
                        <input type="text" class="form-control" id="addr2">
                      </div>
                    </div>
                    <div class="row mb-3">
                    	<div class="col-sm-3"> 
		                </div>
		                <div class="col-sm-2">
		                    <button type="submit" class="btn btn-primary">취소</button>
		                </div>
		                <div class="col-sm-2">
		                    <button type="submit" class="btn btn-primary">확인</button>
		                </div>
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
