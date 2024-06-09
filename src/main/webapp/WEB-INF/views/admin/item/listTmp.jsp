<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<!-- table -->
<link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css" />
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
<!-- table -->
<link href="/admin/css/styles.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/admin/js/scripts.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
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
    
    $(document).ready(function() {
        /* $('#myTable').DataTable({}); */
        new DataTable('#example');
    });
</script>

</head>
<body>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<input type="button" onclick="regist()" value="등록">
<div id="layoutSidenav">
        	<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        	<div id="layoutSidenav_content">
        		<main>
        		
        		
					<p>${user.user_no}</p>
					<p>${user.name}</p>
        		
        		
        		</main>
        		<div class="orderBy">
				<form action="list" method="get">
				    <div class="orderBy">
				        <select name="orderBy">
						    <option value="등록일자역순" <c:if test="${param.orderBy == '등록일자역순'}">selected</c:if>>등록일자역순</option>
						    <option value="등록일자순" <c:if test="${param.orderBy == '등록일자순'}">selected</c:if>>등록일자순</option>
						    <option value="재고량많은순" <c:if test="${param.orderBy == '재고량많은순'}">selected</c:if>>재고량많은순</option>
						    <option value="재고량적은순" <c:if test="${param.orderBy == '재고량적은순'}">selected</c:if>>재고량적은순</option>
						    <option value="판매수량많은순" <c:if test="${param.orderBy == '판매수량많은순'}">selected</c:if>>판매수량많은순</option>
						    <option value="판매수량적은순" <c:if test="${param.orderBy == '판매수량적은순'}">selected</c:if>>판매수량적은순</option>
						</select>
			    	</div>
			    	<input type="hidden" name="searchWord" value="${param.searchWord}">
			    	<input type="hidden" name="filter" value="${param.filter}">
				</form>
			</div>
			
			<div class="categoryFilter">
			    <!-- 카테고리 필터링을 위한 폼 -->
				<form action="list" method="get">
				    <div class="categoryFilter">
				        <select name="filter">
				            <option value="">모든 카테고리</option>
					            <c:forEach var="category" items="${categories}">
					                <c:if test="${param.filter == category}">
					                    <option value="${category}" selected>${category}</option>
				             	   </c:if>
				                <c:if test="${param.filter != category}">
				                    <option value="${category}">${category}</option>
			                	</c:if>
			            	</c:forEach>
			        	</select>
			    	</div>
			    	<input type="hidden" name="searchWord" value="${param.searchWord}">
			    	<input type="hidden" name="orderBy" value="${param.orderBy}">
				</form>
			</div>
			<table id="myTable" class="table table-striped table-bordered">
			<!-- <table id="example" class="display" style="width:100$"> -->
			<thead>
				<tr>
				    <th>no</th> <th>상품 이미지</th> <th>상품명</th> <th>상품 가격</th>
				    <th>판매가(할인율)</th> <th>카테고리</th> <th>상품 재고</th> <th>노출 여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="item" items="${map.items}">
			    <tr class="itemRow" data-itemno="${item.item_no}">
			        <td>
			            ${item.item_no}
			        </td>
			        <td>
			        	<img src="/upload/item_img/${item.item_img}" alt="Item Image" style="width: 5%"/>
			            ${item.item_img}
			        </td>
			        <td>
			            ${item.name}
			        </td>
			        <td>
			            ${item.price} 
			        </td>
			        <td>
			            ${item.discounted_price}
			            <c:if test="${item.discount_rate != null && item.discount_rate != 0}">
			                (${item.discount_rate}%)
			            </c:if>
			            <c:if test="${item.discount_rate == null || item.discount_rate == 0}">
			                (-)
			            </c:if>
			        </td>
			        <td>
			            ${item.category_name}
			        </td>
			        <td>
			            ${item.amount}
			        </td>
			        <td>
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
				<div class="pagenate clear">
			        <ul class='paging'>
			        <c:if test="${map.prev }">
			        	<li><a href="list.do?page=${map.startPage-1 }&searchType=${item.searchType}&searchWord=${item.searchWord}"> >> </a></li>
			        </c:if>
			        <c:forEach var="p" begin="${map.startPage}" end="${map.endPage}">
			        	<c:if test="${p == item.page}">
			            <li><a href='#;' class='current'>${p}</a></li>
			            </c:if>
			            <c:if test="${p != item.page}">
			            <li><a href='list.do?page=${p}&searchType=${item.searchType}&searchWord=${item.searchWord}'>${p}</a></li>
			            </c:if>
			        </c:forEach>
			        <c:if test="${map.next }">
			        	<li><a href="list.do?page=${map.endPage+1 }&searchType=${item.searchType}&searchWord=${item.searchWord}"> >> </a></li>
			        </c:if>
			        </ul> 
			    </div>
			
			    <!-- 페이지처리 -->
			    <div class="bbsSearch">
			        <form method="get" name="searchForm" id="searchForm" action="list">
			            <span class="searchWord">
			                <input type="text" id="sval" name="searchWord" value="${item.searchWord}"  title="검색어 입력" placeholder="상품명/상품번호 입력" >
			                <input type="submit" id="" value="검색" title="검색">
			                <input type="hidden" name="filter" value="${param.filter}">
			                <input type="hidden" name="orderBy" value="${param.filter}">
			            </span>
			        </form>
			    </div>
                <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
            </div>
        </div>

</body>
</html>