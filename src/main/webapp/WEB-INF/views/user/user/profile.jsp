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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>soaff</title>
    <style>
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
    <script>
        let tel1Regex = /^[0-9]{3}$/;
        let tel2Regex = /^[0-9]{3,4}$/;
        let tel3Regex = /^[0-9]{4}$/;
        let passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

        $(function (){
            $("#pw").on("input", function (){
                pwdRegex();
            });
            $("#tel1, #tel2, #tel3").on("input", function (){
                telRegex();
            });

            $('#adr_btn').on('click', function () {
                zipcode();
            });
            $("#pw").on("change", function (){
                if($("#pw").val() !== $("#pwd_check").val() ){
                    $("pwd_checkErrorMsg").html("일치하지 않습니다").css("display","block");
                    isValid = false;
                }else{
                    $("pwd_checkErrorMsg").css("display","none")
                }
            });

        });

        function telRegex() {
            let isValid = true;
            let tel1 = $("#tel1");
            let tel2 = $("#tel2");
            let tel3 = $("#tel3");
            let tel1ErrorMsg = $("#tel1ErrorMsg");

            tel1ErrorMsg.css("display", "none");

            if (!tel1Regex.test(tel1.val()) && tel1.val() !== '') {
                tel1ErrorMsg.html("올바른 전화번호를 입력해주세요");
                tel1ErrorMsg.css("display", "block");
                isValid = false;
            }

            if (!tel2Regex.test(tel2.val()) && tel2.val() !== '') {
                tel1ErrorMsg.html("올바른 전화번호를 입력해주세요");
                tel1ErrorMsg.css("display", "block");
                isValid = false;
            }

            if (!tel3Regex.test(tel3.val()) && tel3.val() !== '') {
                tel1ErrorMsg.html("올바른 전화번호를 입력해주세요");
                tel1ErrorMsg.css("display", "block");
                isValid = false;
            }

            return isValid;
        }

        function pwdRegex() {
            let pw = $("#pw");
            let pwdErrorMsg = $("#pwdErrorMsg");

            if (!passwordRegex.test(pw.val()) && pw.val() !== '') {
                pwdErrorMsg.html("8자리 이상/대문자/소문자/특수문자/숫자가 포함됩니다");
                pwdErrorMsg.css("display", "block");
                return false;
            } else {
                pwdErrorMsg.css("display", "none");
            }
            return true;
        }

        function goProfile(event) {
            event.preventDefault();
            isValid = fieldCheckProfile();
            if (isValid) {
                let tel = $("#tel1").val() + $("#tel2").val() + $("#tel3").val();
                let pw = $("#pw").val();
                let zipcode = $("#zipcode").val();
                let addr = $("#addr1").val();
                let addr_detail = $("#addr_detail").val();

                if (pw === '' || pw === null) {
                    pw = "default";
                }
                console.log(tel);
                console.log(pw);
                console.log(zipcode);
                console.log(addr);
                console.log(addr_detail);

                $.ajax({
                    url: "/user/user/updateInfo",
                    method: 'post',
                    contentType: "application/json",
                    dataType: "json",
                    async: false,
                    data: JSON.stringify({
                        "tel": tel,
                        "pw": pw,
                        "zipcode": zipcode,
                        "addr": addr,
                        "addr_detail": addr_detail
                    }),
                    success: function (response) {
                        console.log(response)
                        if(response == '0'){
                            console.log("안녕")
                            alert("실패");
                        } else{
                            console.log("제발")
                            alert("성공");
                            location.href="/user/user/profile";
                        }
                    }
                });
            }
        }

        function fieldCheckProfile() {
            let tel1 = $("#tel1");
            let tel2 = $("#tel2");
            let tel3 = $("#tel3");
            let pw = $("#pw");
            let pwd_check = $("#pwd_check");
            let zipcode = $("#zipcode");
            let addr1 = $("#addr1");

            let tel1ErrorMsg = $("#tel1ErrorMsg");
            let pwdErrorMsg = $("#pwdErrorMsg");
            let pwd_checkErrorMsg = $("#pwd_checkErrorMsg");
            let zipcodeErrorMsg = $("#zipcodeErrorMsg");
            let addr1ErrorMsg = $("#addr1ErrorMsg");

            tel1ErrorMsg.css("display", "none");
            pwdErrorMsg.css("display", "none");
            pwd_checkErrorMsg.css("display", "none");
            zipcodeErrorMsg.css("display", "none");
            addr1ErrorMsg.css("display", "none");

            let isValid = true;

            if (!tel1.val() || !tel2.val() || !tel3.val() || !telRegex()) {
                tel1ErrorMsg.html("전화번호를 입력해 주세요");
                tel1ErrorMsg.css("display", "block");
                isValid = false;
            }

            if (!pw.val() && pwd_check.val()) {
                pwdErrorMsg.html("비밀번호를 입력해 주세요");
                pwdErrorMsg.css("display", "block");
                isValid = false;
            }

            if (!pwd_check.val() && pw.val()) {
                pwd_checkErrorMsg.html("비밀번호 확인을 입력해 주세요");
                pwd_checkErrorMsg.css("display", "block");
                isValid = false;
            }

            if (!zipcode.val()) {
                zipcodeErrorMsg.html("우편주소를 입력해 주세요");
                zipcodeErrorMsg.css("display", "block");
                isValid = false;
            }

            if (!addr1.val()) {
                addr1ErrorMsg.html("주소를 입력해 주세요");
                addr1ErrorMsg.css("display", "block");
                isValid = false;
            }

            return isValid;
        }





        function goDelete(event) {
            event.preventDefault();
            let pw = $("#wdPwd").val();
            let wdPwdErrorMsg = $("#wdPwdErrorMsg");
            isValid = fieldCheckDelete()
            if (isValid) {
                $.ajax({
                    url: "/user/user/deletecheck",
                    method: 'post',
                    contentType: "application/json",
                    dataType: "json",
                    async: false,
                    data: JSON.stringify({
                        "pw" : pw,
                    }),
                    success: function (response) {
                        console.log(response)
                        if(response == '0'){
                            wdPwdErrorMsg.html("비밀번호가 맞지 않습니다").css("display","block");
                        } else{
                            // console.log(response);
                            $("#frmDelete").submit();
                        }
                    }
                });
            }
        }

        function fieldCheckDelete() {
            let wdPwd = $("#wdPwd");
            let wdPwdErrorMsg = $("#wdPwdErrorMsg");

            wdPwdErrorMsg.css("display", "none");

            let isValid = true;

            if (!wdPwd.val()) {
                wdPwdErrorMsg.html("비밀번호를 입력해 주세요");
                wdPwdErrorMsg.css("display", "block");
                isValid = false;
            }
            return isValid;
        }

        function zipcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var roadAddr = data.roadAddress;
                    var extraRoadAddr = '';

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }

                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }

                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    $('#zipcode').val(data.zonecode);
                    $('#addr1').val(roadAddr);
                }
            }).open();
        }
    </script>
