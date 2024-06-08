<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>
<body>
	<c:if test="${empty map.list}">
		<p>등록된 글이 없습니다.</p>
	</c:if>
	<c:forEach var="vo" items="${map.list}">
		<p>${vo.user_no} ${vo.id}</p>
		<a href="/admin/user/detail?user_no=${vo.user_no}">${vo.user_no} </a>
    </c:forEach>

</body>
</html>