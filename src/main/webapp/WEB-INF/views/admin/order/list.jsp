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
        <title>주문 관리</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/datatables-simple-demo.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
				url: "/admin/order/getList", // 요청할 url
                data: data, // 전송할 데이터
                dataType: "json", // 응답 받을 데이터 type
                success : function(resp){
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
                    $('#fail').html("관리자에게 문의하세요.") // 서버오류
                    console.log('error', data, textStatus);
                }
           	})
        	
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
                        <h1 class="mt-4">주문 관리</h1>
                        <div class="card mb-4">

                            
                            <div class="card-body">
                             	<!-- 리스트 정렬, 필터 검색 영역  -->
								
												<div class="datatable-dropdown" style="margin-bottom: 20px">
													<span>주문 날짜</span>
													<input id="start_date" name="start_date" type="date" class="datatable-selector" onchange="applyCondition();">-<input id="end_date" name="end_date" type="date" class="datatable-selector" onchange="applyCondition();">
												</div>
											<div class="datatable-top">
											
											
												<div class="datatable-dropdown">
													<label>
														<select id="orderBy" name="orderBy" class="datatable-selector" onchange="applyCondition();">
															<option value="none">==정렬==</option>
															<option value="최신순">최신순</option>
															<option value="오래된순">오래된순</option>
															<option value="주문금액많은순">주문금액 많은 순</option>
															<option value="주문금액적은순">주문금액 적은 순</option>
														</select>
													</label>
													<label>
														<select id="filter" name="filter" class="datatable-selector" onchange="applyCondition();">
															<option value="" >==필터==</option>
															<option value="0" >취소 완료</option>
															<option value="1" >취소 요청</option>
															<option value="2" >상품준비중</option>
															<option value="3" >배송중</option>
															<option value="4" >배송완료</option>
															<option value="5" >구매확정</option>
														</select>
													</label>
												</div>
												
												<div class="row align-items-center">
				                                    <div class="col-md-9">
				                                         <input id="searchWord" name="searchWord" class="datatable-input" type="search" placeholder="주문no/주문한 아이디/상품명" <c:if test="${orderVO.searchWord} != null">value=${orderVO.searchWord}</c:if> onkeyup="if(window.event.keyCode==13){applyCondition();}" style="width:250px">
				                                    </div>
				                                    
			                                    	<div class="col-md-1">
			                                        	<input type="button" value="검색" class="btn btn-primary" onclick="applyCondition()"> 
			                                      	</div>
			                                 	</div>
													
											
											</div>
						
                           	
								
                            	
                            	<!-- 리스트 영역 -->
                            	<div class="datatable-container">
                                <table class="datatable-table">
                                    <thead>
                                        <tr>
                                       	   <th>주문 번호</th>
                                           <th>주문 일자</th>
                                           <th>주문한 유저ID</th>
                                           <th>결제 금액(수량)</th>
                                           <th>배송 상태</th>
                                        </tr>
                                    </thead>
		                        	<tbody id="printList">
                                    
                                    </tbody>
                                    
                                </table>
                            </div>

                            <!-- 페이지네이션-->
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
        
    </body>
</html>