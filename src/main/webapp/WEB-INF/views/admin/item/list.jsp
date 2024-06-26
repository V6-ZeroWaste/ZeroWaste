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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
			.col-item-salesAmount,
			.col-item-exposed {
			    width: 11.25%;
			}

			.button-container {
				display: flex;
				justify-content: flex-end;
			}
		</style>
        <script>
        
	        function regist(){
	            window.location.href = "regist";
	        }
	        
	        let page = 1;
	        window.onload=function(){
	        	  getList();
	        	}
	        function applyCondition(){
	       		page = 1;
	       		getList();
	        }
	        function changePage(obj){
	       		page = obj.getAttribute("data-page");
	       		getList();
	        }
	        
	        function getList(){
	        	var data = {
	        			searchWord: $('#searchWord').val(),
	        			orderBy: $('#orderBy').val(),
	        			filter: $('#filter').val(),
	        			page: page,
	        		
	        	}
	            
	           	$.ajax({
					type: "GET", // method type
					url: "/admin/item/getList", // 요청할 url
	                data: data, // 전송할 데이터
	                dataType: "json", // 응답 받을 데이터 type
	                success : function(resp){
	                   	// 데이터 리스트 출력
					   renderItemList(resp.items);
	               		
	               		// 페이지네이션 출력
	               		// 총 개수
	               		$(".datatable-info").html("Showing "+((page-1)*20+1)+" to "+(page*20<=resp.total? page*20 : resp.total)+" of "+resp.total+" entries"); 
	               		// 페이지네이션
	               		let printPage = "";
	               		if(resp.isPrev){
	               			printPage += '<li class="datatable-pagination-list-item">';
	               			printPage += '<a data-page="1" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
	               			printPage += '<li class="datatable-pagination-list-item">';
	               			printPage += '<a data-page="'+(resp.startPage-1)+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
	               		}
	               		for(i = resp.startPage; i<=resp.endPage; i++){
	               			printPage += '<li class="datatable-pagination-list-item'+(i==page? ' datatable-active' : '')+'">';
	               			printPage += '<a data-page="'+ i +'" class="datatable-pagination-list-item-link" onclick="changePage(this);">'+i+'</a></li>';
	               		}
	               		if(resp.isNext){
	               			printPage += '<li class="datatable-pagination-list-item">';
	               			printPage += '<a data-page="'+(resp.endPage+1)+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">›</a></li>';
	               			printPage += '<li class="datatable-pagination-list-item">';
	               			printPage += '<a data-page="'+resp.totalPage+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">››</a></li>';
	               		}
	               		$(".datatable-pagination-list").html(printPage);
	               		
	                   	
	                   	
	                },
	                error:function (data, textStatus) {
	                    $('#fail').html("관리자에게 문의하세요.") // 서버오류
	                }
	           	})
	        	
			}

			function renderItemList(items) {
				var printList = "";

				if (items.length > 0) {
					items.forEach(function(item) {
						printList += "<tr class='itemRow' onclick=\"location.href='/admin/item/detail?item_no=" + item.item_no + "'\">";
						printList += "<td class=\"col-item-no\">" + item.item_no + "</td>";

						printList += "<td class=\"col-item-img\">";
						printList += "<div class='img-container'>";
						if (item.item_img != null && item.item_img !== "") {
							printList += "<img src='" + item.item_img + "' class='fixed-size-img'/>";
						}
						printList += "</div>";
						printList += "</td>";

						printList += "<td class=\"col-item-name\">" + item.name + "</td>";
						printList += "<td class=\"col-item-price\">" + item.price + "</td>";

						printList += "<td class=\"col-item-discount\">";
						printList += item.discounted_price;
						printList += item.discount_rate == 0 ? "(-)" : "(" + item.discount_rate + "%)";
						printList += "</td>";

						printList += "<td class=\"col-item-category\">" + item.category_name + "</td>";
						printList += "<td class=\"col-item-amount\">" + item.amount + "</td>";

						printList += "<td class=\"col-item-exposed\">";
						printList += item.exposed_status ? "O" : "X";
						printList += "</td>";

						printList += "<td class=\"col-item-exposed\">";
						printList += item.sales_amount;
						printList += "</td>";

						printList += "</tr>";
					});
				}
				else{
					printList = "<td class='first' colspan='9' style='text-align: center;'>등록된 글이 없습니다.</td>";
				}
				$("#printList").html(printList);
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
                        <div class="button-container">
	                        <input type="button" class="btn btn-primary my-2" onclick="regist()" value="등록">
                        </div>
                        <div class="card mb-4">
                            <div class="card-body">
                            	<div class="container-fluid px-4 d-flex justify-content-end">
                            	</div>
                            	<!-- 리스트 정렬, 필터 검색 영역  -->
								<div class="datatable-dropdown row align-items-center">
								    <div class="col-md-8">
								        <label>
								            <select name="orderBy" id="orderBy" class="datatable-selector" onchange="applyCondition();">
								                <option value="최신순" <c:if test="${param.orderBy == '최신순'}">selected</c:if>>최신순</option>
								                <option value="오래된순" <c:if test="${param.orderBy == '오래된순'}">selected</c:if>>오래된순</option>
								                <option value="재고량많은순" <c:if test="${param.orderBy == '재고량많은순'}">selected</c:if>>재고량많은순</option>
								                <option value="재고량적은순" <c:if test="${param.orderBy == '재고량적은순'}">selected</c:if>>재고량적은순</option>
								                <option value="판매수량많은순" <c:if test="${param.orderBy == '판매수량많은순'}">selected</c:if>>판매수량많은순</option>
								                <option value="판매수량적은순" <c:if test="${param.orderBy == '판매수량적은순'}">selected</c:if>>판매수량적은순</option>
								            </select>
								        </label>
								        <label>
								            <select name="filter" id="filter" class="datatable-selector" onchange="applyCondition();">
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
								    </div>
								    <div class="col-md-3">
								        <div class="form-inline">
								            <input name="searchWord" id="searchWord" class="datatable-input" type="search" placeholder="상품명/상품 번호 입력" 
								                value="${item.searchWord != null ? item.searchWord : ''}">
								        </div>
								    </div>
								    <div class="col-md-1">
								    	<input type="button" value="검색" class="btn btn-primary" onclick="applyCondition();">
								    </div>
								</div>
								<br>
								
                            	
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
								                <th class="col-item-salesAmount">판매 수량</th>
								            </tr>
								        </thead>
								        <tbody id="printList">
								        	
								        </tbody>
								    </table>
								</div>


                            <!-- 페이지네이션-->
                            <div class="datatable-bottom">
							    <div class="datatable-info">Showing ${item.page} to ${map.totalPage } of ${map.count } entries</div>
							    <nav class="datatable-pagination">
							    	<ul class="datatable-pagination-list">
							    	</ul>
							    </nav>
							    </div>
							</div>
                        </div>
                    </div>
        		</main>
                <%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>
            </div>
        </div>
        
    </body>
</html>