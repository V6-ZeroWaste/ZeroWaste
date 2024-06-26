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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <title>soaff</title>
      </head>

      <body>

        <%@ include file="/WEB-INF/views/user/include/header.jsp" %>

          <!-- hero -->
          <div class="swiper-container">
            <div class="swiper-wrapper">
            
              <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/soaff_BestItem_5.png)">
                </div>
                <div class="container">
                  <div class="row align-items-center vh-100">
                    <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
     
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/soaff_BestItem_4.png)">
                </div>
                <div class="container">
                  <div class="row align-items-end align-items-center vh-100">
                    <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">

                    </div>
                  </div>
                </div>
              </div>
              
              <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/soaff_BestItem_3.png)">
                </div>
                <div class="container">
                  <div class="row align-items-end align-items-center vh-100">
                    <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">

                    </div>
                  </div>
                </div>
              </div>
              
              <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/soaff_BestItem_2.png)">
                </div>
                <div class="container">
                  <div class="row align-items-end align-items-center vh-100">
                    <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">

                    </div>
                  </div>
                </div>
              </div>
              
              <div class="swiper-slide">
                <div class="image image-overlay image-zoom" style="background-image:url(/user/images/soaff_BestItem_1.png)">
                </div>
                <div class="container">
                  <div class="row align-items-end align-items-center vh-100">
                    <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">

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
                  
                </div>
                <div class="col-md-6 col-lg-8">
                  <div class="owl-carousel owl-carousel-alt visible" data-items="[2,2,1,1]" data-margin="10"
                    data-loop="true" data-nav="true">
                    <figure class="equal"><a class="image image-fade" href="/item/detail?item_no=21"
                        style="background-image: url(/user/images/soaff_FaceBody_21.png)"></a></figure>
                    <figure class="equal"><a class="image image-fade" href="/item/detail?item_no=22"
                        style="background-image: url(/user/images/soaff_FaceBody_22.png)"></a></figure>
                    <figure class="equal"><a class="image image-fade" href="/item/detail?item_no=24"
                        style="background-image: url(/user/images/soaff_Hair_1.png)"></a></figure>
                    <figure class="equal"><a class="image image-fade" href="/item/detail?item_no=39"
                        style="background-image: url(/user/images/soaff_Living_7.png)"></a></figure>
                    <figure class="equal"><a class="image image-fade" href="/item/detail?item_no=43"
                        style="background-image: url(/user/images/soaff_Pet_1.png)"></a></figure>
                  </div>
                </div>
              </div>
            </div>
          </section>




          <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

      </body>


      </html>