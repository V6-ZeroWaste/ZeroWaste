<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css" />
    <link rel="stylesheet" href="/user/css/style.css" />
    <title>soaff mypage point</title>
    <style>
    	input[type='date']::before {
		  content: attr(data-placeholder);
		  width: 100%;
		}
		input[type='date']:focus::before,
		input[type='date']:valid::before {
		  display: none;
		}
		table>th{
			text-align: center;
		}
		.pointAccum{
			color: blue;
		}
		.pointConsume{
			color: red;
		}
		.order-itemImgBox{
			width:200px;
			height:200px;
			padding:10px;
		}
		
		.order-head{
			display:flex;
			justify-content: space-between;
			border-bottom:1px solid #dddddd;
			padding:10px
		}
		.search-filter>div{
			margin:10px 0px 10px 0px;
		}
		.order-status.shipping::before {
			background: #F5BE17; 
		}
		.ellipsis {
			  overflow: hidden;
			  text-overflow: ellipsis;
			  white-space:nowrap;
			  max-width:400px;
		}
    	
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

	  function getList(){
		  var data = {
			  endDate: $('#endDate').val(),
			  startDate: $('#startDate').val(),
			  page: page,

		  }

		  $.ajax({
			  type: "GET", // method type
			  url: "/mypage/point/list", // 요청할 url
			  data: data, // 전송할 데이터
			  dataType: "json", // 응답 받을 데이터 type
			  success : function(resp){
				  // 데이터 리스트 출력
                  renderList(resp.list);

				  // 페이지네이션 출력
				  // 총 개수
				  $(".total-cnt").html(resp.total+" entries");
				  // 페이지네이션
				  /* <li class="page-item active"><a class="page-link" href="#!">1 <span class="sr-only">(current)</span></a></li>
				  <li class="page-item active"><a class="page-link" href="#!">1</a></li>
			      <li class="page-item"><a class="page-link" href="#!">2</a></li>
			      <li class="page-item"><a class="page-link" href="#!">3</a></li>
			      <li class="page-item"><a class="page-link" href="#!">4</a></li>
			       */             
			                    
			          
				  let printPage = "";
				  if(resp.isPrev){
					  printPage += `<li class="page-item"><a class="page-link" onclick="changePage(this)" data-page="1">‹‹</a></li>`
					  printPage += `<li class="page-item"><a class="page-link" onclick="changePage(this)" data-page="`+(resp.startPage-1)+`">‹‹</a></li>`
				  }
				  for(i = resp.startPage; i<=resp.endPage; i++){
					  if(page==i){
						  printPage+=`<li class="page-item active"><a class="page-link">`+i+`</a><span class="sr-only">(current)</span></a></li>`
						  
					  }else{
						  printPage += `<li class="page-item"><a class="page-link" onclick="changePage(this)" data-page="`+i+`">`+i+`</a></li>`
					  }
					  
				  }
				  if(resp.isNext){

					  printPage += `<li class="page-item"><a class="page-link" onclick="changePage(this)" data-page="`+(resp.endPage+1)+`">›</a></li>`
					  printPage += `<li class="page-item"><a class="page-link" onclick="changePage(this)" data-page="`+(resp.totalPage)+`">››</a></li>`
				  }
				  
				  
				  $(".pagination").html(printPage);
				  
				


			  },
			  error:function (data, textStatus) {
				  $('#fail').html("관리자에게 문의하세요.") // 서버오류
			  }
		  })

	  }
	function yyyymmdd(originDate){
		let year = originDate.getFullYear();
		let month = originDate.getMonth()+1;
		let date = originDate.getDate();
		return year + '-' + (month >= 10? month : '0'+ month ) +'-'+(date >= 10? date : '0'+ date )
		
	}

    function renderList(dataList) {
        var printList = "";

        if (dataList.length > 0) {
        	dataList.forEach(function(data) { //
				if(data.point!=0){
					printList += "<tr>"
					if(data.point < 0){
						printList += "<td class='pointConsume'>사용</td>";
						printList += "<td class='pointConsume'>"+data.point+"</td>";
					}else{
						printList += "<td class='pointAccum'>적립</td>";
						printList += "<td class='pointAccum'>"+data.point.toString()
						  .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
+"</td>";
					}

					printList += "<td class='ellipsis'>"+data.content+"</td>";
					printList += "<td>"+(data.order_no == 0? "" : data.order_no )+"</td>";
					printList += "<td>" +yyyymmdd(new Date(data.point_date)) + "</td>";
					printList += "</tr>"
				}
            });

            $("#printList").html(printList);
        }
    }
  	</script>
  </head>
    <body>
	<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/user/include/mypageInfo.jsp" %>
	<section class="pt-5">
    	<div class="container">
    		<div class="row gutter-4 justify-content-between">
				<%@ include file="/WEB-INF/views/user/include/mypageNav.jsp" %>
				<div class="col-lg-9">
		            
		              <!-- <div class="col"> -->
		                
    <!-- content -->
	<div class="row gutter-4">
    	<div class="col-12">
    		<!-- title -->
   			<h3 class="mb-0">Point</h3>
   			<!-- /title -->
   			<!-- search filter -->
   			<div class="search-filter">
		   		<div>
		   			<input type="date" class="btn btn-outline-secondary btn-sm" id="startDate" onchange="applyCondition();">
		   			&nbsp;-&nbsp; 
		   			<input type="date" class="btn btn-outline-secondary btn-sm" id="endDate" onchange="applyCondition();"/>
		   		</div>
				<div><span class="eyebrow  total-cnt"></span></div>
   			</div>
   			<!-- /search filter -->
   		</div>
   		<!-- list -->
	   	<div class="pointList col-12">
	   		
	   		<table class="table">
	   			<thead>
	   				<tr>
						<th>상태</th>
						<th>적립</th>
						<th>내용</th>
						<th>주문번호</th>
						<th>적용일</th>
					</tr>
	   			</thead>
	   				

	   			<tbody id="printList">
	   			
	   			</tbody>
	   		
	   		</table>
	   		
				
			
	   		
	   		
	   		
	   		
	   		
				
	   		
	   		
   		</div>
   		<!-- /list -->
   	</div>
	<!-- /content -->
							
						
					
					
					<!-- pagination -->
			   		<div class="row">
			        	<div class="col">
			            	<ul class="pagination">
			                </ul>
			            </div>
			        </div>
			        <!-- /pagination -->
				</div>
			</div>
		</div>
		
	</section>
    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
    </body>
</html>
    