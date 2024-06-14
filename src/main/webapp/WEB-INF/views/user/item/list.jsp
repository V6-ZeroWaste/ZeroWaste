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
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
  </head>
    <body>
	<!-- latest products -->
	<section>
		<div class="container">
			<div class="row">
				<div class="col text-center">
					<h2>상품 목록</h2>
				</div>
			</div>
            <div class="datatable-dropdown row align-items-center">
                <div class="col-md-8">
                    <label>
                        <select name="orderBy" id="orderBy" class="datatable-selector form-control-sm" onchange="applyCondition();">
                            <option value="신규상품순" <c:if test="${param.orderBy == '신규상품순'}">selected</c:if>>신규상품순</option>
                            <option value="오래된상품순" <c:if test="${param.orderBy == '오래된상품순'}">selected</c:if>>오래된상품순</option>
                            <option value="인기상품순" <c:if test="${param.orderBy == '인기상품순'}">selected</c:if>>인기상품순</option>
                            <option value="할인율높은순" <c:if test="${param.orderBy == '할인율높은순'}">selected</c:if>>할인율높은순</option>
                            <option value="할인율낮은순" <c:if test="${param.orderBy == '할인율낮은순'}">selected</c:if>>할인율낮은순</option>
                            <option value="높은가격순" <c:if test="${param.orderBy == '높은가격순'}">selected</c:if>>높은가격순</option>
                            <option value="낮은가격순" <c:if test="${param.orderBy == '낮은가격순'}">selected</c:if>>낮은가격순</option>
                        </select>
                    </label>
                    <label>
                        <select name="filter" id="filter" class="datatable-selector form-control-sm" onchange="applyCondition();">
                            <option value="">모든 카테고리</option>
                            <c:forEach var="category" items="${categories}">
                                <c:if test="${param.filter == category.category_no}">
                                    <option value="${category.category_no}" selected>${category.name}</option>
                                </c:if>
                                <c:if test="${param.filter != category.category_no}">
                                    <option value="${category.category_no}">${category.name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </label>
                    <label class="text-sm-center">
                         &nbsp; (총 개수) <!-- 리스트에 보이는 부분 말고 검색된 상품의 모든 개수 -->
                    </label>
                </div>
				<div class="col-md-1"></div>
                <!-- search-container 를 searchWord가 있을 때만 보이도록 수정 스크립트로 search-container 영역 [].css("display", "none"); / block -->
                <div class="col-md-3">
                    <div class="form-inline search-container">
                        <input name="searchWord" id="searchWord" class="form-control form-control-sm" type="search"
                               value="${item.searchWord != null ? item.searchWord : ''}" placeholder="검색어 입력">
                        <input type="button" value="검색" class="btn btn-primary btn-sm" onclick="applyCondition();" >
                    </div>
                </div>
            </div>
			<div class="row gutter-2 gutter-md-3">

				<div class="col-6 col-lg-3">
					<div class="product">
						<figure class="product-image">
							<a href="#!">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
							</a>
						</figure>
						<div class="product-meta">
							<h3 class="product-title"><a href="#!">Moss Green T-Four BT Earphones</a></h3>
							<div class="product-price">
								<span>$50</span>
								<span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
							</div>
						</div>
					</div>
				</div>


				<div class="col-6 col-lg-3">
					<div class="product">
						<figure class="product-image">
							<span class="product-promo bg-red">sale</span>
							<a href="#!">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
							</a>
						</figure>
						<div class="product-meta">
							<h3 class="product-title"><a href="#!">Black Closca Helmet</a></h3>
							<div class="product-price">
								<span>$132</span>
								<span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
							</div>
						</div>
					</div>
				</div>


				<div class="col-6 col-lg-3">
					<div class="product">
						<figure class="product-image">
							<a href="#!">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
							</a>
						</figure>
						<div class="product-meta">
							<h3 class="product-title"><a href="#!">Gravel Black Sigg Water Bottle</a></h3>
							<div class="product-price">
								<span>$23</span>
								<span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
							</div>
						</div>
					</div>
				</div>


				<div class="col-6 col-lg-3">
					<div class="product">
						<figure class="product-image">
							<a href="#!">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="image">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="image">
							</a>
						</figure>
						<div class="product-meta">
							<h3 class="product-title"><a href="#!">Black Low Curve Iceman Trimix Sneakers</a></h3>
							<div class="product-price">
								<span>$271</span>
								<span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
							</div>
						</div>
					</div>
				</div>


				<div class="col-6 col-lg-3">
					<div class="product">
						<figure class="product-image">
							<a href="#!">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
							</a>
						</figure>
						<div class="product-meta">
							<h3 class="product-title"><a href="#!">Black / Black V03D Watch</a></h3>
							<div class="product-price">
								<span>$213</span>
								<span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
							</div>
						</div>
					</div>
				</div>


				<div class="col-6 col-lg-3">
					<div class="product">
						<figure class="product-image">
							<a href="#!">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
							</a>
						</figure>
						<div class="product-meta">
							<h3 class="product-title"><a href="#!">Dark Navy Stealth Till Bag</a></h3>
							<div class="product-price">
								<span>$57</span>
								<span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-6 col-lg-3">
					<div class="product">
						<figure class="product-image">
							<span class="product-promo">-10%</span>
							<a href="#!">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
							</a>
						</figure>
						<div class="product-meta">
							<h3 class="product-title"><a href="#!">Black Denim Jacket</a></h3>
							<div class="product-price">
								<span>$183</span>
								<span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-6 col-lg-3">
					<div class="product">
						<figure class="product-image">
							<a href="#!">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
								<img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
							</a>
						</figure>
						<div class="product-meta">
							<h3 class="product-title"><a href="#!">Tan Dellow Cord Sneakers</a></h3>
							<div class="product-price">
								<span>$95</span>
								<span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
							</div>
						</div>
					</div>
				</div>

                <div class="col-6 col-lg-3">
                    <div class="product">
                        <figure class="product-image">
                            <a href="#!">
                                <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
                                <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
                            </a>
                        </figure>
                        <div class="product-meta">
                            <h3 class="product-title"><a href="#!">Tan Dellow Cord Sneakers</a></h3>
                            <div class="product-price">
                                <span>$95</span>
                                <span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-lg-3">
                    <div class="product">
                        <figure class="product-image">
                            <a href="#!">
                                <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
                                <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
                            </a>
                        </figure>
                        <div class="product-meta">
                            <h3 class="product-title"><a href="#!">Tan Dellow Cord Sneakers</a></h3>
                            <div class="product-price">
                                <span>$95</span>
                                <span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-lg-3">
                    <div class="product">
                        <figure class="product-image">
                            <a href="#!">
                                <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
                                <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
                            </a>
                        </figure>
                        <div class="product-meta">
                            <h3 class="product-title"><a href="#!">Tan Dellow Cord Sneakers</a></h3>
                            <div class="product-price">
                                <span>$95</span>
                                <span class="product-action">
                    <a href="#!">Add to cart</a>
                  </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-lg-3">
                    <div class="product">
                        <figure class="product-image">
                            <a href="#!">
                                <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
                                <img src="https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567661387/noticon/zujqqm5y9jxcculmf2fe.gif" alt="Image">
                            </a>
                        </figure>
                        <div class="product-meta">
                            <h3 class="product-title"><a href="#!">Tan Dellow Cord Sneakers</a></h3>
                            <div class="product-price">
                                <span>$95</span>
                                <span class="product-action">
									<a href="#!">Add to cart</a>
								</span>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			<div class="row">
				<div class="col text-center">
<%--					<a href="#!" class="btn btn-outline-secondary">Load More</a>--%>
                    <!-- 페이지 네이션 영역 -->
                    <nav class="item-pagination">
                        <ul class="item-pagination-list">
                            <li>1</li>
                        </ul>
                    </nav>
				</div>
			</div>
		</div>
	</section>

    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
