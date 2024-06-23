<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>404 Error - SB Admin</title>
    <link href="/admin/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<div id="layoutSidenav">
    <%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
    <div id="layoutSidenav_content">
        <main>
            <div id="layoutError">
                <div id="layoutError_content">
                    <main>
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-6">
                                    <div class="text-center mt-4">
                                        <img class="mb-4 img-error" src="/admin/assets/img/error-404-monochrome.svg" />
                                        <p class="lead font-weight-bold text-white" style="margin: 0">죄송합니다. 페이지를 찾을 수 없습니다.</p>
                                        <p class="lead font-weight-bold">존재하지 않는 주소를 입력하셨거나,<br>요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.<br><br><a href="/admin" class="btn btn-primary">HOME</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>
        </main>
        <%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>
    </div>
</div>
</body>
</html>