</head>

<body>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%@ include file="/WEB-INF/views/user/include/mypageInfo.jsp" %>
<section class="pt-5">
    <div class="container">
        <div class="row gutter-4 justify-content-between">
            <aside class="col-lg-3">
                <div class="nav nav-pills flex-column lavalamp" id="sidebar-1" role="tablist">
                    <a class="nav-link active" data-toggle="tab" href="#sidebar-1-1" role="tab"  aria-controls="sidebar-1" aria-selected="true">Orders</a>
                    <a class="nav-link" data-toggle="tab" href="#sidebar-1-2" role="tab" aria-controls="sidebar-1-2" aria-selected="false">Reviews</a>
                    <a class="nav-link" data-toggle="tab" href="#sidebar-1-3" role="tab" aria-controls="sidebar-1-3" aria-selected="false">QnA</a>
                    <a class="nav-link" data-toggle="tab" href="#sidebar-1-4" role="tab" aria-controls="sidebar-1-4" aria-selected="false">Profile</a>
                    <a class="nav-link" data-toggle="tab" href="#sidebar-1-5" role="tab" aria-controls="sidebar-1-5" aria-selected="false">Point</a>
                </div>
                <br>
                <br>
                <div class="nav nav-pills flex-column" id="sidebar-2" role="tablist">
                    <p style="text-align:center;margin-bottom: 0; text-decoration-color:#c2c2c2; font-size: x-large; background-color:#79AC78;border-color: #79AC78; color: #FFFFFF;">Withdrawal</p>
                    <button class="btn"  style="color: rgb(108, 117, 125); font-family: 'Open Sans', sans-serif;" data-toggle="modal" data-target="#exampleModal-2" type="button" role="tab" aria-controls="sidebar-1-2" aria-selected="false">Deactivate Account</button>
                </div>
            </aside>

            <div class="col-lg-9">
                <div class="row">
                    <div class="col">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="sidebar-1-1" role="tabpanel" aria-labelledby="sidebar-1-1">
                                <div class="row mb-2">
                                    <div class="col-12">
                                        <h3>Profile</h3>
                                    </div>
                                </div>
                                <form class="row gutter-1" id="frm">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="id">아이디</label>
                                            <input id="id" name="id" value="${vo.id}" type="text" class="form-control" placeholder="" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="email">이메일</label>
                                            <input id="email" name="email" type="text" class="form-control" placeholder="" readonly value="${vo.email}">
                                        </div>
                                    </div>
                                    <div class="col-md-8 align-content-between">
                                        <div class="form-group d-flex align-items-center">
                                            <label>전화번호</label>
                                        </div>
                                        <div class="form-group d-flex align-items-center justify-content-between">
                                            <input type="number" class="form-control col-3 mr-1" name="receiverTel1" id="tel1" value="${tel1}">
                                            <p class="d-flex justify-content-center align-items-center col-1 mr-0 mb-0"> - </p>
                                            <input type="number" class="form-control col-3 mx-1" name="receiverTel2" id="tel2" value="${tel2}">
                                            <p class="d-flex justify-content-center align-items-center col-1 mr-0 mb-0"> - </p>
                                            <input type="number" class="form-control col-3 ml-1" name="receiverTel3" id="tel3" value="${tel3}">
                                        </div>
                                        <div class="invalid-feedback" id="tel1ErrorMsg"></div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="pw">새로운 비밀번호</label>
                                            <input id="pw" type="password" class="form-control" placeholder="" value="">
                                            <div class="invalid-feedback" id="pwdErrorMsg"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="pwd_check">비밀번호 확인</label>
                                            <input id="pwd_check" type="password" class="form-control" placeholder="">
                                            <div class="invalid-feedback" id="pwd_checkErrorMsg"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="zipcode">우편번호</label>
                                            <input id="zipcode" type="text" class="form-control" value="${vo.zipcode}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-4 d-flex justify-content-lg-start align-items-sm-end">
                                        <div class="form-group d-flex justify-content-lg-start align-items-sm-end">
                                            <label for="adr_btn"></label>
                                            <button type="button" class="btn btn-primary btn-rounded" id="adr_btn" >우편번호</button>
                                        </div>
                                    </div>
                                    <div class="invalid-feedback" id="zipcodeErrorMsg"></div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="addr1"></label>
                                            <input id="addr1" type="text" class="form-control" value="${vo.addr}" readonly>
                                            <div class="invalid-feedback" id="addr1ErrorMsg" ></div>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="addr_detail"></label>
                                            <input id="addr_detail" type="text" class="form-control" value="${vo.addr_detail}">
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <input id="relTel" name="relTel" type="hidden" class="form-control" placeholder="tel">
                                        </div>
                                    </div>
                                    <div class="col-md-8 d-flex align-items-center justify-content-end">
                                        <div class="form-group">
                                            <button type="button" onclick="goProfile(event)" class="btn btn-primary">수정</button>
                                        </div>
                                    </div>
                                </form>
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
                                            <form id="frmDelete" action="http:/user/user/delete" method="get">
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label for="wdPwd">비밀번호</label>
                                                    <input type="password" id="wdPwd" class="form-control form-control-lg" placeholder="password" aria-label="wdPwd" name="pw">
                                                </div>
                                                <div style="padding: 10px" class="d-flex align-items-center justify-content-center">
                                                    <div class="invalid-feedback" id="wdPwdErrorMsg">비밀번호를 확인해 주세요</div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <div class="container-fluid">
                                                    <div class="row gutter-0">
                                                        <div class="col">
                                                            <button type="button" class="btn btn-block btn-secondary" data-dismiss="modal">Close</button>
                                                        </div>
                                                        <div class="col">
                                                            <button type="button" class="btn btn-block btn-primary" id="btn_frm2" onclick="goDelete(event)">확인</button>
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
