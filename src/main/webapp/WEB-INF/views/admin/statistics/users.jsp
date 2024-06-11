<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>회원 통계</title>
        <link href="/admin/css/styles.css" rel="stylesheet" />
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
	<title>회원 통계</title>
	</head>
	<body>
		<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
        <div id="layoutSidenav">
        	<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        	<div id="layoutSidenav_content">
        		<main>
					<div class="container-fluid px-4">
        				<!-- 제목 -->
        				<div class="title">
                        	<h1 class="mt-4">회원 통계</h1>
        				</div>

        				<!-- 회원영역 -->
                        <div class="card mb-4">
                        	<div class="card-header">
                        		<i class="fas fa-chart-bar me-1"></i>
                        		chart                            
                            </div>
                        <div class="datatable-dropdown">   
                        <div class="card-body"> 
							<select id="filter" name="filter" class="datatable-selector" onchange="applyCondition();">
								<option value="" >==필터==</option>
								<option value="0" >일별 통계</option>
								<option value="1" >월별 통계</option>
								<option value="2" <c:if test="${orderVO.filter == 2}">selected</c:if>>상품준비중</option>
								<option value="3" >주별 통계</option>
							</select>
                       		<input type = "date" class = "datatable-selector" <c:if test="${usersVO.filter == 'date'}">selected</c:if>>
                       		<input type = "week" class = "datatable-selector" <c:if test="${usersVO.filter == 'week'}">selected</c:if>>
                       		<input type = "month" class = "datatable-selector" <c:if test="${usersVO.filter == 'month'}">selected</c:if>>
							<canvas id="chart"></canvas>
								</div> 
                        	</div>
                       	</div>
                    </div>
                <div>
                        
                        

                        
                        <!-- 테이블 -->
                        
                        <div class="card mb-4">
                        	<div class="card-header">
                                table
                            </div>
                        	<div class="card-body">
                        		<div class="datatable-top">
                            		
                            	</div>
                        		<div class="datatable-container">
                        			
	                                <table class="datatable-table">
	                                    <thead>
	                                        <tr>
	                                            <th>상품 번호</th>
	                                            <th>상품명</th>
	                                            <th>주문량</th>
	                                            <th>판매량</th>
	                                            <th>주문번호</th>
	                                            <th>적용일시</th>
	                                            <th>삭제</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="printList">
	                                    
	                                    </tbody>
	                                </table>
                            	</div>
                            	<!-- 페이지네이션 영역 -->
	                            <div class="datatable-bottom">
								    <div class="datatable-info"></div>
								    <nav class="datatable-pagination">
								    	<ul class="datatable-pagination-list">                    
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
	
	
	
	

		<script>
        	var data = [
        		{
        			item_name : "상품1",
        			sales: 25,
        			cancel: 2,
        			
        		},
        		{
        			item_name : "상품2",
        			sales: 10,
        			cancel: 1,
        			
        		},
        		{
        			item_name : "상품3",
        			sales: 50,
        			cancel: 3,
        			
        		},
        		{
        			item_name : "상품4",
        			sales: 60,
        			cancel: 3,
        			
        		},
        	]
        	
        	var labels = data.map(d => d.item_name);
        	var datasets =[
        		{
        			label: "판매량",
					data: data.map(d => d.sales),
        			backgroundColor: "#1e306e"
        		},
        		{
        			label: "취소량",
					data: data.map(d => d.cancel),
        			backgroundColor: "#C0C0C0"
        		}
        	]
        	
        	// 차트 옵션 객체 생성
        	var options = {
        	    scales: {
        	        xAxes: [{
        	            stacked: true // x축을 STACKED 모드로 설정
        	        }],
        	        yAxes: [{
        	            stacked: true // y축을 STACKED 모드로 설정
        	        }]
        	    },
        	    tooltips: {
        	        callbacks: {
        	            label: function (tooltipItem, data) {
        	                var datasetLabel = data.datasets[tooltipItem.datasetIndex].label || '';
        	                var value = tooltipItem.xLabel;
        	                if (value === 0) {
	        	                // Hide tooltip for 0 values
	        	                return '';
	        	            }
	        	           	return datasetLabel + ': ' + value;
        	            },
        	        },
        	    },
        	};
        	
        	// 캔버스 요소 선택
        	var ctx = document.getElementById("chart").getContext("2d");

        	// 차트 객체 생성
        	var myChart = new Chart(ctx, {
        	    type: "horizontalBar", // 가로막대 그래프 타입 설정
        	    data: {
        	        labels: labels,
        	        datasets: datasets
        	    },
        	    options: options
        	});
        </script>
	</body>
</html>