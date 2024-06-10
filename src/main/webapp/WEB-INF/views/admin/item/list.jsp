<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>상품 목록</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/datatables-simple-demo.js"></script>
        <style>
			.col-item-img {
			    width: 10%;
			    text-align: center;
			}
			
			.img-container {
			    display: flex;
			    justify-content: center;
			    align-items: center;
			    height: 100%;
			}
			
			.fixed-size-img {
			    width: 50px; /* 고정된 너비 */
			    height: auto; /* 비율을 유지하며 높이 자동 조정 */
			}
			.col-item-no,
			.col-item-name,
			.col-item-price,
			.col-item-discount,
			.col-item-category,
			.col-item-amount,
			.col-item-exposed {
			    width: 12.85%;
			}
        </style>
        <script>
	        window.onload = function() {
	            document.querySelectorAll('.itemRow').forEach(function(row) {
	                row.addEventListener('click', function() {
	                    var itemNo = this.getAttribute('data-itemno');
	                    window.location.href = 'detail?item_no=' + itemNo;
	                });
	            });
	
	            document.querySelector('select[name="filter"]').addEventListener('change', function() {
	                this.form.submit();
	            });
	
	            document.querySelector('select[name="orderBy"]').addEventListener('change', function() {
	                this.form.submit();
	            });
	        }
        
	        function regist(){
	            window.location.href = "regist";
	        }
	        
        </script>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
        <div id="layoutSidenav">
        	<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        	<div id="layoutSidenav_content">
        		<main>
        			<div class="container-fluid px-4">
                        <h1 class="mt-4">상품 관리</h1>
                        <div class="card mb-4">

                            <div class="card-body">
                            	<div class="container-fluid px-4 d-flex justify-content-end">
                            	<input type="button" class="btn btn-primary my-2" onclick="regist()" value="등록">
                            	</div>
                             	<!-- 리스트 정렬, 필터 검색 영역  -->
								<form method="get" name="searchForm" id="searchForm" action="list">
										<div class="datatable-dropdown">
											<label>
												<select name="orderBy" class="datatable-selector">
													<option value="등록일자역순" <c:if test="${param.orderBy == '등록일자역순'}">selected</c:if>>등록일자역순</option>
                                                     <option value="등록일자순" <c:if test="${param.orderBy == '등록일자순'}">selected</c:if>>등록일자순</option>
                                                     <option value="재고량많은순" <c:if test="${param.orderBy == '재고량많은순'}">selected</c:if>>재고량많은순</option>
                                                     <option value="재고량적은순" <c:if test="${param.orderBy == '재고량적은순'}">selected</c:if>>재고량적은순</option>
                                                     <option value="판매수량많은순" <c:if test="${param.orderBy == '판매수량많은순'}">selected</c:if>>판매수량많은순</option>
                                                     <option value="판매수량적은순" <c:if test="${param.orderBy == '판매수량적은순'}">selected</c:if>>판매수량적은순</option>
												</select>
											</label>
											<label>
												<select name="filter" class="datatable-selector">
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
											<div class="datatable-top">
												<div class="row align-items-center">
												<div class="col-md-9">
							        				<input name="searchWord" class="datatable-input" type="search" placeholder="상품명/상품 번호 입력" 
    												value="${item.searchWord != null ? item.searchWord : ''}">
							        			</div>
												<div class="col-md-1">
							        				<input type="submit" value="검색" class="btn btn-primary"> 
							        			</div>
												</div>
											</div>
										</div>
							    </form>   
                           	
								
                            	
                            	<!-- 리스트 영역 -->
								<div class="datatable-container">
								    <table class="datatable-table">
								        <thead>
								            <tr>
								                <th class="col-item-no">상품 번호</th>
								                <th class="col-item-img">상품 이미지</th>
								                <th class="col-item-name">상품명</th>
								                <th class="col-item-price">상품 가격</th>
								                <th class="col-item-discount">판매가(할인율)</th>
								                <th class="col-item-category">카테고리</th>
								                <th class="col-item-amount">상품 재고</th>
								                <th class="col-item-exposed">노출 여부</th>
								            </tr>
								        </thead>
								        <tbody>
								            <c:forEach var="item" items="${map.items}">
								                <tr class="itemRow" data-itemno="${item.item_no}">
								                    <td class="col-item-no">
								                        ${item.item_no}
								                    </td>
								                    <td class="col-item-img">
								                        <div class="img-container">
								                            <img src="/upload/item_img/${item.item_img}" class="fixed-size-img"/>
								                        </div>
								                        ${item.item_img}
								                    </td>
								                    <td class="col-item-name">
								                        ${item.name}
								                    </td>
								                    <td class="col-item-price">
								                        ${item.price}
								                    </td>
								                    <td class="col-item-discount">
								                        ${item.discounted_price}
								                        <c:if test="${item.discount_rate != null && item.discount_rate != 0}">
								                            (${item.discount_rate}%)
								                        </c:if>
								                        <c:if test="${item.discount_rate == null || item.discount_rate == 0}">
								                            (-)
								                        </c:if>
								                    </td>
								                    <td class="col-item-category">
								                        ${item.category_name}
								                    </td>
								                    <td class="col-item-amount">
								                        ${item.amount}
								                    </td>
								                    <td class="col-item-exposed">
								                        <c:if test="${item.exposed_status}">
								                            O
								                        </c:if>
								                        <c:if test="${!item.exposed_status}">
								                            X
								                        </c:if>
								                    </td>
								                </tr>
								            </c:forEach>
								        </tbody>
								    </table>
								</div>


                            <!-- 페이지네이션-->
                            <div class="datatable-bottom">
							    <div class="datatable-info">Showing ${item.page} to ${map.totalPage } of ${map.count } entries</div>
							    <nav class="datatable-pagination">
							    	<ul class="datatable-pagination-list">
							    		
							    		<c:if test="${map.isPrev }">
							    			<li class="datatable-pagination-list-item datatable-hidden datatable-disabled">
				                        		<a href="list?page=${map.startPage-1 }&start_date=${item.start_date}&end_date=${item.end_date}&orderBy=${item.orderBy}&filter=${item.filter}&searchWord=${item.searchWord}">‹‹</a>
				                        	</li>
				                        </c:if>
				                        
				                        <c:forEach var="p" begin="${map.startPage}" end="${map.endPage}">
				                        	<c:if test="${p == item.page}">
					                            <li class="datatable-pagination-list-item datatable-active">
					                            	<a href='#;' class='current'>${p}</a>
					                            </li>
				                            </c:if>
				                            <c:if test="${p != item.page}">
					                            <li class="datatable-pagination-list-item datatable-hidden datatable-disabled">
					                            	<a href="list?page=${map.startPage-1 }&start_date=${item.start_date}&end_date=${item.end_date}&orderBy=${item.orderBy}&filter=${item.filter}&searchWord=${item.searchWord}">${p}</a>
					                            </li>
				                            </c:if>
			                        	</c:forEach>

							    	</ul>
							    </nav>
							    </div>
							</div>
                        </div>
                    </div>
        		</main>
                <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
            </div>
        </div>
        
    </body>
</html>