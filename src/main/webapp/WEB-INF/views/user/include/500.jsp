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
</head>
<body>

<section class="py-0 text-white">
  <div class="image image-overlay" style="background-image:url(/user/images/main_test1.png)"></div>
  <div class="container">
    <div class="row align-items-center justify-content-center vh-100">
      <div class="col-10 col-md-8 col-lg-8 text-center">
        <h1 class="display-1 font-weight-bold">500</h1>
        <%--                <p class="lead">The page you were looking for wasn't found, if you think this might be a mistake <a href="#!" class="d-inline-block underline">drop us a line</a></p>--%>
        <%--                <p class="lead">죄송합니다. 페이지를 찾을 수 없습니다.<br>존재하지 않는 주소를 입력하셨거나,<br>요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.<br><a href="/" class="d-inline-block underline font-weight-bold">HOME</a></p>--%>
        <p class="lead font-weight-bold text-white" style="margin: 0">죄송합니다. 요청을 처리할 수 없습니다.</p>
        <p class="lead font-weight-bold">서비스 이용에 불편을 드려 죄송합니다,<br>시스템 에러가 발생하여 페이지를 표시할 수 없습니다.<br><br><a href="/" class="btn btn-primary">HOME</a></p>
      </div>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
