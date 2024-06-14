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

<!-- breadcrumbs -->
<section class="breadcrumbs separator-bottom">
    <div class="container">
        <div class="row">
            <div class="col">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                        <li class="breadcrumb-item"><a href="listing-sidebar.html">Shop</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Invoice</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>

<!-- hero -->
<section>
    <div class="container">
        <div class="row">
            <div class="col text-center">
                <h1>Invoice</h1>
            </div>
        </div>
    </div>
</section>

<section class="no-overflow pt-0">
    <div class="container">
        <div class="row gutter-4 justify-content-between">


            <div class="col-lg-8">

                <!-- delivery -->
                <div class="row align-items-end mb-2">
                    <div class="col-md-6">
                        <h2 class="h3 mb-0"><span class="text-muted">01.</span> Address</h2>
                    </div>
                    <div class="col-md-6 text-md-right">
                        <a class="eyebrow unedrline action" data-toggle="modal" data-target="#addresses">My
                            Addresses</a>
                    </div>
                </div>
                <div class="row gutter-1 mb-6">
                    <div class="form-group col-md-6">
                        <label for="firstName">First Name</label>
                        <input type="text" class="form-control" id="firstName" placeholder="">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="lastName">Last Name</label>
                        <input type="text" class="form-control" id="lastName" placeholder="">
                    </div>
                    <div class="form-group col">
                        <label for="companyName">Company Name</label>
                        <input type="text" class="form-control" id="companyName" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="country">Country</label>
                        <input type="text" class="form-control" id="country" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="city">City</label>
                        <input type="text" class="form-control" id="city" placeholder="">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="postcode">Postcode</label>
                        <input type="text" class="form-control" id="postcode" placeholder="">
                    </div>
                    <div class="form-group col-md-8">
                        <label for="address">Address</label>
                        <input type="text" class="form-control" id="address" placeholder="">
                    </div>
                </div>

                <!-- payment -->
                <div class="row align-items-end mb-2">
                    <div class="col-md-6">
                        <h2 class="h3 mb-0"><span class="text-muted">02.</span> Payment</h2>
                    </div>
                    <div class="col-md-6 text-md-right">
                        <a class="eyebrow unedrline action" data-toggle="modal" data-target="#payments">My payment
                            methods</a>
                    </div>
                </div>
                <div class="row gutter-1 mb-6">
                    <div class="col-12 pb-1">
                        <ul class="nav nav-tabs lavalamp" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab"
                                   aria-controls="home" aria-selected="true">Credit Card</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab"
                                   aria-controls="profile" aria-selected="false">PayPal</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-12">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <div class="row gutter-1">
                                    <div class="form-group col-12">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="basic-addon1"><i
                                                        class="icon-credit-card"></i></span>
                                            </div>
                                            <input type="tel" class="form-control" placeholder="Card Number"
                                                   aria-label="Username" aria-describedby="basic-addon1">
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="nameOnCard">Name on Card</label>
                                        <input type="text" class="form-control" id="nameOnCard" placeholder="">
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="month">Month</label>
                                        <input type="date" class="form-control" id="month">
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label for="cvv">CVV</label>
                                        <input type="password" class="form-control" id="cvv" placeholder="">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <div class="row gutter-1">
                                    <div class="form-group col-md-8">
                                        <input type="email" class="form-control" id="mail" placeholder="Email">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <a href="#!" class="btn btn-block btn-secondary">Pay with paypal</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="custom-control custom-switch mb-2">
                            <input type="checkbox" class="custom-control-input" id="customSwitch1">
                            <label class="custom-control-label text-muted" for="customSwitch1">Billing address same as
                                delivery.</label>
                        </div>
                    </div>
                </div>

                <!-- shipping -->
                <div class="row align-items-end mb-2">
                    <div class="col-md-6">
                        <h2 class="h3 mb-0"><span class="text-muted">03.</span> Shipping</h2>
                    </div>
                </div>
                <div class="row gutter-1">
                    <div class="col-md-6">
                        <div class="custom-control custom-choice">
                            <input type="radio" name="choice-shipping" class="custom-control-input"
                                   id="choice-shipping-1">
                            <label class="custom-control-label text-dark" for="choice-shipping-1">
                                <span class="d-flex justify-content-between mb-1 eyebrow">Standard <span
                                        class="text-muted">Free</span></span>
                                Estimated 10-20 days shipping. Lorem Ipsum is simply dummy text of the printing and
                                typesetting.
                            </label>
                            <span class="choice-indicator"></span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="custom-control custom-choice">
                            <input type="radio" name="choice-shipping" class="custom-control-input"
                                   id="choice-shipping-2">
                            <label class="custom-control-label text-dark" for="choice-shipping-2">
                                <span class="d-flex justify-content-between mb-1 eyebrow">Express <span
                                        class="text-muted">$49</span></span>
                                Estimated 10-20 days shipping. Lorem Ipsum is simply dummy text of the printing and
                                typesetting.
                            </label>
                            <span class="choice-indicator"></span>
                        </div>
                    </div>
                </div>
            </div>


            <aside class="col-lg-4">
                <div class="row">

                    <!-- order preview -->
                    <div class="col-12">
                        <div class="card card-data bg-light">
                            <div class="card-header py-2 px-3">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <h3 class="fs-18 mb-0">Your Cart</h3>
                                    </div>
                                    <div class="col text-right">
                                        <a href="cart.html" class="underline eyebrow">Edit</a>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-line">
                                    <li class="list-group-item d-flex justify-content-between text-dark align-items-center">
                                        Analog Magazine Rack x2
                                        <span>$240</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between text-dark align-items-center">
                                        Closca Helmet
                                        <span>$132</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between text-dark align-items-center">
                                        Sigg Water Bottle x2
                                        <span>$46</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- order summary -->
                    <div class="col-12 mt-1">
                        <div class="card card-data bg-light">
                            <div class="card-header py-2 px-3">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <h3 class="fs-18 mb-0">Order Summary</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-minimal">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Subtotal
                                        <span>$418</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Shipping
                                        <span>Free</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Discount
                                        <span>-25%</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="card-footer py-2">
                                <ul class="list-group list-group-minimal">
                                    <li class="list-group-item d-flex justify-content-between align-items-center text-dark fs-18">
                                        Total
                                        <span>$313,5</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- place order -->
                    <div class="col-12 mt-1">
                        <a href="#!" class="btn btn-primary btn-lg btn-block">Place Order</a>
                    </div>

                </div>
            </aside>

        </div>
    </div>
</section>


<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
