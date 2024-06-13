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

				<title>soaff</title>
				<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
			</head>

			<body>

				<section class="py-md-0">
					<div class="image image-overlay" style="background-image:url(/user/images/main_test1.png)"></div>
					<div class="container">
						<div class="row justify-content-center align-items-center vh-md-100">
							<div class="col-md-10 col-lg-5">
								<div class="accordion accordion-portal" id="accordionExample">
									<div id="loginPopup" class="card active">
										<div class="card-header" id="headingOne">
											<h2 class="mb-0">
												<button class="btn btn-link" type="button" data-toggle="collapse"
													data-target="#collapseOne" aria-expanded="true"
													aria-controls="collapseOne">
													Sign In
												</button>
											</h2>
										</div>

										<div id="collapseOne" class="collapse show" aria-labelledby="headingOne"
											data-parent="#accordionExample">
											<div class="card-body">
												<div class="row mt-2">
													<div class="form-group col-12">
														<label for="exampleInputEmail1">Email address</label>
														<input type="email" class="form-control"
															id="exampleInputEmail1">
													</div>
													<div class="form-group col-12 mt-1">
														<label for="exampleInputPassword1">Password</label>
														<input type="password" class="form-control"
															id="exampleInputPassword1">
													</div>
													<div class="col-12 mt-1">
														<div class="custom-control custom-switch mb-2">
															<input type="checkbox" class="custom-control-input"
																id="customSwitch1">
															<label class="custom-control-label"
																for="customSwitch1">Toggle this switch element</label>
														</div>
													</div>
													<div class="col-12 mt-2">
														<a href="#!" class="btn btn-block btn-primary">Log In</a>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="card">
										<div class="card-header" id="headingTwo">
											<h2 class="mb-0">
												<button class="btn btn-link collapsed" type="button"
													data-toggle="collapse" data-target="#collapseTwo"
													aria-expanded="false" aria-controls="collapseTwo">
													Create Account
												</button>
											</h2>
										</div>
										<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
											data-parent="#accordionExample">
											<div class="card-body">
												<div class="row mt-2">
													<div class="form-group col-12">
														<label for="exampleInputEmail2">Email address</label>
														<input type="email" class="form-control"
															id="exampleInputEmail2">
													</div>
													<div class="form-group col-12 mt-1">
														<label for="exampleInputPassword3">Password</label>
														<input type="password" class="form-control"
															id="exampleInputPassword3">
													</div>
													<div class="form-group col-12 mt-1">
														<label for="exampleInputPassword4">Repeat Password</label>
														<input type="password" class="form-control"
															id="exampleInputPassword4">
													</div>
													<div class="col-12 mt-2">
														<a href="#!" class="btn btn-block btn-primary">Register</a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>

				<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
			</body>

			</html>