<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css" />
    <link rel="stylesheet" href="/user/css/style.css" />
    <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>soaff</title>
</head>
<script type="text/javascript">
    $(function(){
        $('#relTel').val($('#tel1').val() + $('#tel2').val() + $('#tel3').val());
        $('#relAdd').val($('#addr1').val() + $('#addr2').val());

        $('#adr_btn').on('click', () => {
            zipcode();
        });

        // 본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function zipcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 참고 항목 변수

                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    $('#zipcode').val(data.zonecode);
                    $('#addr1').val(roadAddr);
                }
            }).open();
        }

    });
</script>
<body>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%@ include file="/WEB-INF/views/user/include/mypageInfo.jsp" %>
<section class="pt-5">
    <div class="container">
        <div class="row gutter-4 justify-content-between">
            <%@ include file="/WEB-INF/views/user/include/mypageNav.jsp" %>
                <!-- content -->
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col">
                            <div class="tab-content" id="myTabContent">

                                <!-- profile -->
                                <div class="tab-pane fade show active" id="sidebar-1-1" role="tabpanel" aria-labelledby="sidebar-1-1">
                                    <div class="row mb-2">
                                        <div class="col-12">
                                            <h3>Personal Data</h3>
                                        </div>
                                    </div>
                                    <div class="row gutter-1">
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="id">아이디</label>
                                                <input id="id" name="id" type="text" class="form-control" placeholder="id" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="email">이메일</label>
                                                <input id="email" name="email" type="text" class="form-control" placeholder="email" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-8 align-content-between">
                                            <div class="form-group d-flex align-items-center">
                                                <label for="tel1">전화번호</label>
                                            </div>
                                            <div class="form-group d-flex align-items-center">
                                                <input type="text" class="form-control col-3 mr-1" name="receiverTel1" id="tel1" placeholder="">
                                                <p class="d-flex justify-content-center align-items-center col-1 mr-0 mb-0">-</p>
                                                <input type="text" class="form-control col-3 mx-1" name="receiverTel2" id="tel2" placeholder="">
                                                <p class="d-flex justify-content-center align-items-center col-1 mr-0 mb-0">-</p>
                                                <input type="text" class="form-control col-3 ml-1" name="receiverTel3" id="tel3" placeholder="">
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="exampleInput4">변결할 비번</label>
                                                <input id="exampleInput4" type="text" class="form-control" placeholder="Street">
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="exampleInput5">비밀번호 변경 확인</label>
                                                <input id="exampleInput5" type="text" class="form-control" placeholder="Zip">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="zipcode">우편번호</label>
                                                <input id="zipcode" type="text" class="form-control" placeholder="zipcode" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-4 d-flex justify-content-lg-start align-items-sm-end">
                                            <div class="form-group d-flex justify-content-lg-start align-items-sm-end">
                                                <label for="adr_btn"></label>
                                                <button type="button" class="btn btn-primary btn-rounded" id="adr_btn" >우편번호</button>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="addr1"></label>
                                                <input id="addr1" type="text" class="form-control" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="addr2"></label>
                                                <input id="addr2" type="text" class="form-control">
                                            </div>
                                        </div>

                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <input id="relTel" name="relTel" type="hidden" class="form-control" placeholder="tel">
                                            </div>
                                        </div>
                                        <div class="col-md-8 d-flex align-items-center justify-content-end" style="" >
                                            <div class="form-group">
                                                <a href="#!" class="btn btn-primary">수정</a>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <h3>Withdrawal</h3>
                                            </div>
                                        </div>
                                    </div>
                                        <div class="col-md-12 mr-0 p-0" >
                                            <div class="col-8" style="border: rgb(221, 221, 221) 1px solid; padding: 15px">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal-2">
                                                    탈퇴하기
                                                </button>
                                            </div>
                                        </div>
                                </div>
                                                <div class="modal modal fade" id="exampleModal-2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div style="padding: 15px" class="d-flex align-items-center justify-content-center">
                                                                <h4>Withdrawal</h4><br>
                                                            </div>
                                                            <div style="padding: 15px" class="d-flex align-items-center justify-content-center">
                                                                <div><strong>비밀번호 확인 후 탈퇴가 진행됩니다.</strong></div>
                                                            </div>
                                                            <form>
                                                                <div style="padding: 10px" class="d-flex align-items-center justify-content-center">
                                                                    <div class="invalid-feedback">비밀번호를 확인해 주세요</div>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="form-group">
                                                                            <label for="exampleInput6">비밀번호</label>
                                                                            <input type="text" class="form-control form-control-lg" placeholder="password" aria-label="pwd">
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <div class="container-fluid">
                                                                        <div class="row gutter-0">
                                                                            <div class="col">
                                                                                <button type="button" class="btn btn-block btn-secondary" data-dismiss="modal">Close</button>
                                                                            </div>
                                                                            <div class="col">
                                                                                <button type="button" class="btn btn-block btn-primary">Save changes</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
</section>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>