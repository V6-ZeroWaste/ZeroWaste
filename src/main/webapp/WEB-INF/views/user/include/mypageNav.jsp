<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
		<aside class="col-lg-3">
            <div class="nav nav-pills flex-column" id="sidebar-1">
              <a id="mp-order" class="nav-link" href="/mypage/order/list" aria-selected="false">Orders</a>
              <a id="mp-review" class="nav-link" href="/mypage/review/list" aria-selected="false">Reviews</a>
              <a id="mp-qna" class="nav-link" href="/mypage/qna/list" aria-selected="false">QnA</a>
              <a id="mp-profile" class="nav-link" href="/user/user/profile" aria-selected="false">Profile</a>
              <a id="mp-point" class="nav-link" href="/mypage/point/list" aria-selected="false">Point</a>
            </div>
          </aside>
          <script>
          url = (window.location.pathname).split('/')
          if(url[1]=='order' || url[2]=='order'){
        	  element = document.getElementById('mp-order');
          }
          if(url[2]=='review'){
        	  element = document.getElementById('mp-review');
          }
          if(url[2]=='qna'){
        	  element = document.getElementById('mp-qna');
          }
          if(url[2]=='profile'){
        	  element = document.getElementById('mp-profile');
          }
          if(url[2]=='point'){
        	  element = document.getElementById('mp-point');
          }
          element.className += ' active';
          element.setAttribute('aria-selected', 'true');
          element.style.cssText  = 'border: 0.5px solid black;';
          </script>



    


    


    


    


    