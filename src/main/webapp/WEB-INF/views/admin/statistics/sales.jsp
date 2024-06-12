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
    <title>매출 통계</title>
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
		var isDateChanged = false;
	
        document.addEventListener('DOMContentLoaded', function() {
        	if(!isDateChanged){
				changeDefaultDate();
				isDateChanged = true;				
			}
            // 차트 초기화
            var myAreaChart;
            var myBarChart;

            function applyCondition() {
                page = 1;
                getList();
            }

            function changePage(obj) {
                page = parseInt(obj.getAttribute("data-page"), 10);
                getList();
            }

            function getList() {
            	
                var data = {
                    orderBy: $('#orderBy').val(),
                    filter: $('#filter').val(),
                    start_date: $('#start_date').val(),
                    end_date: $('#end_date').val(),
                    page: page,
                };

                $.ajax({
                    type: "GET",
                    url: "/admin/statistics/sales/getList",
                    data: data,
                    dataType: "json",
                    success: function(resp) {
                        console.log("AJAX 응답:", resp);

                        $("#printList").html(resp.printList);

                        $(".datatable-info").html("Showing " + resp.page + " to " + resp.totalPage + " of " + resp.count + " entries");

                        var printPage = "";
                        if (resp.isPrev) {
                            printPage += '<li class="datatable-pagination-list-item">';
                            printPage += '<a data-page="1" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹‹</a></li>';
                            printPage += '<li class="datatable-pagination-list-item">';
                            printPage += '<a data-page="' + (resp.startPage - 1) + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">‹</a></li>';
                        }
                        for (let i = resp.startPage; i <= resp.endPage; i++) {
                            printPage += '<li class="datatable-pagination-list-item' + (i == page ? ' datatable-active' : '') + '">';
                            printPage += '<a data-page="' + i + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">' + i + '</a></li>';
                        }
                        if (resp.isNext) {
                            printPage += '<li class="datatable-pagination-list-item">';
                            printPage += '<a data-page="' + (resp.endPage + 1) + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">›</a></li>';
                            printPage += '<li class="datatable-pagination-list-item">';
                            printPage += '<a data-page="' + resp.totalPage + '" class="datatable-pagination-list-item-link" onclick="changePage(this);">››</a></li>';
                        }
                        $(".datatable-pagination-list").html(printPage);
						
                        drawCharts(resp.list);
                    },
                    error: function(data, textStatus) {
                        $('#fail').html("관리자에게 문의하세요.");
                        console.log('error', data, textStatus);
                    }
                });
                
            }

            // 차트 업데이트
            function drawCharts(salesList) {
                var labels = [];
                var data = [];

                salesList.reverse().forEach(function(item) {
                    labels.push(item.date);
                    data.push(item.sales);
                });

                if (myAreaChart) {
                    myAreaChart.destroy();
                }

                var ctx = document.getElementById("myAreaChart").getContext('2d');
                myAreaChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: "매출액",
                            data: data,
                            backgroundColor: "rgba(2,117,216,0.2)",
                            borderColor: "rgba(2,117,216,1)",
                            pointRadius: 5,
                            pointBackgroundColor: "rgba(2,117,216,1)",
                            pointBorderColor: "rgba(255,255,255,0.8)",
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(2,117,216,1)",
                            pointHitRadius: 20,
                            pointBorderWidth: 2,
                            lineTension: 0.3,
                        }],
                    },
                    options: {
                        scales: {
                            x: {
                                time: {
                                    unit: 'date'
                                },
                                grid: {
                                    display: false
                                },
                                ticks: {
                                    /* maxTicksLimit: data.length */
                                }
                            },
                            y: {
                                ticks: {
                                    min: 0,
                                    max: 100,
                                    maxTicksLimit: 5
                                },
                                grid: {
                                    color: "rgba(0, 0, 0, .125)",
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                display: false
                            }
                        }
                    }
                });

                if (myBarChart) {
                    myBarChart.destroy();
                }

                var ctx = document.getElementById("myBarChart").getContext('2d');
                myBarChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: "Dataset",
                            data: data,
                            backgroundColor: "rgba(2,117,216,1)",
                            borderColor: "rgba(2,117,216,1)",
                        }],
                    },
                    options: {
                        scales: {
                            x: {
                                time: {
                                    unit: 'month'
                                },
                                grid: {
                                    display: false
                                },
                                ticks: {
                                    maxTicksLimit: 6
                                }
                            },
                            y: {
                                ticks: {
                                    min: 0,
                                    max: 100,
                                    maxTicksLimit: 5
                                },
                                grid: {
                                    color: "rgba(0, 0, 0, .125)",
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                display: false
                            }
                        }
                    }
                });
            }
            
            function changeDefaultDate() {
                var filter = $('#filter').val();
                var startDateInput = $('#start_date');
                var endDateInput = $('#end_date');

                // 현재 날짜 생성
                var currentDate = new Date();
                
                // 현재 날짜에서 10일, 10주, 10개월을 빼기 위한 변수들
                var startDate = new Date(currentDate);
                var startWeek = new Date(currentDate);
                var startMonth = new Date(currentDate);
                
                startDate.setDate(currentDate.getDate() - 10); // 10일 빼기
                startWeek.setDate(currentDate.getDate() - (10 * 7)); // 10주 빼기
                startMonth.setMonth(currentDate.getMonth() - 10); // 10개월 빼기
                
                // 날짜를 포맷에 맞게 문자열로 변환하는 함수
                function formatDate(date) {
                    var year = date.getFullYear();
                    var month = ('0' + (date.getMonth() + 1)).slice(-2);
                    var day = ('0' + date.getDate()).slice(-2);
                    return year + '-' + month + '-' + day;
                }
                
                // 주를 포맷에 맞게 문자열로 변환하는 함수 (ISO 8601 주 형식)
                function formatWeek(date) {
                    var year = date.getFullYear();
                    var month = date.getMonth() + 1;
                    var day = date.getDate();
                    // 주 번호 계산
                    var oneJan = new Date(date.getFullYear(), 0, 1);
                    var numberOfDays = Math.floor((date - oneJan) / (24 * 60 * 60 * 1000));
                    var week = Math.ceil((numberOfDays + oneJan.getDay() + 1) / 7);
                    return year + '-W' + ('0' + week).slice(-2);
                }
                
                // 월을 포맷에 맞게 문자열로 변환하는 함수
                function formatMonth(date) {
                    var year = date.getFullYear();
                    var month = ('0' + (date.getMonth() + 1)).slice(-2);
                    return year + '-' + month;
                }
                
                if (filter === '일별') {
                    startDateInput.val(formatDate(startDate));
                    endDateInput.val(formatDate(currentDate));
                } else if (filter === '주별') {
                    startDateInput.val(formatWeek(startWeek));
                    endDateInput.val(formatWeek(currentDate));
                } else if (filter === '월별') {
                    startDateInput.val(formatMonth(startMonth));
                    endDateInput.val(formatMonth(currentDate));
                }
            }
            
         	// 필터 값 변경 시 입력 필드 유형 변경
            $('#filter').on('change', function() {
				
                var filter = $(this).val();
                var startDateInput = $('#start_date');
                var endDateInput = $('#end_date');
                
                
                if (filter === '일별') {
                    startDateInput.attr('type', 'date');
                    endDateInput.attr('type', 'date');
                } else if (filter === '주별') {
                    startDateInput.attr('type', 'week');
                    endDateInput.attr('type', 'week');
                } else if (filter === '월별') {
                    startDateInput.attr('type', 'month');
                    endDateInput.attr('type', 'month');
                }
                changeDefaultDate();
                applyCondition();
            });

            // Initialize data
            var page = 1;
            getList();
            
            $('.dateInput').on('change', applyCondition);
            $('.applyButton').on('click', applyCondition);
            $('.orderBy').on('change', applyCondition);
        });
    </script>
