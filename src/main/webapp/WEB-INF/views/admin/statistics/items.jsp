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
        <title>상품 통계</title>
        <link href="/admin/css/styles.css" rel="stylesheet" />
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
        <style>
        	/* .sub-card{
        		margin:20px;
        	} */
        	
        </style>
        <script>
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
        
        function drawChart(data){
        	var labels = data.map(d => d.name);
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
        			plugins: {    
        				legend: { // 범례 스타일링      
        					labels: {        
        						usePointStyle: true,        // 범례 도형 모양과 관련된 속성으로, false일 경우엔 기본 직사각형 도형으로 표시됩니다.        
        						padding: 10,        // 범례 간 가로 간격을 조정할 수 있습니다. 범례의 상하 padding을 지정하는 기능은 따로 지원되지 않아요. ㅠㅠ
        					}
        				}
        			},
        	    scales: {
        	        xAxes: [{
        	            stacked: true, // x축을 STACKED 모드로 설정
        	        }],
        	        yAxes: [{
        	            stacked: true, // y축을 STACKED 모드로 설정
        	            barThickness: 15,
            	        maxBarThickness: 15,
            	        
        	            
        	        }],
        			
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
        	$('#chart').remove(); // this is my <canvas> element
			$('#canvas-div').append('<canvas id="chart"><canvas>');
        
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
    	
    	}
        
	    function getList(){
	    	var data = {
	    			searchWord: $('#searchWord').val().trim(),
	    			orderBy: $('#orderBy').val().trim(),
	    			startDate: $('#startDate').val().trim(),
	    			endDate: $('#endDate').val().trim(),
	    			page: page,
	    			entries:  $('#entries').val() 		// 한 페이지에 보일 개수

	    	}
	        
	       	$.ajax({
				type: "GET", // method type
				url: "/admin/statistics/items/getList", // 요청할 url
	            data: data, // 전송할 데이터
	            dataType: "json", // 응답 받을 데이터 type
	            success : function(resp){
	               	// 데이터 리스트 출력
	           		$("#printList").html(resp.printList);
	           		
	               	drawChart(resp.list);
	           		// 페이지네이션 출력
	           		// 총 개수
	           		if($('#entries').val() != 0){
	           			$(".datatable-info").html("Showing "+((page-1)*$('#entries').val()+1)+" to "+(page*$('#entries').val()<=resp.total? page*$('#entries').val() : resp.total)+" of "+resp.total+" entries");
	           		} else {
	           			$(".datatable-info").html("Showing 1 to "+resp.total+" of "+resp.total+" entries");
	           		}
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
	           			printPage += '<a data-page="'+(resp.endPage+1)+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
	           			printPage += '<li class="datatable-pagination-list-item">';
	           			printPage += '<a data-page="'+resp.totalPage+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
	           		}
	           		$(".datatable-pagination-list").html(printPage);
	           		
	               	
	               	
	            },
	            error:function (data, textStatus) {
	                $('#fail').html("관리자에게 문의하세요.") // 서버오류
	                console.log('error', data, textStatus);
	            }
	       	})
	    	
		}
        	
        </script>
        
      
	<title>상품 통계</title>
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
                        	<h1 class="mt-4">상품 통계</h1>
        				</div>
					<div class="card mb-4">
					
						<!-- 리스트 정렬, 필터 검색 영역  -->
								<!-- 리스트 정렬, 필터 검색 영역  -->
								<div class="card-body">
                             	<div>
                             		<div class="datatable-dropdown" style="margin-bottom: 20px">
										<span>조회 날짜</span>
										<input id="startDate" name="startDate" type="date" class="datatable-selector" onchange="applyCondition();">-
										<input id="endDate" name="endDate" type="date" class="datatable-selector" onchange="applyCondition();">
									</div>
                             	</div>
                             	
                            	<div class="datatable-top">

                            		<div class="datatable-dropdown">
							            <label>
							                <select id="orderBy" class="datatable-selector" onchange="applyCondition();">
								                <option value="주문량높은순" selected="">===정렬===</option>
								                <option value="주문량높은순">주문량높은순</option>
								                <option value="주문량낮은순">주문량낮은순</option>
								                <option value="판매량높은순">판매량높은순</option>
								                <option value="판매량낮은순">판매량낮은순</option>
								                <option value="반품률높은순">반품률높은순</option>
								                <option value="반품률낮은순">반품률낮은순</option>
								                <option value="매출액높은순">매출액높은순</option>
								                <option value="매출액낮은순">매출액낮은순</option>
							                </select>
							            </label>
							            
							            <label>
							                <select id="entries" class="datatable-selector" onchange="applyCondition();">
								                <option value="20" selected="">20개</option>
								                <option value="50">50개</option>
								                <option value="100">100개</option>
								                <option value="0">전체</option>
							                </select>
							            </label>
							        </div>
							            
                            		<div class="row align-items-center">
	                                    <div class="col-md-9">
	                                         <input id="searchWord" class="datatable-input" type="search" placeholder="상품 번호/상품명" onkeyup="if(window.event.keyCode==13){applyCondition();}">
	                                    </div>
	                                    
                                    	<div class="col-md-1">
                                        	<input type="button" value="검색" class="btn btn-primary" onclick="applyCondition()"> 
                                      	</div>
                                 	</div>
                            	</div>
					
	        				<!-- 차트영역 -->
	                        <div class="card mb-4 sub-card" >
	                        	
		                        	<div class="card-header" >
		                        		<i class="fas fa-chart-bar me-1"></i>
		                        		chart                            
		                            </div>
	
	                       			<div style=" overflow-y: auto; max-height: 500px;">
		                        		<div id="canvas-div" style="padding:10px;">
											<canvas id="chart"></canvas>
										</div> 
									</div>
	                        </div>
                        
                        
                        

                        
                        <!-- 테이블 -->
                        <div class="card mb-4 sub-card">
                        	<div class="card-header">
                        		<i class="fas fa-table me-1"></i>
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
	                                            <th>반품량</th>
	                                            <th>반품률</th>
	                                            <th>매출액</th>
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
                    </div>
                    </div>
        		</main>
                <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
            </div>
        </div>
	</body>
</html>