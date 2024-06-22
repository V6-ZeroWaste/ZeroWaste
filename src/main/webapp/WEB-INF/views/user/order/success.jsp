<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css"/>
    <link rel="stylesheet" href="/user/css/style.css"/>

    <title>soaff</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<body>

<!-- 주문 결제가 완료되었습니다 -->
<section class="py-0 text-white">
    <div class="image image-overlay" style="background-image:url(/user/images/main_test1.png)"></div>
    <div class="container">
        <div class="row align-items-center justify-content-center vh-100">
            <div class="col-12 col-md-12 col-lg-12 text-center">
                <h1 class="display-1 font-weight-bold">Thank you for practicing zero waste!</h1>
                <p class="lead"></p>
                <p><a href="/" class="btn btn-primary">메인페이지로 이동</a>
                    <a href="#" class="btn btn-primary">주문 내역 확인</a></p>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
