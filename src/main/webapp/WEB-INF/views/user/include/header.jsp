<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <header class="header header-dark header-sticky">
        <div class="container">
          <div class="row">
            <nav class="navbar navbar-expand-lg navbar-dark">
              <a href="index.html" class="navbar-brand order-1 order-lg-2">SOAFF</a>
              <button class="navbar-toggler order-2" type="button" data-toggle="collapse" data-target=".navbar-collapse"
                aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>

              <div class="collapse navbar-collapse order-3 order-lg-1" id="navbarMenu">
                <ul class="navbar-nav mr-auto">
                  <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>

                  <!-- store 토글 -->
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#!" id="navbarDropdown-4" role="button"
                      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      STORE
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                      <li><a class="dropdown-item" href="#!">HOME & LIVING</a></li>
                      <li><a class="dropdown-item" href="#!">HAIR</a></li>
                      <li><a class="dropdown-item" href="#!">FACE & BODY</a></li>
                      <li><a class="dropdown-item" href="#!">FOR PET</a></li>
                    </ul>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/index">
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

                  <li class="nav-item">
                    <a data-toggle="modal" data-target="#search" class="nav-link"><i class="icon-search"></i></a>
                  </li>
                  <li class="nav-item cart">
                    <a data-toggle="modal" data-target="#cart" class="nav-link"><span>Cart</span><span>2</span></a>
                  </li>
                </ul>
              </div>
            </nav>
          </div>
        </div>


      </header>