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
                  <li class="nav-item dropdown megamenu">
                    <a class="nav-link dropdown-toggle" href="#!" id="navbarDropdown-4" role="button"
                      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      STORE
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown-4">
                      <div class="row">
                        <ul class="col-6 col-md-3 col-lg-2">
                          <li><span class="megamenu-title">HOME & LIVING</span></li>
                          <li><span class="megamenu-title">HAIR</span></li>
                          <li><span class="megamenu-title">FACE & BODY</span></li>
                          <li><span class="megamenu-title">FOR PET</span></li>

                        </ul>

                      </div>
                    </div>

                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="documentation/index.html">
                      SOAFF STORY
                    </a>
                  </li>
                </ul>
              </div>

              <div class="collapse navbar-collapse order-4 order-lg-3" id="navbarMenu2">
                <ul class="navbar-nav ml-auto">
                  <c:if test="${empty login }">
                    <li class="nav-item">
                      <a class="nav-link" href="portal.html">Log In</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="portal.html">JOIN</a>
                    </li>
                  </c:if>
                  <c:if test="${!empty login }">
                    <li class="nav-item">
                      <a class="nav-link" href="portal.html">Log Out</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="portal.html">My Page</a>
                    </li>
                  </c:if>
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