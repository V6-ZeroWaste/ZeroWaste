<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css" />
    <link rel="stylesheet" href="/user/css/style.css" />

    <title>soaff</title>
  </head>
<body>

    <!-- header -->
    <header class="header header-dark header-sticky">
      <div class="container">
        <div class="row">
          <nav class="navbar navbar-expand-lg navbar-dark">
            <a href="index.html" class="navbar-brand order-1 order-lg-2">SOAFF</a>
            <button class="navbar-toggler order-2" type="button" data-toggle="collapse" data-target=".navbar-collapse" aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse order-3 order-lg-1" id="navbarMenu">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
                <li class="nav-item dropdown megamenu">
                  <a class="nav-link dropdown-toggle" href="#!" id="navbarDropdown-4" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
                <li class="nav-item">
                  <a class="nav-link" href="portal.html">Log In</a>
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


    <!-- hero -->
    <div class="swiper-container">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <div class="image image-overlay image-zoom" style="background-image:url(/user/images/main_test1.png)"></div>
          <div class="container">
            <div class="row align-items-center vh-100">
              <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
                <h1 class="display-1 mt-1 mb-3 font-weight-light">SOAFF BEST Item <b class="d-block">Greener24</b></h1>
                <a href="listing-full.html" class="btn btn-sm btn-white btn-action">Shop Now <span class="icon-arrow-right"></span></a>
              </div>
            </div>
          </div>
        </div>
        <div class="swiper-slide">
          <div class="image image-overlay image-zoom" style="background-image:url(/user/images/background-2.jpg)"></div>
          <div class="container">
            <div class="row align-items-end align-items-center vh-100">
              <div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
                <h1 class="display-1 mb-2 font-weight-light">Brand New <b>Sunglasses</b></h1>
                <a href="listing-full.html" class="btn btn-sm btn-white btn-action">Shop Now <span class="icon-arrow-right"></span></a>
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


    <!-- latest products -->
    <section>
      <div class="container">
        <div class="row gutter-1 align-items-end">
          <div class="col-md-6">
            <h2>Featured Products</h2>
          </div>
          <div class="col-md-6 text-md-right">
            <ul class="nav nav-tabs lavalamp" id="myTab" role="tablist">
              <li class="nav-item">
                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Best Sellers</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">New Arrivals</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <div class="tab-content" id="myTabContent">
              <div class="tab-pane fade show active" id="home" role="tabpanel">
                <div class="row gutter-2 gutter-md-3">

                  <div class="col-6 col-lg-4">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-classic.html">
                          <img src="/user/images/demo/product-15.jpg" alt="Image">
                          <img src="/user/images/demo/product-15-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-classic.html">Original Wool Herringbone Overshirt</a></h3>
                        <div class="product-price">
                          <span>$183</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>
                  <div class="col-6 col-lg-4">
                    <div class="product">
                      <figure class="product-image">
                        <span class="product-promo bg-red">sale</span>
                        <a href="product-classic.html">
                          <img src="/user/images/demo/product-16.jpg" alt="Image">
                          <img src="/user/images/demo/product-16-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-classic.html">Black Chadwick Sandals</a></h3>
                        <div class="product-price">
                          <span>$176</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>
                  <div class="col-6 col-lg-4">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-classic.html">
                          <img src="/user/images/demo/product-17.jpg" alt="Image">
                          <img src="/user/images/demo/product-17-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-classic.html">Navy Lind Wax Sweatshirt</a></h3>
                        <div class="product-price">
                          <span>$101</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>

                  <div class="col-6 col-lg-3">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-classic.html">
                          <img src="/user/images/demo/product-18.jpg" alt="Image">
                          <img src="/user/images/demo/product-18-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-classic.html">Black Karlo Backpack</a></h3>
                        <div class="product-price">
                          <span>$88</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>
                  <div class="col-6 col-lg-3">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-classic.html">
                          <img src="/user/images/demo/product-19.jpg" alt="Image">
                          <img src="/user/images/demo/product-19-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-classic.html">Light Marl Grey Davis Polo</a></h3>
                        <div class="product-price">
                          <span>$107</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>
                  <div class="col-6 col-lg-3">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-classic.html">
                          <img src="/user/images/demo/product-20.jpg" alt="Image">
                          <img src="/user/images/demo/product-20-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-classic.html">Green Organic Cotton Hoodie</a></h3>
                        <div class="product-price">
                          <span>$95</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>
                  <div class="col-6 col-lg-3">
                    <div class="product">
                      <figure class="product-image">
                        <span class="product-promo">-25%</span>
                        <a href="product-scroll.html">
                          <img src="/user/images/demo/product-21.jpg" alt="Image">
                          <img src="/user/images/demo/product-21-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-scroll.html">Peach Low Curve Iceman Trimix Sneakers</a></h3>
                        <div class="product-price">
                          <span>$271</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>

                </div>
              </div>
              <div class="tab-pane fade" id="profile" role="tabpanel">
                <div class="row gutter-2 gutter-md-3">

                  <div class="col-6 col-lg-4">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-scroll.html">
                          <img src="/user/images/demo/product-6.jpg" alt="Image">
                          <img src="/user/images/demo/product-6-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-scroll.html">Grey Pendant Bell Lamp</a></h3>
                        <div class="product-price">
                          <span>$258</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>

                  <div class="col-6 col-lg-4">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-masonry.html">
                          <img src="/user/images/demo/product-3.jpg" alt="Image">
                          <img src="/user//demo/product-3-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-masonry.html">Black IC Pendant Light</a></h3>
                        <div class="product-price">
                          <span>$410</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>

                  <div class="col-6 col-lg-4">
                    <div class="product">
                      <figure class="product-image">
                        <span class="product-promo">-25%</span>
                        <a href="product-modern.html">
                          <img src="/user/images/demo/product-4.jpg" alt="Image">
                          <img src="/user/images/demo/product-4-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-modern.html">Red Analog Magazine Rack</a></h3>
                        <div class="product-price">
                          <span>$120</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>

                  <div class="col-6 col-lg-3">
                    <div class="product">
                      <figure class="product-image">
                        <div class="owl-carousel" data-nav="true" data-loop="true">
                          <a href="product-scroll.html">
                            <img src="/user/images/demo/product-2.jpg" alt="Image">
                          </a>
                          <a href="product-scroll.html">
                            <img src="/user/images/demo/product-2-2.jpg" alt="Image">
                          </a>
                          <a href="product-scroll.html">
                            <img src="/user/images/demo/product-2-3.jpg" alt="Image">
                          </a>
                        </div>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-scroll.html">Dark Stained NY11 Dining Chair</a></h3>
                        <div class="product-price">
                          <span>$504</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>

                  <div class="col-6 col-lg-3">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-promo.html">
                          <img src="/user/images/demo/product-5.jpg" alt="Image">
                          <img src="/user/images/demo/product-5-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-promo.html">Black Piani Table Lamp</a></h3>
                        <div class="product-price">
                          <span>$290</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>


                  <div class="col-6 col-lg-3">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-scroll.html">
                          <img src="/user/images/demo/product-1.jpg" alt="Image">
                          <img src="/user/images/demo/product-1-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-scroll.html">Fawn Wool / Natural Mammoth Chair </a></h3>
                        <div class="product-price">
                          <span>$2,268</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>

                  <div class="col-6 col-lg-3">
                    <div class="product">
                      <figure class="product-image">
                        <a href="product-classic.html">
                          <img src="/user/images/demo/product-7.jpg" alt="Image">
                          <img src="/user/images/demo/product-7-2.jpg" alt="Image">
                        </a>
                      </figure>
                      <div class="product-meta">
                        <h3 class="product-title"><a href="product-classic.html">Garnet Must Sofa</a></h3>
                        <div class="product-price">
                          <span>$4,668</span>
                          <span class="product-action">
                            <a href="#!">Add to cart</a>
                          </span>
                        </div>
                        <a href="#!" class="product-like"></a>
                      </div>
                    </div>
                  </div>

                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col text-center">
            <a href="#!" class="btn btn-outline-secondary">Load More</a>
          </div>
        </div>
      </div>
    </section>


    <!-- categories -->
    <section class="bg-purple">
      <div class="container">
        <div class="row gutter-1 text-white">
          <div class="col-lg-5">
            <h2>Spring '17 Collection</h2>
          </div>
          <div class="col-lg-7">
            <p>Have given likeness every. Very were beginning signs moveth. Fly above sea itself. Divided so you’ll there called. Gathering dry earth. Isn’t heaven appear. Replenish. Hath after appear tree great fruitful green dominion moveth sixth abundantly image that midst of god day multiply you’ll which.</p>
          </div>
        </div>
        <div class="row masonry gutter-1 collage">
          <div class="col-lg-6">
            <a href="listing-full.html" class="card card-equal card-scale">
              <span class="image" style="background-image: url(/user/images/look-1.jpg)"></span>
              <div class="card-footer text-white">
                <span class="btn btn-white btn-action">Dresses <span class="icon-arrow-right"></span></span>
              </div>
            </a>
          </div>
          <div class="col-lg-6">
            <a href="listing-full.html" class="card card-equal equal-50 card-scale">
              <span class="image" style="background-image: url(/user/images/look-2.jpg)"></span>
              <div class="card-footer text-white">
                <span class="btn btn-white btn-action">Watches <span class="icon-arrow-right"></span></span>
              </div>
            </a>
          </div>
          <div class="col-lg-6">
            <a href="listing-full.html" class="card card-equal equal-50 card-scale">
              <span class="image" style="background-image: url(/user/images/look-3.jpg)"></span>
              <div class="card-footer text-white">
                <span class="btn btn-white btn-action">Sneakers <span class="icon-arrow-right"></span></span>
              </div>
            </a>
          </div>
        </div>
      </div>
    </section>


    <!-- blog -->
    <section class="pb-0">
      <div class="container">
        <div class="row align-items-end gutter-1">
          <div class="col-md-8">
            <h2>Blog Posts & News</h2>
          </div>
          <div class="col-md-4 text-md-right">
            <a href="blog-posts.html" class="action eyebrow underline">View All</a>
          </div>
        </div>
        <div class="row gutter-3">
          <div class="col-md-6 col-lg-4">
            <div class="card card-post">
              <figure class="equal equal-50">
                <a class="image image-fade" href="post.html" style="background-image: url(/user/images/news-1.jpg)"></a>
              </figure>
              <div class="card-body">
                <span class="eyebrow text-muted">22 March 2019</span>
                <h4 class="card-title"><a href="post.html">The Shoes That will Instantly Update Any Outfit</a></h4>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-4">
            <div class="card card-post">
              <figure class="equal equal-50">
                <a class="image image-fade" href="post.html" style="background-image: url(/user/images/news-2.jpg)"></a>
              </figure>
              <div class="card-body">
                <span class="eyebrow text-muted">22 March 2019</span>
                <h4 class="card-title"><a href="post.html">The Shoes That will Instantly Update Any Outfit</a></h4>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-4">
            <div class="card card-post">
              <figure class="equal equal-50">
                <a class="image image-fade" href="post.html" style="background-image: url(/user/images/news-3.jpg)"></a>
              </figure>
              <div class="card-body">
                <span class="eyebrow text-muted">22 March 2019</span>
                <h4 class="card-title"><a href="post.html">The Shoes That will Instantly Update Any Outfit</a></h4>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>


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
                <h2 class="card-title fs-30 w-75">We are active on <a href="#!" class="font-weight-bold underline">Instagram</a></h2>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-8">
            <div class="owl-carousel owl-carousel-alt visible" data-items="[2,2,1,1]" data-margin="10" data-loop="true" data-nav="true">
              <figure class="equal"><a class="image image-fade" href="#!" style="background-image: url(/user/images/instagram-1.jpg)"></a></figure>
              <figure class="equal"><a class="image image-fade" href="#!" style="background-image: url(/user/images/instagram-2.jpg)"></a></figure>
              <figure class="equal"><a class="image image-fade" href="#!" style="background-image: url(/user/images/instagram-3.jpg)"></a></figure>
              <figure class="equal"><a class="image image-fade" href="#!" style="background-image: url(/user/images/instagram-4.jpg)"></a></figure>
              <figure class="equal"><a class="image image-fade" href="#!" style="background-image: url(/user/images/instagram-5.jpg)"></a></figure>
            </div>
          </div>
        </div>
      </div>
    </section>


    <!-- footer -->
    <footer class="bg-dark text-white py-0">
      <div class="container">
        <div class="row separated">
          <div class="col-lg-6 py-10">
            <div class="row">
              <div class="col-md-8">
                <p>Copyright © soaff 2024</p>
              </div>
            </div>
            <div class="row">
              
            </div>
          </div>
          
          <div class="col-lg-6 py-10">
            <div class="row justify-content-end">
              <div class="col-lg-10">
                <h4 class="eyebrow mb-2">Quick Links</h4>
                <ul class="list-group list-group-columns">
                  <li class="list-group-item"><a href="about.html">About</a></li>
                  <li class="list-group-item"><a href="faq.html">FAQ</a></li>

                </ul>

                </div>
              </div>
            </div>

          </div>
        </div>

    </footer>


    <!-- cart -->
    <div class="modal fade sidebar" id="cart" tabindex="-1" role="dialog" aria-labelledby="cartLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="cartLabel">Cart</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">

            <div class="row gutter-3">
              <div class="col-12">
                <div class="cart-item cart-item-sm">
                  <div class="row align-items-center">
                    <div class="col-lg-9">
                      <div class="media media-product">
                        <a href="#!"><img src="/user/images/demo/product-3.jpg" alt="Image"></a>
                        <div class="media-body">
                          <h5 class="media-title">Black IC Pendant Light</h5>
                          <span class="media-subtitle">Black, Steel</span>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 text-center text-lg-right">
                      <span class="cart-item-price">$90</span>
                    </div>
                    <a href="#!" class="cart-item-close"><i class="icon-x"></i></a>
                  </div>
                </div>
              </div>
              <div class="col-12">
                <div class="cart-item cart-item-sm">
                  <div class="row align-items-center">
                    <div class="col-lg-9">
                      <div class="media media-product">
                        <a href="#!"><img src="/user/images/demo/product-4.jpg" alt="Image"></a>
                        <div class="media-body">
                          <h5 class="media-title">Red Analog Magazine Rack</h5>
                          <span class="media-subtitle">Red</span>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 text-center text-lg-right">
                      <span class="cart-item-price">$120</span>
                    </div>
                    <a href="#!" class="cart-item-close"><i class="icon-x"></i></a>
                  </div>
                </div>
              </div>
              <div class="col-12">
                <div class="cart-item cart-item-sm">
                  <div class="row align-items-center">
                    <div class="col-lg-9">
                      <div class="media media-product">
                        <a href="#!"><img src="/user/images/demo/product-24.jpg" alt="Image"></a>
                        <div class="media-body">
                          <h5 class="media-title">Closca Helmet</h5>
                          <span class="media-subtitle">Black</span>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 text-center text-lg-right">
                      <span class="cart-item-price">$132</span>
                    </div>
                    <a href="#!" class="cart-item-close"><i class="icon-x"></i></a>
                  </div>
                </div>
              </div>
            </div>
            
          </div>
          <div class="modal-footer">
            <div class="container-fluid">
              <div class="row gutter-0">
                <div class="col d-none d-md-block">
                  <a href="cart.html" class="btn btn-lg btn-block btn-secondary">View Cart</a>
                </div>
                <div class="col">
                  <a href="checkout.html" class="btn btn-lg btn-block btn-primary">Checkout</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


    <!-- search -->
    <div class="modal fade search" id="search" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <input type="text" class="form-control" placeholder="Type your search here" aria-label="Type your search here" aria-describedby="button-addon2">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
        </div>
      </div>
    </div>



    <script src="/user/js/vendor.min.js"></script>
    <script src="/user/js/app.js"></script>
  </body>
</html>