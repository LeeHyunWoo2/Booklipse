<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Course</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Course Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/resources/styles/bootstrap4/bootstrap.min.css">
    <link href="/resources/plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet"
          type="text/css">
    <link rel="stylesheet" type="text/css"
          href="/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
    <link rel="stylesheet" type="text/css"
          href="/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="/resources/plugins/OwlCarousel2-2.2.1/animate.css">
    <link rel="stylesheet" type="text/css" href="/resources/styles/main_styles.css">
    <link rel="stylesheet" type="text/css" href="/resources/styles/responsive.css">
</head>
<body>

<div class="super_container">

    <!-- Header -->

    <header class="header d-flex flex-row">
        <div class="header_content d-flex flex-row align-items-center">
            <!-- Logo -->
            <div class="logo_container">
                <div class="logo">
                    <img src="/resources/images/book_log.png">
                    <span><a href="/library/home">Booklipse</a></span>
                </div>
                <div style="margin-left: 20%;">
                    <jsp:include page="../includes/developHelper.jsp"/>
                </div>
            </div>

            <!-- Main Navigation -->
            <nav class="main_nav_container">
                <div class="main_nav">
                    <ul class="main_nav_list">
                        <li class="main_nav_item"><a href="/library/home">HOME</a></li>
                        <li class="main_nav_item"><a href="#">국내도서</a></li>
                        <li class="main_nav_item"><a href="courses.html">베스트</a></li>
                        <li class="main_nav_item"><a href="elements.html">신상품</a></li>
                        <li class="main_nav_item"><a href="news.html">도서대여</a></li>
                        <li class="main_nav_item"><a href="/library/list">게시판</a></li>
                        <c:if test="${user.authority == 1 }">
                            <li class="main_nav_item"><a href="/library/admin/main">어드민페이지</a></li>
                        </c:if>
                    </ul>
                </div>
            </nav>
        </div>
        <div class="header_side d-flex flex-row justify-content-center align-items-center">
            <!-- <img src="/resources/images/profile.svg"> -->
            <span>
			<!-- 로그인 하지 않은 상태 -->
			<c:if test="${user == null }">
                <a href="/library/login">로그인</a>
            </c:if>
                <!-- 로그인 한 상태 -->
			<c:if test="${user != null }">
				<div class="login_success_area">
					<span><a href="/library/myPage">${user.nickName }</a></span>
				</div>
                <div class="logout_button">
					<a href="/library/logout" id="logout_button">로그아웃</a>
				</div>
            </c:if>


		</span>
        </div>

        <!-- Hamburger -->
        <div class="hamburger_container">
            <i class="fas fa-bars trans_200"></i>
        </div>

    </header>

    <!-- Menu -->
    <div class="menu_container menu_mm">

        <!-- Menu Close Button -->
        <div class="menu_close_container">
            <div class="menu_close"></div>
        </div>

        <!-- Menu Items -->
        <div class="menu_inner menu_mm">
            <div class="menu menu_mm">
                <ul class="menu_list menu_mm">
                    <li class="menu_item menu_mm"><a href="#">Home</a></li>
                    <li class="menu_item menu_mm"><a href="#">About us</a></li>
                    <li class="menu_item menu_mm"><a href="courses.html">Courses</a></li>
                    <li class="menu_item menu_mm"><a href="elements.html">Elements</a></li>
                    <li class="menu_item menu_mm"><a href="news.html">News</a></li>
                    <li class="menu_item menu_mm"><a href="contact.html">Contact</a></li>
                </ul>

                <!-- Menu Social -->

                <div class="menu_social_container menu_mm">
                    <ul class="menu_social menu_mm">
                        <li class="menu_social_item menu_mm"><a href="#"><i
                                class="fab fa-pinterest"></i></a></li>
                        <li class="menu_social_item menu_mm"><a href="#"><i
                                class="fab fa-linkedin-in"></i></a></li>
                        <li class="menu_social_item menu_mm"><a href="#"><i
                                class="fab fa-instagram"></i></a></li>
                        <li class="menu_social_item menu_mm"><a href="#"><i
                                class="fab fa-facebook-f"></i></a></li>
                        <li class="menu_social_item menu_mm"><a href="#"><i
                                class="fab fa-twitter"></i></a></li>
                    </ul>
                </div>

                <div class="menu_copyright menu_mm">Colorlib All rights reserved</div>
            </div>

        </div>

    </div>
</div>
</body>
</html>