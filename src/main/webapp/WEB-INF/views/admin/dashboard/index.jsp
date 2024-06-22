<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>dashboard</title>
    <link href="/admin/css/styles.css" rel="stylesheet"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"></script>
    <script src="/admin/js/scripts.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
</head>
<script>
    let page = 1;

    var myAreaChart;
    var itemChart;
    var usersChart;

    let start_temp = new Date();
    let end_temp = new Date();

    function formatDate(date) {
        const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const day = date.getDate().toString().padStart(2, '0');
        const result = year + "-" + month + "-" + day

        return result;
    }

    function addDays(date, days) {
        const clone = date;
        clone.setDate(date.getDate() + days)
        return clone;
    }

    const start_date = formatDate(addDays(start_temp, -7));
    const end_date = formatDate(end_temp);
    console.log(start_date);
    console.log(end_date);

    window.onload = function () {
        getItemList();
        getUsersList();
        getSalesList();
    }


    function drawItemChart(data) {
        var labels = data.map(d => d.name);
        var datasets = [
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
        $('#itemChart').remove(); // this is my <canvas> element
        $('#itemCanvas-div').append('<canvas id="itemChart"><canvas>');

        var ctx = document.getElementById("itemChart").getContext("2d");

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


    function drawUsersChart(usersList, leaveList) {


        var labels = usersList.map(obj => obj.date);
        var datasets = [
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
                        usePointStyle: true,        // 범례 도형 모양과 관련된 속성으로, false일 경우엔 기본 직사각형 도형으로 표시됩니다.        
                        padding: 10,        // 범례 간 가로 간격을 조정할 수 있습니다. 범례의 상하 padding을 지정하는 기능은 따로 지원되지 않아요. ㅠㅠ
                    }
                }
            },
            scales: {
                x: [{
                    stacked: true, // x축을 STACKED 모드로 설정
                }],
                y: [{
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
        $('#usersChart').remove(); // this is my <canvas> element
        $('#usersCanvas-div').append('<canvas id="usersChart"><canvas>');

        var ctx = document.getElementById("usersChart").getContext("2d");

        // 차트 객체 생성
        myChart = new Chart(ctx, {
            type: "bar", // 가로막대 그래프 타입 설정
            data: {
                labels: labels,
                datasets: datasets
            },
            options: options
        });

    }


    function getItemList() {


        $.ajax({
            type: "GET", // method type
            url: "/admin/statistics/items/getList", // 요청할 url
            dataType: "json", // 응답 받을 데이터 type
            success: function (resp) {

                drawItemChart(resp.list);
            },
            error: function (data, textStatus) {
                $('#fail').html("관리자에게 문의하세요.") // 서버오류
                console.log('error', data, textStatus);
            }
        })

    }

    function getUsersList() {

        var data = {

            orderBy: "최근날짜순",
            filter: "일별",
            start_date: start_date,
            end_date: end_date,
        }


        $.ajax({
            type: "GET", // method type
            url: "/admin/statistics/users/getList", // 요청할 url
            dataType: "json", // 응답 받을 데이터 type
            data: data,
            success: function (resp) {

                drawUsersChart(resp.usersList, resp.leaveList);
            },
            error: function (data, textStatus) {
                $('#fail').html("관리자에게 문의하세요.") // 서버오류
                console.log('error', data, textStatus);
            }
        })

    }

    function getSalesList() {

        var data = {
            orderBy: '최근날짜순',
            filter: '일별',
            start_date: start_date,
            end_date: end_date,

        };

        $.ajax({
            type: "GET",
            url: "/admin/statistics/sales/getList",
            data: data,
            dataType: "json",
            success: function (resp) {

                var labels = [];
                var data = [];
                resp.list.reverse().forEach(function (item) {
                    labels.push(item.date);
                    data.push(item.sales);
                })

                // Destroy existing charts if they exist
                if (myAreaChart) myAreaChart.destroy();

                // Create the Area Chart
                var ctxArea = document.getElementById("myAreaChart").getContext('2d');
                myAreaChart = new Chart(ctxArea, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: "Sales",
                            lineTension: 0.3,
                            backgroundColor: "rgba(2,117,216,0.2)",
                            borderColor: "rgba(2,117,216,1)",
                            pointRadius: 5,
                            pointBackgroundColor: "rgba(2,117,216,1)",
                            pointBorderColor: "rgba(255,255,255,0.8)",
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(2,117,216,1)",
                            pointHitRadius: 50,
                            pointBorderWidth: 2,
                            data: data,
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
                                    maxTicksLimit: 7
                                }
                            },
                            y: {
                                ticks: {
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
        });
    }


</script>


<body>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<div id="layoutSidenav">
    <%@ include file="/WEB-INF/views/admin/include/sidenav.jsp" %>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Dashboard</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active"></li>
                </ol>
                <div class="row">
                    <div class="col">
                        <div class="card bg-danger text-white mb-4">
                            <div class="card-body fw-bold fs-5 text">취소 요청 ${vo.cancelCount }건</div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="small text-white stretched-link" href="/admin/cancel/list?filter=0">자세히 보기</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-warning text-white mb-4">
                            <div class="card-body fw-bold fs-5 text">문의 요청 ${vo.qnaCount }건</div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="small text-white stretched-link" href="/admin/qna/list?filter=답변대기">자세히 보기</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-success text-white mb-4">
                            <div class="card-body fw-bold fs-5 text">주문 요청 ${vo.deliveryCount }건</div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="small text-white stretched-link" href="/admin/order/list?filter=0">자세히 보기</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card bg-light text-white mb-4">
                            <div class="card-body fw-bold text-dark">🎉 오늘의 매출액은 <span
                                    class="text-primary"><fmt:formatNumber value="${vo.todaySalse}" type="number"
                                                                           pattern="#,###"/>원</span>입니다
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-light text-white mb-4">
                            <div class="card-body fw-bold text-dark">📦 오늘의 주문건수는 <span
                                    class="text-primary">${vo.todayOrderCount}건</span> 입니다
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card mb-4">
                            <div class="card-header" onclick="location.href=''">
                                <i class="fas fa-chart-area me-1"></i>
                                매출 통계
                            </div>


                            <canvas id="myAreaChart"></canvas>


                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card mb-4">
                            <div class="card-header" onclick="location.href=''">
                                <i class="fas fa-chart-bar me-1"></i>
                                상품 통계
                            </div>

                            <div style=" overflow-y: auto; max-height: 500px;">
                                <div id="itemCanvas-div" style="padding:10px;">
                                    <canvas id="itemChart"></canvas>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card mb-4">
                            <div class="card-header" onclick="location.href=''">
                                <i class="fas fa-chart-bar me-1"></i>
                                회원 통계
                            </div>

                            <div style=" overflow-y: auto; max-height: 500px;">
                                <div id="usersCanvas-div" style="padding:10px;">
                                    <canvas id="usersChart"></canvas>
                                </div>
                            </div>

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