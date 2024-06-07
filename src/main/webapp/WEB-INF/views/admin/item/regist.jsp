<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <script src="/smarteditor/js/HuskyEZCreator.js"></script>
    
    <script>
    var oEditors = [];
    $(function() {
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "content",
            sSkinURI: "/smarteditor/SmartEditor2Skin.html",    
            htParams : {
                bUseToolbar : true,                // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
                bUseVerticalResizer : true,        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
                bUseModeChanger : true,            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
                fOnBeforeUnload : function(){
                }
            }, //boolean
            fOnAppLoad : function(){
                //예제 코드
                //oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
            },
            fCreator: "createSEditor2"
        });
    });

    function goSave() {
        oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용됩니다.
        document.forms[0].submit(); // 폼 제출
    }
    
    </script>
    <script>
		var itemNo = "${item.item_no}"; 
		
		
		function deleteItem(){
			if(confirm("정말 삭제하시겠습니까?")){
			    $.ajax({
			        url : "/admin/item/delete", 
			        type : "POST",
			        data : {itemNo : itemNo}, 
			        success : function(response){
			            alert("삭제 성공"); 
		        		document.location.href = 'index';
			        },
			        error: function(xhr, status, error){
			            alert("삭제 실패: " + error); 
			        }
			    });
        	}
		}
		
		function deleteImg(){
			if(confirm("정말 삭제하시겠습니까?")){
			    $.ajax({
			        url : "/admin/item/deleteImg", 
			        type : "POST",
			        data : {itemNo : itemNo }, 
			        success : function(response){
			            alert("삭제 성공"); 
			            window.location.reload();
			        },
			        error: function(xhr, status, error){
			            alert("삭제 실패: " + error); 
			        }
			    });
        	}
		}
	</script>
	
	<script>
	    $(function(){
	        var itemImg = "${item.item_img}";
	        var deleteButton = $("input[name='x']");
	        
	        if(itemImg == null || itemImg.trim() === ""){
	            deleteButton.css("display", "none");
	        } else {
	            deleteButton.css("display", "block");
	        }
	    })
	</script>
</head>
<body>
    <button onclick="history.back()">돌아가기</button><br>
    <div class="box" style="width:40%;">
    <form method="post" action="regist" name="regist" enctype="multipart/form-data">
        상품 대표 이미지 <input type="file" name="file" id="file" class="wid100" />
        <img src="/upload/item_img/${item.item_img}" alt="Item Image" style="width: 25%"/>${item.item_img }
        <input type="hidden" name="item_img" value="${item.item_img }">
         <br>
        
        <input type="button" name="x" value="이미지삭제버튼" onclick="deleteImg()">
        카테고리 
        <select name="category_name">
            <c:forEach var="category" items="${categories}">
                <c:if test="${item.category_name == category}">
                    <option value="${category}" selected>${category}</option>
                </c:if>
                <c:if test="${item.category_name != category}">
                    <option value="${category}">${category}</option>
                </c:if>
            </c:forEach>
        </select>
        <br>
        <div class="form-item">
            상품명 <input type="text" name="name" value="${item.name}"><br>
        </div>
        <div class="form-item">
            상품설명 <input type="text" name="description" value="${item.description}" style="width:70%"> <br>
        </div>
        <div class="form-item">
            재고 <input type="text" name="amount" value="${item.amount}"> <br>
        </div>
        <div class="form-item">
            포장 가능 여부
            <input type="radio" name="packable_option" value="true"
                ${item.packable_option ? 'checked="checked"' : '' }
            >가능 |
            <input type="radio" name="packable_option" value="false"
                ${!item.packable_option ? 'checked="checked"' : '' }
            >불가능
        </div>
        <div class="form-item">
            상품 가격 <input type="text" name="price" value="${item.price}">원 <br>
        </div>
        <div class="form-item">
            할인율 <input type="text" name="discount_rate" value="${item.discount_rate}" disabled style="width:30px">% <br>
        </div>
        <div class="form-item">
            판매 가격 <input type="text" name="discounted_price" value="${item.discounted_price}" >원 <br>
        </div>
        <div class="form-item">
            노출 여부 
            <input type="radio" name="exposed_status" value="true"
                ${item.exposed_status ? 'checked="checked"' : '' }
            >노출 |
            <input type="radio" name="exposed_status" value="false"
                ${!item.exposed_status ? 'checked="checked"' : '' }
            >숨김
        </div>
        <div class="form-item">
             
        </div>
            상품 상세 <textarea name="detail" id="content" style="width:100%;" > ${item.detail} </textarea>
        <input class="btn" type="button" value="등록하기" onclick="goSave()">
    </form>
    </div>
</body>
</html>