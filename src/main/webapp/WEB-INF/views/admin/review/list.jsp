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
        <title>상품 리뷰 관리</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/datatables-simple-demo.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <style>
           img{
              max-height: 50px;
              max-width: 50px;
           }
           tr{
              height:65px;
           }
        </style>
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
                 searchWord: $('#searchWord').val().trim(),
                 orderBy: $('#orderBy').val().trim()==""? "최신순":$('#orderBy').val().trim(),
                 startDate: $('#startDate').val().trim(),
                 endDate: $('#endDate').val().trim(),
                 page: page,
              
           }
            
              $.ajax({
            type: "GET", // method type
            url: "/admin/review/getList", // 요청할 url
                data: data, // 전송할 데이터
                dataType: "json", // 응답 받을 데이터 type
                success : function(resp){
                      // 데이터 리스트 출력
                     $("#printList").html(resp.printList);
                     
                     // 페이지네이션 출력
                     // 총 개수
                     $(".datatable-info").html("Showing "+((page-1)*20+1)+" to "+(page*20<=resp.total? page*20 : resp.total)+" of "+resp.total+" entries"); 
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
                        printPage += '<a data-page="'+(resp.endPage+1)+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">›</a></li>';
                        printPage += '<li class="datatable-pagination-list-item">';
                        printPage += '<a data-page="'+resp.totalPage+'" class="datatable-pagination-list-item-link" onclick="changePage(this);">››</a></li>';
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
                        <h1 class="mt-4">상품 리뷰 관리</h1>
                        <div class="card mb-4">
                      
                            
                            <div class="card-body">
                                <!-- 리스트 정렬, 필터 검색 영역  -->
                                <div>
                                   <div class="datatable-dropdown" style="margin-bottom: 20px">
                              <span>작성 날짜</span>
                              <input id="startDate" name="startDate" type="date" class="datatable-selector" onchange="applyCondition();">-
                              <input id="endDate" name="endDate" type="date" class="datatable-selector" onchange="applyCondition();">
                           </div>
                                </div>
                                
                               <div class="datatable-top">

                                  <div class="datatable-dropdown">
                                 <label>
                                     <select id="orderBy" class="datatable-selector" onchange="applyCondition();">
                                        <option value="최신순" selected>최신순</option>
                                        <option value="오래된순">오래된순</option>
                                        <option value="평점높은순">평점높은순</option>
                                        <option value="평점낮은순">평점낮은순</option>
                                     </select>
                                 </label>
                             </div>
                                 
                                  <div class="row align-items-center">
                                       <div class="col-md-9">
                                            <input id="searchWord" class="datatable-input" type="search" placeholder="상품명/리뷰제목/카테고리 검색" onkeyup="if(window.event.keyCode==13){applyCondition();}">
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
                                            <th>리뷰 번호</th>
                                            <th>리뷰 썸네일</th>
                                            <th>상품명</th>
                                            <th>리뷰 제목</th>
                                            <th>평점</th>
                                            <th>카테고리</th>
                                            <th>작성 일자</th>
                                            <th>노출여부</th>
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
        
    </body>
</html>