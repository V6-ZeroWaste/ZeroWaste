<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css"/>
    <link rel="stylesheet" href="/user/css/style.css"/>

    <title>soaff</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<body>

<!-- lookbook -->
<section class="hero bg-purple text-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <h1 class="mb-2">Our Story</h1>
                <p class="lead">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore quas omnis iure
                    perferendis tempore et nulla sed neque eligendi. Nemo temporibus omnis neque consequatur illum quae
                    et, laudantium minus nam!</p>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam cumque consectetur a porro natus
                    maiores repellendus nostrum voluptates praesentium. Velit enim quibusdam tenetur nisi eaque veniam
                    debitis, labore modi at!</p>
            </div>
        </div>
        <div class="row gutter-1 masonry gallery collage mb-10">
            <div class="col-6">
                <figure class="equal equal-75">
                    <a class="image image-scale" href="assets/images/about-1.jpg"
                       style="background-image: url(/user/images/about-1.jpg);">
                    </a>
                </figure>
            </div>
            <div class="col-6">
                <figure class="equal equal-125">
                    <a class="image image-scale" href="assets/images/about-2.jpg"
                       style="background-image: url(/user/images/about-2.jpg);">
                    </a>
                </figure>
            </div>
            <div class="col-6">
                <figure class="equal equal-50">
                    <a class="image image-scale" href="assets/images/about-3.jpg"
                       style="background-image: url(/user/images/about-3.jpg);">
                    </a>
                </figure>
            </div>
        </div>
        <div class="row gutter-4">
            <div class="col-md-4">
                <div class="text-center px-2">
                    <i class="icon-Money---Alt fs-40 mb-2"></i>
                    <h4 class="eyebrow d-block text-white">Moneyback Guarantee</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="text-center px-2">
                    <i class="icon-Airplane fs-40 mb-2"></i>
                    <h4 class="eyebrow d-block text-white">Free Delivery</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="text-center px-2">
                    <i class="icon-Guard fs-40 mb-2"></i>
                    <h4 class="eyebrow d-block text-white">International Warranty</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- text -->
<section>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <p class="lead">
                    Our products are inspired by the people and world around us. Beautiful, high quality goods that are
                    designed especially for you. Discover our story and meet the people that make our brand what it is.
                </p>
            </div>
        </div>
    </div>
</section>


<!-- cta -->
<section class="pt-0">
    <div class="container">
        <div class="cta bg-primary">
            <div class="row align-items-center gutter-0">
                <div class="col-md-6 cta-image">
                    <div class="image image-overlay image-scroll" style="background-image:url(/user/images/card-2.jpg)"
                         data--100-bottom-top="transform: translateY(0%);"
                         data-top-bottom="transform: translateY(25%);"></div>
                </div>
                <div class="col-md-6 py-5 py-md-0 text-white text-center">
                    <h2 class="mb-2"><b class="d-block font-weight-bold">Have a project ?</b> Let's talk.</h2>
                    <a href="#!" class="underline action">Get in Touch</a>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- numbers -->
<section>
    <div class="container">
        <div class="row">
            <div class="col">
                <h2 class="section-title">
                    Numbers
                </h2>
            </div>
        </div>
        <div class="row gutter-2 gutter-md-4">
            <div class="col-md-6 col-lg-3">
                <span class="h1 font-weight-bold">50</span>
                <p>Collective years experience — Working with clients like Google and Amazon.</p>
            </div>
            <div class="col-md-6 col-lg-3">
                <span class="h1 font-weight-bold">120</span>
                <p>Collective years experience — Working with clients like Google and Amazon.</p>
            </div>
            <div class="col-md-6 col-lg-3">
                <span class="h1 font-weight-bold">20</span>
                <p>Collective years experience — Working with clients like Google and Amazon.</p>
            </div>
            <div class="col-md-6 col-lg-3">
                <span class="h1 font-weight-bold">15</span>
                <p>Collective years experience — Working with clients like Google and Amazon.</p>
            </div>
        </div>
    </div>
</section>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
