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
                            <a class="nav-link" href="/login">Log In</a>
                        </li>

                        
                        <li class="nav-item cart">
                            <a href="/cart" class="nav-link"><span>Cart</span><span>2</span></a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>


</header>