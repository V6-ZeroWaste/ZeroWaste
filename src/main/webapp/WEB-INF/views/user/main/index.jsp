<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
        <link rel="stylesheet" href="/user/css/vendor.css" />
        <link rel="stylesheet" href="/user/css/style.css" />
        <link rel="stylesheet" href="/user/css/login-popup.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <title>soaff</title>
      </head>

      <body>


        <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
          <!-- 로그인 팝업 -->
          <div id="loginPopup" class="card active">
            <div class="card-header" id="headingOne">
              <h2 class="mb-0">
                <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne"
                  aria-expanded="true" aria-controls="collapseOne">
                  Log In
                </button>
              </h2>
            </div>

            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
              <div class="card-body">
                <div class="row mt-2">
                  <div class="form-group col-12">
                    <label for="exampleInputEmail1">Email address</label>
                    <input type="email" class="form-control" id="exampleInputEmail1">
                  </div>
                  <div class="form-group col-12 mt-1">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" id="exampleInputPassword1">
                  </div>
                  <div class="col-12 mt-1">
                    <div class="custom-control custom-switch mb-2">
                      <input type="checkbox" class="custom-control-input" id="customSwitch1">
                      <label class="custom-control-label" for="customSwitch1">Toggle this switch element</label>
                    </div>
                  </div>
                  <div class="col-12 mt-2">
                    <a href="#!" class="btn btn-block btn-primary">Log In</a>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- hero -->
          <div class="swiper-container">
            <div class="swiper-wrapper">
              <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/main_test1.png)">
                </div>
                <div class="container">
                  <div class="row align-items-center vh-100">
                    <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
                      <h1 class="display-1 mt-1 mb-3 font-weight-light">SOAFF BEST Item <b class="d-block">Greener24</b>
                      </h1>
                      <a href="listing-full.html" class="btn btn-sm btn-white btn-action">Shop Now <span
                          class="icon-arrow-right"></span></a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/background-2.jpg)">
                </div>
                <div class="container">
                  <div class="row align-items-end align-items-center vh-100">
                    <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
                      <h1 class="display-1 mb-2 font-weight-light">Brand New <b>Sunglasses</b></h1>
                      <a href="listing-full.html" class="btn btn-sm btn-white btn-action">Shop Now <span
                          class="icon-arrow-right"></span></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="swiper-footer">
              <div class="container">
                <div class="row align-items-center mb-5">
                  <div class="col-lg-6">
                    <div class="swiper-pagination"></div>
                  </div>
                  <div class="col-lg-6 text-right">
                    <div class="swiper-navigation">
                      <div class="swiper-button-prev"></div>
                      <div class="swiper-button-next"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- instagram -->
          <section class="pb-1 no-overflow">
            <div class="container">
              <div class="row gutter-1">
                <div class="col-md-6 col-lg-4 level-1">
                  <div class="card card-equal bg-primary text-white">
                    <div class="card-header p-4">
                      <i class="icon-instagram fs-30"></i>
                    </div>
                    <div class="card-footer p-4">
                      <h2 class="card-title fs-30 w-75">We are active on <a href="#!"
                          class="font-weight-bold underline">Instagram</a></h2>
                    </div>
                  </div>
                </div>
                <div class="col-md-6 col-lg-8">
                  <div class="owl-carousel owl-carousel-alt visible" data-items="[2,2,1,1]" data-margin="10"
                    data-loop="true" data-nav="true">
                    <figure class="equal"><a class="image image-fade" href="#!"
                        style="background-image: url(/user/images/instagram-1.jpg)"></a></figure>
                    <figure class="equal"><a class="image image-fade" href="#!"
                        style="background-image: url(/user/images/instagram-2.jpg)"></a></figure>
                    <figure class="equal"><a class="image image-fade" href="#!"
                        style="background-image: url(/user/images/instagram-3.jpg)"></a></figure>
                    <figure class="equal"><a class="image image-fade" href="#!"
                        style="background-image: url(/user/images/instagram-4.jpg)"></a></figure>
                    <figure class="equal"><a class="image image-fade" href="#!"
                        style="background-image: url(/user/images/instagram-5.jpg)"></a></figure>
                  </div>
                </div>
              </div>
            </div>
          </section>




          <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

      </body>


      </html>