<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>문의 상세</title>
        <link href="/admin/css/styles.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/admin/js/scripts.js"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        
        <style>
        .title {
            display: flex;
            justify-content: space-between;
            align-items: center;
        } 
        .behavior {
            padding-bottom: 30px;
            display: flex;
            justify-content: space-around;
        }
        #qna_img {
            max-height: 300px;
            max-width: 300px;
        }
        .input-box {
            width: 100%;
            min-height: 200px;
        }
        </style>
        <script type="text/javascript">
            function updateReply(qna_no, reply) {
                $.ajax({
                    type: "POST",
                    url: "/qna/updateReply",
                    data: {
                        qna_no: qna_no,
                        reply: reply
                    },
                    success: function(response) {
                        if (response === 1) {
                            alert("답변이 등록/수정되었습니다.");
                            location.reload();
                        } else {
                            alert("답변 등록/수정에 실패했습니다.");
                        }
                    },
                    error: function() {
                        alert("서버와의 통신 중 오류가 발생했습니다.");
                    }
                });
            }

            function handleUpdateReply() {
                var replyContent = document.getElementById('reply').value;
                updateReply(${vo.qna_no}, replyContent);
            }

            function handleDeleteReply() {
                if (confirm("정말 삭제하시겠습니까?")) {
                    $.ajax({
                        type: "POST",
                        url: "/qna/deleteReply",
                        data: { qna_no: ${vo.qna_no} },
                        success: function(response) {
                            if (response === 1) {
                                alert("답변이 삭제되었습니다.");
                                location.reload();
                            } else {
                                alert("답변 삭제에 실패했습니다.");
                            }
                        },
                        error: function() {
                            alert("서버와의 통신 중 오류가 발생했습니다.");
                            location.href = "/admin/qna/list";
                        }
                    });
                }
            }

            function handleDeleteQna() {
                if (confirm("정말 삭제하시겠습니까?")) {
                    $.ajax({
                        type: "POST",
                        url: "/qna/deleteContent",
                        data: { qna_no: ${vo.qna_no} },
                        success: function(response) {
                            if (response === 1) {
                                alert("문의가 삭제되었습니다.");
                                location.href = "/admin/qna/list";
                            } else {
                                alert("문의 삭제에 실패했습니다.");
                            }
                        },
                        error: function() {
                            alert("서버와의 통신 중 오류가 발생했습니다.");
                        }
                    });
                }
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
                            <h1 class="mt-4">상품 문의 상세</h1>
                            <input class="btn btn-primary" type="button" style="height:38px" onclick="location.href = '/admin/qna/list'" value="돌아가기"> 
                        </div>
                        
                        <!-- 문의 영역 -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h4 class="mt-4">문의 상세</h4>
                            </div>
                            <div class="card-body">
                                <table class="datatable-table">
                                    <tbody>
                                        <tr>
                                            <th>문의 번호</th>
                                            <td>${vo.qna_no}</td>
                                            <th>문의 등록 일자</th>
                                            <td>${vo.question_date}</td>
                                        </tr>
                                        <tr>
                                            <th>답변 상태</th>
                                            <td class="h5">${vo.replyState}</td>
                                            <th>문의 유형</th>
                                            <td>${vo.type}</td>
                                        </tr>
                                        <tr>
                                            <th>상품 번호</th>
                                            <td>${vo.item_no}</td>
                                            <th>상품명</th>
                                            <td>${vo.name}</td>
                                        </tr>
                                        <tr>
                                            <th>제목</th>
                                            <td colspan="3">${vo.title}</td>
                                        </tr>
                                        <tr>
                                            <th>작성자</th>
                                            <td colspan="3">${vo.user_id}</td>
                                        </tr>
                                        <tr>
                                            <th>문의 내용</th>
                                           	<c:if test="${not empty vo.qna_img}">
                                            <td colspan="1">                                                
                                                <div>
                                                    <img src="/upload/qna_img/${vo.qna_img}" class="img-fluid"/>	                                                                                                     
                                                </div>
                                            </td>
                                            <td colspan="2">
                                                	${vo.content}
                                            </td>
                                            </c:if>
                                              	<c:if test="${empty vo.qna_img}">
                                            <td colspan="3">
                                            	${vo.content}                                                 
                                            </td>                                                	                                      
                                            </c:if> 
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <!-- 수정/등록/취소.. 버튼 -->
                        <div class="behavior">
                            <button id="deleteQna" class="btn btn-danger" onclick="handleDeleteQna();"style="height:38px">삭제</button>
                        </div>

                        <!-- 답변 영역 -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h4 class="mt-4">답변 상세</h4>
                            </div>
                            <div class="card-body">
                                <table class="datatable-table">
                                    <tbody>
                                        <tr>
                                            <th>답변 등록 날짜</th>
                                            <td>${vo.reply_date}</td>
                                        </tr>
                                        <tr>
                                            <th>답변 내용</th>
                                            <td>
                                                <div>
                                                    <c:if test="${empty vo.reply_date}">
                                                        <input id="reply" class="input-box" value="">
                                                    </c:if>
                                                    <c:if test="${not empty vo.reply_date}">
                                                        <input id="reply" class="input-box" value="${vo.reply}">
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- 수정/등록/취소.. 버튼 -->
                        <div class="behavior">
                            <c:if test="${empty vo.reply_date}">
                                <button id="updateReply" class="btn btn-primary" onclick="handleUpdateReply();"style="height:38px">등록</button>     
                            </c:if>
                            <c:if test="${not empty vo.reply_date}">
                                <button id="updateReply" class="btn btn-primary" onclick="handleUpdateReply();"style="height:38px">수정</button>       
                                <button id="deleteReply" class="btn btn-danger" onclick="handleDeleteReply();" style="height:38px">삭제</button>        
                            </c:if>
                        </div>
                    </div>
                </main>
                <%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
