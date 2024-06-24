<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Login - Admin</title>
        <link href="css/styles.css" rel="stylesheet" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script>
            $(document).ready(() => {
                $('#login').on('click', () => {
                    goSave();
                });

                $('#frm').on('keypress', (e) => {
                    if(e.key === 'Enter' || e.keyCode === '13'){
                        $('#login').click();
                    }
                });
            });


            function goSave(){
    		if($("#id").val().trim() == ''){
    			alert("아이디를 입력하세요.");
    			$("#id").focus();
    			return;
    		} 
    		if($("#pw").val().trim() == ''){
    			alert("비밀번호 입력하세요.");
    			$("#pw").focus();
    			return;
    		} 
    		
    		$("#frm").submit();
    		
    	}
    	</script>
    </head>
    <body class="bg-dark">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content" style="align-content:center;">
                <main  class="align-content-center" style="margin-top:-100px">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header">
                                    	<h3 class="text-center font-weight-light my-4">Soaff</h3>
                                    	<h3 class="text-center font-weight-light my-4">Admin Login</h3>
                                    </div>
                                    <div class="card-body">
                                        <form id="frm" action="/admin/login" method="post">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="id" name="id" type="text" placeholder="ID" />
                                                <label for="id">ID</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="pw" name="pw" type="password" placeholder="Password" />
                                                <label for="pw">PW</label>
                                            </div>
                                            <div class="failInfo">
                                            
                                            </div>
                                            <div class="d-flex align-items-center justify-content-center mt-4 mb-0">
                                                <!-- <a class="btn btn-primary" href="index.html">Login</a> -->
                                                <a class="btn btn-primary" href="javascript:;" class="btn" id='login' onclick="goSave();">Login</a>
                                                <!-- <input class="btn btn-primary" type="submit" value="Login"/> -->
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>
