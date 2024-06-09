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
        <title>Admin Item List</title>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
        <script src="/admin/js/datatables-simple-demo.js"></script>
        <script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
	</head>
        <body class="sb-nav-fixed">
            <!--header-->
           <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
            <div id="layoutSidenav">
                <!--footer-->
                <%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">상품 관리</h1>
                            
                            <div class="card mb-4">
                                <div class="card-header" >
                                    <i class="fas fa-table me-1"></i>
                                    DataTable Example
                                </div>
                                <div class="card-body">
                                	<table id="datatablesSimple">
									<thead>
										<tr>
										    <th>상품번호</th> <th>상품 이미지</th> <th>상품명</th> <th>상품 가격</th>
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
									            ${item.price}원
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
                                </div>
                            </div>
                        </div>
                    </main>
                     <%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>
                </div>
            </div>
        <script>
	        /* let table = new simpleDatatables.DataTable('#datatablesSimple'); */
	        let table = new DataTable('#datatablesSimple');
	        console.log(table);o
	        /* console.log(table.data.data[0][0]); */
	        /* console.log(table.data.data[0][0].text); */
	        window.onload = function(){
	        	/* console.log(new simpleDatatables.DataTable('#datatablesSimple').data[0]); */
	        	console.log(new DataTable('#datatablesSimple'));
	        }
	        table.on('click', 'tbody tr', function(e){
	        	console.log(e)
	            /* window.location.href = 'detail?item_no='+table.data.data[0]; */
	        })
        </script>
        </body>
</html>
