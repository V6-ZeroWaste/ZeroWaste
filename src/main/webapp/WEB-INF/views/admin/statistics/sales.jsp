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
        <title>매출 통계</title>
        <link href="/admin/css/styles.css" rel="stylesheet" />
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="/assets/demo/chart-area-demo.js"></script>
        <script src="/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script>
        <script type="text/javascript">
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
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                page: page,

            }

            $.ajax({
                type: "GET", // method type
                url: "/admin/statistics/sales/getList", // 요청할 url
                data: data, // 전송할 데이터
                dataType: "json", // 응답 받을 데이터 type
                success : function(resp){
                	alert("성공");
                    console.log(resp)
                    // 데이터 리스트 출력
                    let printList = "";
                    if(resp.list.length == 0){
                        printList = "<td class='first' colspan='5' style='text-align: center;'>등록된 글이 없습니다.</td>";
                    }

                    $("#printList").html(resp.printList);

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
                	alert("실패");
                    $('#fail').html("관리자에게 문의하세요.") // 서버오류
                    console.log('error', data, textStatus);
                }
            })

        }
    </script>
        </script>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
        <div id="layoutSidenav">
        	<%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
        	<div id="layoutSidenav_content">
       			<main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">${vo} ${map }</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                        <div class="col-md-1">
					    	<input type="button" value="검색" class="btn btn-primary" onclick="applyCondition();">
					    </div>
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">Primary Card</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#">View Details</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body">Warning Card</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#">View Details</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body">Success Card</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#">View Details</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body">Danger Card</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="#">View Details</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
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
								        <tbody id="printList">
								        	
								        </tbody>
								    </table>
								</div>
                            </div>
                        </div>
                    </div>
                </main>
                <%@ include file="/WEB-INF/views/admin//include/footer.jsp" %>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                var datatablesSimple = document.getElementById('datatablesSimple');
                if (datatablesSimple) {
                    new simpleDatatables.DataTable(datatablesSimple);
                }
            });
        </script>
        <script>
	    // Area Chart Example
	    document.addEventListener('DOMContentLoaded', function() {
	        var ctx = document.getElementById("myAreaChart").getContext('2d');
	        var myAreaChart = new Chart(ctx, {
	            type: 'line',
	            data: {
	                labels: ["January", "February", "March", "April", "May", "June"],
	                datasets: [{
	                    label: "Dataset",
	                    data: [65, 59, 80, 81, 56, 55],
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
	
	        // Bar Chart Example
	        var ctx = document.getElementById("myBarChart").getContext('2d');
	        var myBarChart = new Chart(ctx, {
	            type: 'bar',
	            data: {
	                labels: ["January", "February", "March", "April", "May", "June"],
	                datasets: [{
	                    label: "Dataset",
	                    data: [65, 59, 80, 81, 56, 55],
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
	    });
	</script>
    </body>
</html>
