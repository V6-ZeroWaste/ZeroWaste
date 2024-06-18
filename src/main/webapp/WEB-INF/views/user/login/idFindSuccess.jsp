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
    window.addEventListener('load', function() {
      var forms = document.querySelectorAll('.needs-validation');
      (function() {
        'use strict';

        // Loop over them and prevent submission
        Array.prototype.slice.call(forms)
                .forEach(function(form) {
                  console.log(form);
                  form.addEventListener('submit', function(event) {
                    if (!check()) {
                      event.preventDefault();
                      event.stopPropagation();
                    }
                    if (!form.checkValidity()) {
                      event.preventDefault();
                      event.stopPropagation();
                    }

                    form.classList.add('was-validated');
                  }, false);
                });
      })();
    });

    function check() {
      var con = true;
      var name = $('#name').val();
      var email = $('#relEmail').val($('#email_id').val() + "@" + $('#email_domain').val());
      $.ajax({
        type: 'POST',
        url: '/user/login/loginFind',
        data: { name: name,
          email: email},
        async: false,
        success: function(res) {
          console.log(res);
          if (res == '1') {

            con = false;
          }
        }
      });
      return con;
    }
  </script>
</head>
<body>
<section class="py-md-0">
  <div class="container">
    <div class="row justify-content-center align-items-center vh-md-100">
      <div class="col-md-10 col-lg-6">
        <div class="card-header" id="headingOne">
          <h6 class="mb-0">
            <p style="color: #68ae68"><strong>회원님의 아이디</strong></p>
          </h6>
        </div>
        <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
          <div class="card-body" style="border : 1px #c2c2c2 solid">
            <div class="card-title py-2 px-3">
              <div class="row align-items-center">
                <div class="col" >
                  <h3 class="fs-28 mb-0">${vo.id}아이디가 들어갈 곳</h3>
                </div>
              </div>
            </div>
            <div class="col-12 mt-3">
              <a href="#!" class="btn btn-block btn-primary">메인 페이지로 이동</a>
            </div>
            <div class="col-12 mt-2" style="text-align: right;">
            </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>

<
