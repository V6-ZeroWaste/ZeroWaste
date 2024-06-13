<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html>
<html lang="en">
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
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
	<script>
	window.onload=function(){
		
		
		let start_date = $('#start_date').val().trim();
		let end_date = $('#end_date').val().trim();
		let page = ${usersVO.page}
		
		getList();
		
		
		if(!start_date){
			var today = new Date();
	
			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);
	
			var dateString = year + '-' + month  + '-' + day;
			start_date = dateString;
			
		};
	
		if(!end_date){
			// 7일 후의 날짜 구하기
			var futureDate = new Date();
			futureDate.setDate(today.getDate() + 7);
	
			var year = futureDate.getFullYear();
			var month = ('0' + (futureDate.getMonth() + 1)).slice(-2);
			var day = ('0' + futureDate.getDate()).slice(-2);
	
			var futureDateString = year + '-' + month + '-' + day;
			end_date = futureDateString;
			
			getList();
			
		};

		
	    function getList(){
	    	var data = {
	    			
	    			orderBy: $('#orderBy').val().trim(),
	    			filter: $('#filter').val().trim(),
	    			start_date: start_date,
	    			end_date: end_date,
	    			page : page
	    			
	
	
	    	}
	        
	       	$.ajax({
				type: "GET", // method type
				url: "/admin/statistics/users/getList", // 요청할 url
	            data: data, // 전송할 데이터
	            dataType: "json", // 응답 받을 데이터 type
	            success : function(resp){
	               	// 데이터 리스트 출력
	           		$("#printList").html(resp.printList);
	           		
	               	drawChart(resp.usersList,resp.leaveList);
               		// 페이지네이션 출력
               		// 총 개수Showing
               		$(".datatable-info").html("Showing "+resp.page+" to "+resp.totalPage+" of "+resp.count+" entries"); 
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
	}
            // 차트 업데이트
            function drawChart(usersList,leaveList) {
            	
            	/////////////////////////////////////////////////////////
            	
            	var labels = usersList.map(obj => obj.date);
	        	var datasets =[
	        		{
	        			label: "회원수",
						data: usersList.map(d => d.user_cnt),
	        			backgroundColor: "#1e306e"
	        		},
	        		{
	        			label: "탈퇴 ",
						data: leaveList.map(d => d.leave_cnt),
	        			backgroundColor: "#C0C0C0"
	        		}
	        	]
	        	
	        	// 차트 옵션 객체 생성
		        	var options = {
			    plugins: {
			        legend: { // 범례 스타일링
			            labels: {
			                usePointStyle: true, // 범례 도형 모양과 관련된 속성으로, false일 경우엔 기본 직사각형 도형으로 표시됩니다.
			                padding: 10 // 범례 간 가로 간격을 조정할 수 있습니다. 범례의 상하 padding을 지정하는 기능은 따로 지원되지 않아요. ㅠㅠ
			            }
			        },
			        tooltip: {
			            callbacks: {
			                label: function (tooltipItem) {
			                    var datasetLabel = tooltipItem.dataset.label || '';
			                    var value = tooltipItem.raw;
			                    if (value === 0) {
			                        // Hide tooltip for 0 values
			                        return '';
			                    }
			                    return datasetLabel + ': ' + value;
			                }
			            }
			        }
			    },
			    scales: {
			        x: {
			            stacked: true // x축을 STACKED 모드로 설정
			        },
			        y: {
			            stacked: true, // y축을 STACKED 모드로 설정
			            barThickness: 15,
			            maxBarThickness: 15
			        }
			    }
			};

	        	
	        	// 캔버스 요소 선택
	        	$('#myAreaChart').remove(); // this is my <canvas> element
				$('#canvas-div').append('<canvas id="myAreaChart"><canvas>');
	        
	        	var ctx = document.getElementById("myAreaChart").getContext("2d");
	        	
	        	// 차트 객체 생성
	        	var myChart = new Chart(ctx, {
	        	    type: "bar", // 가로막대 그래프 타입 설정
	        	    data: {
	        	        labels: labels,
	        	        datasets: datasets
	        	    },
	        	    options: options
	        	});
	    	
	    	}
            	////////////////////////////////////////////////////////
            	
            	
            	
            	
            	
            	
 
    </script>
<body>
    <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
    <div id="layoutSidenav">
        <%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">회원 통계</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                    
                    <!-- 정렬, 필터 -->
                    <div class="datatable-dropdown">
                        <div class="col-md-8">
                            <label>
                                <select name="orderBy" id="orderBy" class="datatable-selector orderBy" style="margin-bottom: 15px">
                                    <option value="최근날짜순"  <c:if test="${empty param.orderBy == '최근날짜순'}">selected</c:if>>최근날짜순</option>
                                    <option value="오래된순" <c:if test="${param.orderBy == '오래된순'}">selected</c:if>>오래된순</option>
                                </select>
                            </label>
                            <label>
					            <select name="filter" id="filter" class="datatable-selector filter" >
					                <option value="일별" <c:if test="${empty param.filter == '일별'}">selected</c:if>>일별</option>
                                    <option value="주별" <c:if test="${param.filter == '주별'}">selected</c:if>>주별</option>
                                    <option value="월별" <c:if test="${param.filter == '월별'}">selected</c:if>>월별</option>
					            </select>
					        </label>
                        </div>
                        <div class="col-md-8">
                            <div class="datatable-dropdown" style="margin-bottom: 15px" >
                               	<input id="start_date" name="start_date" type="date" class="datatable-selector dateInput">-<input id="end_date" name="end_date" type="date" class="datatable-selector dateInput">
                            <button class="btn btn-primary applyButton" onclick="getList();">검색</button>
                            </div>
                        </div>
                        
                        
                        
                    </div>
                    
                    <div class="row">
                        <div class="col-xl-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-chart-area me-1"></i>
                                    Area Chart Example
                                </div>
                                <div class="card-body">
                                	<div id="canvas-div">
                                	<canvas id="myAreaChart" width="100%" height="40"></canvas>
                                	</div>
                                	</div>
                            </div>
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            DataTable Example
                        </div>
                        <div class="card-body">
                            <div class="datatable-container">
                                <table class="datatable-table">
                                    <thead>
                                        <tr>
                                            <th class="col-sales-date">날짜</th>
                                            <th class="col-sales-sales">회원수</th>
                                            <th class="col-sales-sales">탈퇴한 회원수</th>
                                        </tr>
                                    </thead>
                                    <tbody id="printList"></tbody>
                                </table>
                            </div>
	                        <div class="datatable-bottom">
	                            <div class="datatable-info">Showing ${vo.page} to ${map.totalPage } of ${map.total} entries</div>
	                            <nav class="datatable-pagination">
	                                <ul class="datatable-pagination-list"></ul>
	                            </nav>
	                        </div>
                        </div>
                        <!-- 페이지네이션-->
                    </div>
                </div>
            </main>
            <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
        </div>
    </div>

</body>
</html>