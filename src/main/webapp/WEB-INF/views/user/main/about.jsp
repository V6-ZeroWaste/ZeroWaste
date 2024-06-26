<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
    <link rel="stylesheet" href="/user/css/vendor.css"/>
    <link rel="stylesheet" href="/user/css/style.css"/>

    <title>soaff</title>
    <%@ include file="/WEB-INF/views/user/include/header.jsp" %>
</head>
<body>

<!-- lookbook -->
<section class="hero bg-purple text-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <h1 class="mb-2">SOAFF STORY</h1>
                <h4>제로웨이스트를 널리 실현하기 위해 SOAFF를 만들었습니다.</h4>
                <p>SOAFF는 'Soap'과 'Show off'의 합성어로, '자랑하고 싶은 비누'라는 의미를 담고 있습니다.</p>
                <p>SOAFF의 제품을 사용하면 플라스틱 사용을 줄일 수 있습니다. 샴푸, 바디워시, 주방세제 등을 비누 형태로 바꿔 제공함으로써, 환경에 긍정적인 영향을 미치고 있습니다.</p>
                <p>SOAFF는 비누로 시작해 다양한 상품군으로 확장해 나가며, 플라스틱 발생량 감소에 기여하고자 하는 책임감을 가지고 기업을 운영하고 있습니다.</p>
                <h4>SOAFF를 소비하는 것만으로도 제로웨이스트 운동에 동참한다는 사실, </h4>
                <h4>매력적이지 않나요?</h4> 
            </div>
        </div>
        <div class="row gutter-1 masonry gallery collage mb-10">
            <div class="col-6">
                <figure class="equal equal-75">
                    <a class="image image-scale" 
                       style="background-image: url(/user/images/about-1.png);">
                    </a>
                </figure>
            </div>
            <div class="col-6">
                <figure class="equal equal-125">
                    <a class="image image-scale" 
                       style="background-image: url(/user/images/about-2.png);">
                    </a>
                </figure>
            </div>
            <div class="col-6">
                <figure class="equal equal-50">
                    <a class="image image-scale" 
                       style="background-image: url(/user/images/about-3.png);">
                    </a>
                </figure>
            </div>
        </div>
        
    </div>
</section>


<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
