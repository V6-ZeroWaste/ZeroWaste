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
											<h2 style="padding: 15px 30px;">
													LOG IN
											</h2>
										</div>

										<div id="collapseOne" class="collapse show" aria-labelledby="headingOne"
											data-parent="#accordionExample">
											<div class="card-body">
												<div class="row mt-2">
													<div class="form-group col-12">
														<label for="exampleInputEmail1">ID</label>
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
																for="customSwitch1">Remeber ID</label>
														</div>
													</div>
													<div class="form-group col-12 mt-1">
														<a href="아이디찾기" style="color: #555555;">아이디 찾기 | </a>
														<a href="비밀번호찾기" style="color: #555555;">비밀번호 찾기</a>
													</div>
													<div class="col-12 mt-2">
														<a href="#!" class="btn btn-block btn-primary">Log In</a>
													</div>
													<div class="col-12 mt-2">
														<a href="#!" class="btn btn-block btn-primary" style="background-color: #79AC78; border-bottom-color: #79AC78; border-top-color: #79AC78; border-left-color: #79AC78; border-right-color : #79AC78;  ">계정 생성</a>
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