<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <a class="nav-link" href="/admin/dashboard/index">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    대시보드
                </a>
                <a class="nav-link" href="/admin/item/list">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    상품관리
                </a>
                <a class="nav-link" href="/admin/order/list">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    주문관리
                </a>
                <a class="nav-link" href="/admin/cancel/list">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    취소관리
                </a>
                <a class="nav-link" href="/admin/review/list">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    상품 리뷰 관리
                </a>
                <a class="nav-link" href="/admin/qna/list">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    상품 문의 관리
                </a>
                <a class="nav-link" href="/admin/user/list">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    회원관리
                </a>
                
                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                    <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                    통계
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="/admin/statistics/sales/index">매출 통계</a>
                        <a class="nav-link" href="/admin/statistics/items">상품 통계</a>
                        <a class="nav-link" href="/admin/statistics/users/index">회원 통계</a>
                    </nav>
                </div>
            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small">Logged in as:</div>
            Start Bootstrap
        </div>
    </nav>
</div>