<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<header class="header header-dark header-sticky">
    <div class="container">
        <div class="row">
            <nav class="navbar navbar-expand-lg navbar-dark">
                <a href="/" class="navbar-brand order-1 order-lg-2">SOAFF</a>
                <button class="navbar-toggler order-2" type="button" data-toggle="collapse"
                        data-target=".navbar-collapse"
                        aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse order-3 order-lg-1" id="navbarMenu">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item"><a class="nav-link" href="/">Home</a></li>

                        <!-- store 토글 -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#!" id="navbarDropdown-4" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                STORE
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <li><a class="dropdown-item" href="/item/list">All</a></li>
                                <c:forEach var="category" items="${categories}">
                                    <li><a class="dropdown-item" href="/item/list?category_no=${category.category_no}">${category.name}</a></li>
                                </c:forEach>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/about">
                                SOAFF STORY
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="collapse navbar-collapse order-4 order-lg-3" id="navbarMenu2">
                    <ul class="navbar-nav ml-auto">
                        <!-- 로그인 토글 -->

                            <li class="nav-item">
                                <c:if test="${!empty user_id}">
                                    <a class="nav-link" href="/logout">Log Out</a>
                                </c:if>
                                <c:if test="${empty user_id}">
                                    <a class="nav-link" href="/user/user/login">Log In</a>
                                </c:if>
                            </li>
                            <c:if test="${!empty user_id}">
	                            <li class="nav-item">
	                                <a class="nav-link dropdown-toggle" href="#!" id="navbarDropdown-10" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="max-height: 21px">
	                                    <svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16" id="button">
	                                        <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
	                                    </svg>
	                                </a>
	                                <ul class="dropdown-menu" aria-labelledby="navbarDropdown-10">
	                                    <li><a class="dropdown-item" href="/mypage/order/list">Order</a></li>
	                                    <li><a class="dropdown-item" href="/mypage/review/list">Reviews</a></li>
	                                    <li><a class="dropdown-item" href="/mypage/qna/list">QnA</a></li>
	                                    <li><a class="dropdown-item" href="/user/user/profile">Profile</a></li>
	                                    <li><a class="dropdown-item" href="/mypage/point">Point</a></li>
	                                </ul>
	                            </li>
                        	</c:if>
                        <li class="nav-item cart">
                            <a href="/cart" class="nav-link"><span>Cart</span><span>2</span></a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

</header>
