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
        <title>주문 상세</title>
        <link href="/admin/css/styles.css" rel="stylesheet" />
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        
        <style>
        .title {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		} 
		.behavior{
			padding-bottom: 30px;
			display: flex;
			justify-content: space-around;
		}
		</style>
		<script type="text/javascript">
		/*
        window.onload=function(){
        	updateDeliveryStatus();
        	}
		*/
        function applyCondition(){
            if (confirm("배송 상태를 변경 하시겠습니까?")) {
            	updateDeliveryStatus();
	            }
	    }

        function updateDeliveryStatus(){
        	
        	var data = {
        			delivery_status: $('#delivery_status').val(),
        			order_no: ${detailMap.detailFromOrderVO.order_no}
        	}
            
        	$.ajax({
        	    type: "POST", // method type
        	    url: "/admin/order/detail/updateDeliveryStatus", // 요청할 url
        	    data: JSON.stringify(data), // 전송할 데이터
        	    //async: false,
        	    contentType: "application/json; charset=UTF-8",
        	    success: function(resp) {
        	        console.log(resp);

        	        if (resp == "0") {
        	            alert('배송 상태 수정 실패');
        	        } else {
        	            alert('변경완료');
        	        }
        	    },
        	    error: function(data, textStatus) {
        	        $('#fail').html("관리자에게 문의하세요."); // 서버 오류
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
        				<!-- 제목 -->
        				<div class="title">
                        	<h1 class="mt-4">주문 상세</h1>
                       	    <button class="btn btn-primary" style="height:38px" onclick="location.href='/admin/order/list'">돌아가기</button>
                        	
        				</div>
        				
        				<!-- 주문 정보 -->
                        <div class="card mb-4">
                           	<div class="card-header">
                                <h4 class="mt-4">주문 정보</h4>
                            </div>
                        	<div class="card-body">
                        		<!-- 리스트 영역 -->
                            	<div class="datatable-container">
	                               <table class="datatable-table">
	                                   <thead>
	                                       <tr>
	                                      	  <th>주문 번호</th>
	                                          <th>주문 일자</th>
	                                          <th>유저 id</th>
	                                          
	                                       </tr>
	                                       <tr>
	                                      	  <td id="order_no">${detailMap.detailFromOrderVO.order_no}</td>
	                                          <td>
	                                          <fmt:formatDate value="${detailMap.detailFromOrderVO.payment_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                          </td>
	                                          <td onclick="location.href='/admin/user/detail?id=${detailMap.detailFromOrderVO.user_no}'">${orderVO.id}</td>
	                                          
	                                       </tr>
	                                   </thead>
		                        	<tbody id="printList">
	                                   
	                                </tbody>
	                                   
	                               </table>
                            	</div>
                        	</div>
                        </div>
                        
                        <!-- 상품 정보 -->
                        <div class="card mb-4">
                        	<div class="card-header">
                                <h4 class="mt-4">상품 정보</h4>
                            </div>
                        	<div class="card-body">
                        		<!-- 리스트 영역 -->
                            	<div class="datatable-container">
                            		<table class="datatable-table">
	                                   <thead>
                            			   <tr>
                            			   	  <th>주문 상세 번호</th>
	                                      	  <th colspan="2">상품 정보</th>
	                                          <th>상품별 주문 금액</th>
	                                          <th>상품별 주문 수량</th>
	                                          <th>취소 상태</th>
	                                          <th>취소 상세</th>
	                                          <th>구매 확정</th>
	                                       </tr>
	                                       		<c:forEach var="vo" items="${detailMap.detailFromOrderDetailVO}">
		                                       		  <tr>
		                                       		  	  <td>${vo.order_detail_no }</td>
			                                       		  <td>${vo.item_name} </td>
			                                       		  <td><img src="${vo.item_img}" ></img></td>
				                                          <td>${vo.price*vo.amount}(${vo.amount}) </td>
				                                          <td>${vo.amount} </td>
		                                                  <td id="cancel_status">
												            <c:choose>
												                <c:when test="${empty vo.cancel_status}">
												                    
												                </c:when>
												                <c:when test="${vo.cancel_status == 0}">
												                    취소요청
												                </c:when>
												                <c:when test="${vo.cancel_status == 1}">
												                    취소 승인
												                </c:when>
												                <c:when test="${vo.cancel_status == 2}">
												                    취소 완료
												                </c:when>
												            </c:choose>
												          </td>
				                                          <td>
					                                          <c:choose>
													                <c:when test="${empty vo.cancel_status}">
													                    
													                </c:when>
													                <c:when test="${!empty vo.cancel_status}">
													                    <a href="/admin/cancel/${vo.order_detail_no}";>취소 상세</a>
													                </c:when>
													                <c:when test="${!empty vo.confirm_date && detailMap.detailFromOrderVO.delivery_status == 2}">
													                    <a href="/admin/cancel/${vo.order_detail_no}";>강제 취소</a>
													                </c:when>
													            </c:choose>
				                                          </td>
				                                          <td>
					                                          <c:choose>
													                <c:when test="${empty vo.confirm_date}">
													                    X
													                </c:when>
													                <c:when test="${!empty vo.confirm_date}">
													                    O
													                </c:when>
													            </c:choose>
				                                          </td>
				                                          
	                                       			  </tr>
	                                       		</c:forEach>
	                                   </thead>
	                               </table>
                            	</div>
                        	</div>
                        </div>
                   

        				
       				<!-- 배송지 정보 -->
                       <div class="card mb-4">
                       	<div class="card-header">
                               <h4 class="mt-4">배송지 정보</h4>
                           </div>
                       	<div class="card-body">
                       		<!-- 리스트 영역 -->
                           	<div class="datatable-container">
                               <table class="datatable-table">
                                   <thead>
										<tr>
	                                    	<th>받는 사람</th>
	                                    	<td>${detailMap.detailFromOrderVO.receiver_name}</td>
	                                    </tr>
										<tr>
	                                    	<th>연락처</th>
	                                    	<td>${detailMap.detailFromOrderVO.receiver_tel}</td>
	                                    </tr>
										<tr>
	                                    	<th>배송지 주소</th>
	                                    	<td>${detailMap.detailFromOrderVO.addr},${detailMap.detailFromOrderVO.addr_detail}</td>
	                                    </tr>
										<tr>
	                                    	<th>배송메세지</th>
	                                    	<td> ${detailMap.detailFromOrderVO.delivery_request}</td>
										</tr>
										<tr>
	                                    	<th>배송 상태</th>
	                                    	<td> 
	                                    		<div class="datatable-dropdown">
													<label>
											            <select id="delivery_status" name="delivery_status" class="datatable-selector">
											                <option value="0" ${detailMap.detailFromOrderVO.delivery_status == '0' ? 'selected' : ''}>상품준비중</option>
											                <option value="1" ${detailMap.detailFromOrderVO.delivery_status == '1' ? 'selected' : ''}>배송중</option>
											                <option value="2" ${detailMap.detailFromOrderVO.delivery_status == '2' ? 'selected' : ''}>배송완료</option>
											            </select>
								                    	<button class="btn btn-primary" style="height:38px" onclick="applyCondition();">변경</button>
													</label>
												</div>
	                                    	</td>
										</tr>
                                   </thead>
                               </table>
                           	</div>
                       	</div>
                       </div>
                       <!-- 최종 결제 정보 -->
                       <div class="card mb-4">
                       	<div class="card-header">
                            <h4 class="mt-4">최종 결제 정보</h4>
                          </div>
                       	<div class="card-body">
                       		<!-- 리스트 영역 -->
                           	<div class="datatable-container">
                           		<table class="datatable-table">
                                   <thead>
                                       <tr>
	                                    	<th>총 상품 금액</th>
	                                    	<td>
	                                    		${detailMap.detailFromOrderVO.payment_price-detailMap.detailFromOrderVO.delivery_price+detailMap.detailFromOrderVO.point}
	                                    	</td>
	                                    </tr>
                                       <tr>
	                                    	<th>배송비</th>
	                                    	<td>${detailMap.detailFromOrderVO.delivery_price}</td>
	                                    </tr>
                                       <tr>
	                                    	<th>적립금 사용</th>
	                                    	<td>${detailMap.detailFromOrderVO.point}</td>
	                                    </tr>
                                       <tr>
	                                    	<th>최종 결제 금액</th>
	                                    	<td>${detailMap.detailFromOrderVO.payment_price}</td>
	                                    </tr>
                                       <tr>
	                                    	<th>결제 수단</th>
	                                    	<td>${detailMap.detailFromOrderVO.payment_method}</td>
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
        
    </body>
</html>
