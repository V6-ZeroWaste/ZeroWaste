<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<!-- 유저 정보  -->
	<section class="hero hero-small text-white" style="background:rgba(97, 130, 100, 1);">
      <div class="container">
        <div class="row gutter-2 gutter-md-4 align-items-end">
          <div class="col-md-6 text-center text-md-left">
            <h1 class="mb-0">${userId}</h1>
            <h3 class="text-muted">Point : <fmt:formatNumber value="${userPoint}" pattern="#,###" /> p</h3>
          </div>
          <div class="col-md-6 text-center text-md-right">
          </div>
        </div>
      </div>
    </section>




    


    


    


    


    