<body>
    <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
    <div id="layoutSidenav">
        <%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">매출 통계</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                    <div class="row">
                        <div class="col-xl-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-chart-area me-1"></i>
                                    Area Chart Example
                                </div>
                                <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
                            </div>
                        </div>
                        <div class="col-xl-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-chart-bar me-1"></i>
                                    Bar Chart Example
                                </div>
                                <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 정렬, 필터 -->
                    <div class="datatable-dropdown row align-items-center">
                        <div class="col-md-8">
                            <label>
                                <select name="orderBy" id="orderBy" class="datatable-selector orderBy">
                                    <option value="최근날짜순" <c:if test="${param.orderBy == '최근날짜순'}">selected</c:if>>최근날짜순</option>
                                    <option value="오래된순" <c:if test="${param.orderBy == '오래된순'}">selected</c:if>>오래된순</option>
                                    <option value="매출량많은순" <c:if test="${param.orderBy == '매출량많은순'}">selected</c:if>>매출량많은순</option>
                                    <option value="매출량적은순" <c:if test="${param.orderBy == '매출량적은순'}">selected</c:if>>매출량적은순</option>
                                </select>
                            </label>
                            <label>
					            <select name="filter" id="filter" class="datatable-selector filter" onchange="applyCondition();">
					                <option value="일별" <c:if test="${param.filter == '일별'}">selected</c:if>>일별</option>
                                    <option value="주별" <c:if test="${param.filter == '주별'}">selected</c:if>>주별</option>
                                    <option value="월별" <c:if test="${param.filter == '월별'}">selected</c:if>>월별</option>
					            </select>
					        </label>
                        </div>
                        <div class="col-md-8">
                        
						                        
                            <div class="datatable-dropdown" style="margin-bottom: 20px">
                               	<input id="start_date" name="start_date" type="date" class="datatable-selector dateInput">
                               	-
                               	<input id="end_date" name="end_date" type="date" class="datatable-selector dateInput">
                            </div>
                        </div>
                        <div class="col-md-3"></div>
                        <div class="col-md-1">
                            <input type="button" value="검색" class="btn btn-primary applyButton">
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
                                            <th class="col-sales-sales">매출액</th>
                                        </tr>
                                    </thead>
                                    <tbody id="printList"></tbody>
                                </table>
                            </div>
                        </div>
                        <!-- 페이지네이션-->
                        <div class="datatable-bottom">
                            <div class="datatable-info">Showing ${vo.page} to ${map.totalPage } of ${map.total} entries</div>
                            <nav class="datatable-pagination">
                                <ul class="datatable-pagination-list"></ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </main>
            <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
        </div>
    </div>

</body>
</html>
