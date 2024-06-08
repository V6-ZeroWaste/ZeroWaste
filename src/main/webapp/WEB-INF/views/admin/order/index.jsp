<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>order admin index</title>
</head>
<body>
총 ${map.count }개 |  ${orderVO.page }/${map.totalPage }페이지<br>
  
            <c:if test="${empty map.list }">
                <tr>
                    <td class="first" colspan="8">등록된 글이 없습니다.</td>
                </tr>
            </c:if>
            <c:forEach var="vo" items="${map.list }">       
                <tr>
                    <td>order_no : ${vo}</td>
                </tr>
                
            </c:forEach>


    <!--

    <div class="pagenate clear">
        <ul class='paging'>
        <c:if test="${map.prev }">
            <li><a href="index.do?page=${map.startPage-1 }&searchType=${replyVO.searchType}&searchWord=${replyVO.searchWord}"> << </a></li>
        </c:if>
        <c:forEach var="p" begin="${map.startPage}" end="${map.endPage}">
            <c:if test="${p == replyVO.page}">
            <li><a href='#;' class='current'>${p}</a></li>
            </c:if>
            <c:if test="${p != replyVO.page}">
            <li><a href='index.do?page=${p}&searchType=${replyVO.searchType}&searchWord=${replyVO.searchWord}'>${p}</a></li>
            </c:if>
        </c:forEach>
        <c:if test="${map.next }">
            <li><a href="index.do?page=${map.endPage+1 }&searchType=${replyVO.searchType}&searchWord=${replyVO.searchWord}"> >> </a></li>
        </c:if>
        </ul> 
    </div>

    <!-- 페이지처리 -->
    <!--
    <div class="bbsSearch">
        <form method="get" name="searchForm" id="searchForm" action="index.do">
            <span class="srchSelect">
                <select id="stype" name="searchType" class="dSelect" title="검색분류 선택">
                    <option value="all">전체</option>
                    <option value="title" <c:if test="${replyVO.searchType == 'title'}">selected</c:if>>제목</option>
                    <option value="content" <c:if test="${replyVO.searchType == 'content'}">selected</c:if>>내용</option>
                </select>
            </span>
            <span class="searchWord">
                <input type="text" id="sval" name="searchWord" value="${replyVO.searchWord}"  title="검색어 입력">
                <input type="button" id="" value="검색" title="검색">
            </span>
        </form>
        
    </div>
	
	-->
</body>
</html>