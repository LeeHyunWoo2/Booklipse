<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<style>
  .booklist * {
    font-family: "Noto Sans KR", sans-serif;
    font-optical-sizing: auto;
    font-size: 1rem;
    font-weight: 500; /* 일반 글씨 */
    font-style: normal;
  }

  .home2 {
    width: 100%;
    height: 50vh;
  }

  /* 리스트형 스타일 */
  .list_wrap {
    min-height: 100vh;
    text-align: center;
  }

  .listcard {
    width: 975px;
    height: 30vh;
    padding: 0.4em;
    border-radius: 6px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: inline-block;
    cursor: pointer;
  }

  .content-wrapper {
    display: flex;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    align-items: flex-start;
  }

  .listcard:hover {
    background-color: #f3f3f3;
  }

  .listcard-image {
    height: 28vh;
    border-radius: 3px;
  }

  .listcard-body {
    display: flex;
    flex-direction: column;
    justify-content: space-between; /* 공간을 고르게 분배 */
    height: 28vh; /* 전체 높이 고정 */
    padding: 1.4vh;
  }

  .listcard-content {
    display: flex;
    flex-direction: column;
  }

  .booktitle {
    height: 8vh;
    font-size: 22px; /* 제목 크기 */
    font-weight: bold;
    color: #3a3a3a;
    margin-bottom: 10px; /* 제목과 나머지 정보 사이의 간격 */
    line-height: 1.4;
    overflow: hidden;
    text-overflow: ellipsis;
    width: 90%;
  }

  .info-line {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
  }

  .info-line span {
    font-size: 15px; /* 정보 텍스트 크기 */
    width: 48%;
    margin-bottom: 10px;
    color: #626262;
  }

  /* 그리드형 스타일 */
  .grid_wrap {
    display: none;
    flex-wrap: wrap;
    gap: 16px;
    justify-content: space-between; /* 항목들 사이의 간격을 균등하게 배치 */
    min-height: 100vh;
  }

  .grid_wrap .gridcard {
    position: relative;
    width: 300px;
    height: 450px;
    margin: 20px;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    transition: transform 0.5s cubic-bezier(0.215, 0.61, 0.355, 1);
  }

  .gridcard:hover {
    transform: translateY(-10px);
  }

  .gridcard .gridcard__image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    border-radius: 10px;
    background-color: #efefef;
  }

  .gridcard .gridcard__image img {
    width: 100%;
    height: 225px;
    transition: transform 0.5s cubic-bezier(0.215, 0.61, 0.355, 1);
  }

  .gridcard:hover .gridcard__image img {
    transform: scale(1);
  }

  .gridcard .gridcard__content {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    max-height: 50%;
    padding: 20px;
    background-color: #fff;
    transition: transform 0.5s cubic-bezier(0.215, 0.61, 0.355, 1);
  }

  .gridcard .gridcard__title {
    height: 8vh;
    color: #000;
    font-size: 18px;
    font-weight: bold;
    overflow: hidden;
    text-overflow: ellipsis;
    border-bottom: solid 1px #000000;
    padding-bottom: 85px;
    margin-top: -10px;
  }

  .gridcard .gridcard__text {
    color: #000;
    font-size: 14px;
    line-height: 1.5;
    margin-top: 5px;
  }

  .modal {
    display: none; /* 기본적으로 숨김 */
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.5); /* 어두운 배경 */
  }

  .modal-content {
    background-color: white;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 90%;
    font-family: "Noto Sans KR", sans-serif;
    font-optical-sizing: auto;
    font-size: 1rem;
    font-weight: 500; /* 일반 글씨 */
    font-style: normal;
  }

  button {
    cursor: pointer;
  }

  .prlx2 {
    height: 100% !important;
  }

  .search-mode {
    border: 2px solid #28a745 !important; /* 테두리 색상 */
    border-radius: 5px !important; /* 모서리 둥글게 */
    background-color: #fff !important; /* 배경색 */
    min-width: 500px;
  !important;
  }

  .page-mode {
    border: 2px solid #dc3545 !important; /* 점선 테두리 */
    border-radius: 5px !important; /* 모서리 더 둥글게 */
    background-color: #fff !important; /* 연한 회색 배경 */
    min-width: 300px;
  !important;
  }

  .toggle-search {
    background-color: #FFFFFF !important;
    color: #dc3545 !important;
    border-color: #dc3545 !important;
  }

  .toggle-search2 . .btn-outline-success {
    background-color: #FFFFFF !important;
    color: #28a745 !important;
    border-color: #28a745 !important;
  }

  .toggle-page {
    background-color: #dc3545 !important;
    color: #FFFFFF !important;
    border-color: #dc3545 !important;
  }

  /* 기본적으로 숨긴 상태로 시작 */
  .back_to_top {
    position: fixed;
    bottom: -100px; /* 화면 아래로 숨김 */
    right: 5vh;
    width: 15vh;
    height: 5vh;
    opacity: 0.9;
    transition: bottom 0.2s ease-in-out, opacity 0.2s ease-in-out; /* 애니메이션 효과 */
    z-index: 9999;
    cursor: pointer;
    display: flex;
    justify-content: center;
  }

  .back_to_top.on {
    bottom: 5vh; /* 화면 아래쪽에서 위로 올라옴 */
  }

  .top_button {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: rgb(20, 20, 20);
    border: none;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0px 0px 0px 4px rgba(180, 160, 255, 0.13);
    cursor: pointer;
    transition-duration: 0.3s;
    overflow: hidden;
    position: relative;
  }

  .svgIcon {
    width: 20px;
    transition-duration: 0.3s;
  }

  .svgIcon path {
    fill: white;
  }

  .top_button:hover {
    width: 140px;
    border-radius: 50px;
    transition-duration: 0.3s;
    background-color: rgb(0, 0, 0);
    align-items: center;
  }

  .top_button:hover .svgIcon {
    /* width: 20px; */
    transition-duration: 0.3s;
    transform: translateY(-200%);
  }

  .top_button::before {
    position: absolute;
    bottom: -20px;
    content: "Back to Top";
    color: white;
    /* transition-duration: .3s; */
    font-size: 0px;
  }

  .top_button:hover::before {
    font-size: 15px;
    opacity: 1;
    bottom: unset;
    /* transform: translateY(-30px); */
    transition-duration: 0.3s;
  }

  /*보기라디오박스*/

  .tabs {
    display: inline-flex;
    max-height: 54px;
    position: relative;
    background-color: #fff;
    box-shadow: 0 0 1px 0 rgba(24, 94, 224, 0.15), 0 6px 12px 0 rgba(24, 94, 224, 0.15);
    padding: 0.75rem;
    margin: 5px;
    border-radius: 99px;
  }

  .tabs * {
    z-index: 2;
  }

  .view-container input[type="radio"] {
    display: none;
  }

  .tab {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 30px;
    width: 80px;
    font-size: 1rem;
    color: black;
    font-weight: 500;
    border-radius: 99px;
    cursor: pointer;
    transition: color 0.15s ease-in;
  }


  .view-container input[type="radio"]:checked + label {
    color: #185ee0;
  }

  .view-container input[type="radio"]:checked + label > .notification {
    background-color: #185ee0;
    color: #fff;
    margin: 0px;
  }

  .view-container input[id="radio-1"]:checked ~ .glider {
    transform: translateX(0);
  }

  .view-container input[id="radio-2"]:checked ~ .glider {
    transform: translateX(100%);
  }

  .view-container input[id="radio-3"]:checked ~ .glider {
    transform: translateX(200%);
  }

  .glider {
    position: absolute;
    display: flex;
    height: 37px;
    width: 80px;
    background-color: #e6eef9;
    z-index: 1;
    border-radius: 99px;
    transition: 0.25s ease-out;
    margin-top: -3px;
  }


  .bi {
    font-size: 28px;
    color: black;
  }

  /* From Uiverse.io by vinodjangid07 */
  .setting-btn {
    width: 45px;
    height: 45px;
    display: flex;
    margin-right: 13%;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 6px;
    background-color: #73808c;
    border-radius: 10px;
    cursor: pointer;
    border: none;
    box-shadow: 0px 0px 0px 2px rgb(228, 228, 228);
  }

  .bar {
    width: 50%;
    height: 2px;
    background-color: rgb(229, 229, 229);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    border-radius: 2px;
  }

  .bar::before {
    content: "";
    width: 2px;
    height: 2px;
    background-color: #73808c;
    position: absolute;
    border-radius: 50%;
    border: 2px solid white;
    transition: all 0.3s;
    box-shadow: 0px 0px 5px white;
  }

  .bar1::before {
    transform: translateX(-4px);
  }

  .bar2::before {
    transform: translateX(4px);
  }

  .setting-btn:hover .bar1::before {
    transform: translateX(4px);
  }

  .setting-btn:hover .bar2::before {
    transform: translateX(-4px);
  }

  .autocomplete-items {
    position: absolute; /* 텍스트 입력창 바로 아래에 고정 */
    top: 100%; /* 입력창 바로 아래에 위치하게 함 */
    left: 0;
    right: 0;
    margin-left: 30rem;
    margin-right: 30rem;
    border: 1px solid #d4d4d4;
    background-color: white;
    z-index: 1000; /* 다른 요소들 위에 나타나도록 설정 */
    max-height: 242px; /* 최대 높이 설정, 스크롤 가능 */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    overflow: auto;
    visibility: hidden;
  }

  .autocomplete-items div {
    padding: 10px;
    cursor: pointer;
    background-color: #fff;
  }

  .autocompleteul {
    list-style-type: none;
    padding: 0;
    margin: 0;
  }

  .autocompleteli {
    color: #000;
    padding: 8px;
  }

  .autocompleteli:hover {
    background-color: #c8dbff;
  }

  .autocompleteli.hl {
    background-color: #c8dbff;
  }

  .highlight {
    font-weight: bold; /* 글자를 볼드체로 설정 */
    background-color: #fff3a3;
  }


  .rebutton {
    --main2-focus: #2d8cf0;
    --font2-color: #323232;
    --bg2-color-sub: #dedede;
    --bg2-color: #eee;
    --main2-color: #323232;
    position: relative;
    width: 150px;
    height: 40px;
    cursor: pointer;
    display: flex;
    align-items: center;
    border: 2px solid var(--main2-color);
    box-shadow: 4px 4px var(--main2-color);
    background-color: var(--bg2-color);
    border-radius: 10px;
    overflow: hidden;
  }

  .rebutton, .rebutton__icon, .rebutton__text {
    transition: all 0.2s;
  }

  .rebutton .rebutton__text {
    transform: translateX(30px);
    color: var(--font2-color);
    font-weight: 600;
  }

  .rebutton .rebutton__icon {
    position: absolute;
    transform: translateX(109px);
    height: 100%;
    width: 39px;
    background-color: var(--bg2-color-sub);
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .rebutton .resvg {
    width: 20px;
    fill: var(--main2-color);
  }

  .rebutton:hover {
    background: var(--bg2-color);
  }

  .rebutton:hover .rebutton__text {
    color: transparent;
  }

  .rebutton:hover .rebutton__icon {
    width: 148px;
    transform: translateX(0);
  }

  .rebutton:active {
    transform: translate(3px, 3px);
    box-shadow: 0px 0px var(--main2-color);
  }

  .dropdown-item2 {
    display: block;
    width: 100%;
    padding: .25rem 1.5rem;
    clear: both;
    font-weight: 400;
    color: #212529;
    text-align: inherit;
    white-space: nowrap;
    background: 0 0;
    border: 0;
  }

  .PB-range-slider {
    -webkit-appearance: none;
    width: 100%;
    height: 4px;
    border-radius: 5px;
    background: #D5DBE1;
    outline: none;
    opacity: 0.7;
    -webkit-transition: .2s;
    transition: opacity .2s;
  }

  .PB-range-slider::-webkit-slider-thumb {
    -webkit-appearance: none;
    appearance: none;
    width: 15px;
    height: 15px;
    border-radius: 50%;
    background-color: #000000;
    cursor: pointer;
    transition: 0.3s ease-in-out;
  }

  .PB-range-slider::-webkit-slider-thumb:hover {
    box-shadow: 0px 0px 0px 8px rgba(0, 0, 0, 0.16);
    transition: 0.3s ease-in-out;
  }

  .PB-range-slider-div {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 1rem;
    padding: 1rem;
    border-radius: 6px;
    border: 1px solid #C6CACE;
    box-shadow: 0px 1px 2px 0px #1F1E241F;
  }

  .PB-range-slidervalue {
    font-weight: 600;
  }
</style>

<head>
    <title>도서목록</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Course Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/resources/styles/courses_styles.css">
    <link rel="stylesheet" type="text/css" href="/resources/styles/courses_responsive.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css"
          rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
          rel="stylesheet">
    <jsp:include page="../includes/header.jsp"/>
</head>
<body class="booklist">

<div class="super_container">
    <div class="home2">
        <div class="home_background_container prlx_parent">
            <div class="home_background prlx2"
                 style="background-image:url(/resources/images/courses_background.jpg)"></div>
        </div>
        <div class="home_content">
            <h1>도서목록</h1>
        </div>
    </div>

    <div class="back_to_top">
        <button class="top_button">
            <svg class="svgIcon" viewBox="0 0 384 512">
                <path d="M214.6 41.4c-12.5-12.5-32.8-12.5-45.3 0l-160 160c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L160 141.2V448c0 17.7 14.3 32 32 32s32-14.3 32-32V141.2L329.4 246.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3l-160-160z"></path>
            </svg>
        </button>
    </div>
</div>
<c:if test="${user.authority == 1 }">
    <button class="btn btn-outline-secondary" id="userPreference" data-toggle="modal"
            data-target="#modal2">선호도 확인
    </button>
</c:if>

<div class="modal fade" id="modal2" tabindex="-1" role="dialog" style="color: black"
     aria-labelledby="advancedSearchLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content" style="min-width: 600px;">
            <div class="modal-header">
                <h5 class="modal-title">선호도 분석</h5>
            </div>
            <div class="modal-body">
                <label for="userIdInput">유저 ID 입력: </label>
                <input type="text" id="userIdInput" placeholder="유저 ID 입력" value="test123">
                <div id="preferencesOutput"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-warning" onclick="resetPreference()">
                    초기화
                </button>
                <button type="button" class="btn btn-secondary" onclick="resetPreference()"
                        data-dismiss="modal">닫기
                </button>
                <button id="getPreferencesButton" class="btn btn-primary">검색
                </button>
            </div>
        </div>
    </div>
</div>

<div class="position-static" style="z-index: 1030;">
    <nav class="navbar navbar-light bg-light">
        <button class="setting-btn" type="button" data-toggle="collapse"
                data-target="#navbarToggle"
                aria-controls="navbarToggle" style="outline: none;" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="bar bar1"></span>
            <span class="bar bar2"></span>
            <span class="bar bar1"></span>
        </button>
        <button id="resetButton" type="button" class="rebutton" style="outline: none;
                    margin-left: -20%;">
            <span class="rebutton__text">초기화</span>
            <span class="rebutton__icon"><svg class="resvg" height="48" viewBox="0 0 48 48"
                                              width="48" xmlns="http://www.w3.org/2000/svg"><path
                    d="M35.3 12.7c-2.89-2.9-6.88-4.7-11.3-4.7-8.84 0-15.98 7.16-15.98 16s7.14 16 15.98 16c7.45 0 13.69-5.1 15.46-12h-4.16c-1.65 4.66-6.07 8-11.3 8-6.63 0-12-5.37-12-12s5.37-12 12-12c3.31 0 6.28 1.38 8.45 3.55l-6.45 6.45h14v-14l-4.7 4.7z"></path><path
                    d="M0 0h48v48h-48z" fill="none"></path></svg></span>
        </button>
        <form class="form-inline mt-1 mb-1" onsubmit="handleFormSubmit(event)"
              style="display: flex; justify-content: center">
            <button id="toggleButton" type="button"
                    class="btn btn-outline-danger mr-2 my-sm-2 toggle-mode"
                    onclick="toggleFunction()"
                    data-toggle="tooltip" data-placement="top" title="검색모드로 전환합니다.">페이지 이동
            </button>

            <input id="searchInput" class="form-control search-mode mr-sm-2" type="text"
                   placeholder="간편검색" aria-label="Search" required>
            <div id="autocompleteList" class="autocomplete-items"></div>

            <button id="toggleButton2" class="btn btn-outline-success my-2 my-sm-0 toggle-mode"
                    type="submit"
                    data-toggle="tooltip" data-placement="bottom"
                    title="검색을 시작합니다.">검색
            </button>

        </form>
        <div class="view-container">
            <div class="tabs">
                <input type="radio" id="radio-1" name="tabs" value="list" checked="">
                <label class="tab" for="radio-1"><i class="bi bi-list-ul"></i></label>
                <input type="radio" id="radio-2" name="tabs">
                <label class="tab" for="radio-2"><i class="bi bi-grid"></i></label>
                <span class="glider"></span>
            </div>
            <button id="sortButton" class="btn btn-info" onclick="toggleSortOrder()"
                    style="min-width: 90px; margin-bottom: 5%;">최신순
            </button>

        </div>
    </nav>
    <div class="collapse navbar-collapse show" id="navbarToggle">
        <div class="bg-light p-5" style="min-height: 100px">
            <div class="btn-group" role="group">
                <button id="dropdownMenuButton" type="button"
                        class="btn btn-secondary dropdown-toggle"
                        data-toggle="dropdown" aria-expanded="false">
                    카테고리
                </button>
                <ul id="categoryDropdownContainer" class="dropdown-menu">
                </ul>
                <div id="subMenuWrapper">
                </div>
            </div>
            <!-- 고급 검색 버튼 -->
            <button class="btn btn-primary" data-toggle="modal" data-target="#modal1">고급 검색
            </button>
            <div class="btn-group">
                <!-- 드롭다운 버튼 -->
                <button type="button" class="btn btn-info dropdown-toggle"
                        id="itemsPerPageButton" data-toggle="dropdown" aria-expanded="false">
                </button>
                <!-- 드롭다운 메뉴 -->
                <ul class="dropdown-menu" id="itemsPerPageMenu">
                    <li class="dropdown-item2" style="cursor: pointer;"
                        data-value="10"></li>
                    <li class="dropdown-item2" style="cursor: pointer;"
                        data-value="20"></li>
                    <li class="dropdown-item2" style="cursor: pointer;"
                        data-value="50"></li>
                </ul>
                <c:if test="${user.authority == 1 }">
                    <button type="button" class="btn btn-outline-success ml-1"
                            onclick="window.location.href='/library/manage?mode=add'">도서 추가
                    </button>
                </c:if>
            </div>

            <!-- 모달 창 -->
            <div class="modal fade" id="modal1" tabindex="-1" role="dialog" style="color: black"
                 aria-labelledby="advancedSearchLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="advancedSearchLabel">고급 검색은 추후 업데이트
                                됩니다.</h5>
                        </div>
                        <div class="modal-body">
                            <form id="advancedSearchForm">
                                <!-- 검색어 입력 -->
                                <div class="form-group">
                                    <label for="keyword">검색어</label>
                                    <input type="text" class="form-control" id="keyword"
                                           name="keyword">
                                </div>
                                <!-- 검색 기준 -->
                                <div class="form-group">
                                    <label for="searchType">검색 기준</label>
                                    <select class="form-control" id="searchType" name="type">
                                        <option value="title">책 제목</option>
                                        <option value="author">저자</option>
                                        <option value="publisher">출판사</option>
                                    </select>
                                </div>
                                <!-- 가격 범위 (일반 텍스트 박스) -->

                                <div class="form-group">
                                    <label for="maxPrice">최대 가격</label>
                                    <input type="text" class="form-control" id="maxPrice"
                                           name="maxPrice"
                                           placeholder="최대 가격">
                                </div>
                                <!-- 출판일 범위 -->
                                <div class="form-group">
                                    <label for="publicationDateRange">출판일 범위</label>
                                    <select class="form-control" id="publicationDateRange"
                                            name="publicationDateRange">
                                        <option value="">전체</option>
                                        <option value="3months">최근 3개월</option>
                                        <option value="6months">최근 6개월</option>
                                        <option value="1year">최근 1년</option>
                                    </select>
                                </div>
                                <!-- 최소 평점 (라디오 버튼) -->
                                <div class="form-group">
                                    <label>최소 평균 리뷰점수</label><br>
                                    <div class="PB-range-slider-div">
                                        <label for="ratingRange"></label>
                                        <input type="range" min="0" max="10" step="0.1"
                                               value="5" class="PB-range-slider"
                                               id="ratingRange">
                                        <p class="PB-range-slidervalue" id="ratingValue">5.0</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="rentalAvailable">대여 가능 여부</label>
                                    <input type="checkbox" id="rentalAvailable"
                                           name="rentalAvailable" value="Y">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                    data-dismiss="modal">닫기
                            </button>
                            <button type="button" class="btn btn-primary"
                                    id="executeAdvancedSearch">검색
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="totalBook" class="col"
     style="position: absolute; display: flex; justify-content: center; margin-top: 8px; font-size: 22px; color: #0D6EFD;">
</div>
<nav aria-label="Page navigation" class="justify-content-center">
    <ul class="pagination justify-content-center mt-5 mb-5">
    </ul>
</nav>


<div id="list_wrap" class="list_wrap">
</div>
<div id="grid_wrap" class="grid_wrap">
</div>

<nav aria-label="Page navigation">
    <ul class="pagination justify-content-center mt-5 mb-5">
    </ul>
</nav>
</div>
</body>
<jsp:include page="../includes/footer.jsp"/>
<script src="/resources/js/booklist_ajax.js"></script>
<script src="/resources/js/category_ajax.js"></script>
<script src="/resources/js/preference_ajax.js"></script>
<script>
  // 관리자 여부를 JavaScript 변수에 저장 (권한이 1이면 관리자)
  const isAdmin = ${user.authority == 1 ? 'true' : 'false'};
  document.addEventListener('mousedown', function(event) {
    if (event.target.tagName !== 'INPUT' && event.target.tagName !== 'TEXTAREA') {
      event.preventDefault();  // 비인풋 요소가 클릭되면 기본 포커스 방지
    }
  });
</script>
<script type="text/javascript">
  $(document).ready(
      function () {
        // 모달 열기 함수
        function openModal(modalId) {
          const modal = document.getElementById(modalId);
          if (modal) {
            modal.style.display = 'block';
          }
        }
        // 모달 닫기 함수
        function closeModal(modalId) {
          const modal = document.getElementById(modalId);
          if (modal) {
            modal.style.display = 'none';
          }
        }
        // 모달 열기 이벤트 설정
        document.querySelectorAll('[data-toggle="modal"]').forEach(function (button) {
          const targetModalId = button.getAttribute('data-target');
          button.addEventListener('click', function () {
            openModal(targetModalId); // 모달 열기
          });
        });
        // 모달 닫기 이벤트 설정
        document.querySelectorAll('.modal .close').forEach(function (closeButton) {
          const modalId = closeButton.closest('.modal').id;
          closeButton.addEventListener('click', function () {
            closeModal(modalId); // 모달 닫기
          });
        });

        $("#executeAdvancedSearch").on("click", function () {
          // 고급 검색 조건 수집
          var advancedParams = {
            searchType: $('#searchType').val() || null,  // 검색 기준
            searchQuery: $('#keyword').val(),
            publicationDateRange: $('#publicationDateRange').val() || null,  // 출판일 범위
            minRating: $('#ratingRange').val() || null,  // 최소 평점
            maxPrice: $('#maxPrice').val() || null  // 최대 가격
          };
          // loadPage 호출
          loadPage(1, advancedParams);
          $("#advancedSearchModal").modal('hide');  // 모달 닫기
        });
      });

  let isPageMode = false;
  let maxPage = 1;

  function resetPreference() {
    preferencesOutput.innerHTML = '';
  }

  function totalValue() {
    document.getElementById('totalBook').textContent = (`총 ${'${totalBook}'} 권`);
  }

  function toggleFunction() {
    $('#toggleButton').tooltip('hide');

    // 토글 상태 변경
    isPageMode = !isPageMode;
    console.log(isPageMode)

    // 토글 상태에 따라 placeholder 변경
    const searchInput = document.getElementById('searchInput');
    const toggleButton = document.getElementById('toggleButton');
    const toggleButton2 = document.getElementById('toggleButton2');
    searchInput.value = '';
    searchInput.placeholder = isPageMode ? '페이지 입력 1 ~ ' + maxPage + '' : '간편검색';
    toggleButton.setAttribute('title', isPageMode ? '검색모드로 전환합니다.' : '페이지 이동 모드로 전환합니다.');
    toggleButton2.setAttribute('title', !isPageMode ? '검색을 시작합니다.' : '페이지를 이동합니다.');
    toggleButton2.textContent = (!isPageMode ? '검색' : '이동');
    $(toggleButton).tooltip('dispose').tooltip();
    $(toggleButton2).tooltip('dispose').tooltip();

    // 디자인 클래스 적용
    if (isPageMode) {
      searchInput.classList.remove('search-mode');
      searchInput.classList.add('page-mode');
      toggleButton.classList.remove('toggle-search');
      toggleButton.classList.add('toggle-page');
      toggleButton2.classList.remove('toggle-search2');
      toggleButton2.classList.add('toggle-page');
    } else {
      searchInput.classList.remove('page-mode');
      searchInput.classList.add('search-mode');
      toggleButton.classList.remove('toggle-page');
      toggleButton.classList.add('toggle-search');
      toggleButton2.classList.remove('toggle-page');
      toggleButton2.classList.add('toggle-search2');
    }
  }

  function handleFormSubmit(event) {
    event.preventDefault();

    const searchInput = $('#searchInput');
    const query = searchInput.val().trim();

    // 숫자만 입력되었는지 정규식으로 검증
    const isNumeric = /^\d+$/.test(query);
    const pageNumber = parseInt(query, 10);

    if (isPageMode) {
      if (isNumeric && pageNumber >= 1 && pageNumber <= maxPage) {
        loadPage(pageNumber); // AJAX로 페이지 로드
      } else {
        showTooltip(searchInput, `1부터 ${maxPage} 사이의 유효한 숫자를 입력하세요.`);
      }
    } else {
      loadPage(1, undefined, query);
    }
  }

  function showTooltip(element, message) {
    element.tooltip('dispose')
    .attr('title', message)
    .tooltip({trigger: 'manual'})
    .tooltip('show');

    setTimeout(() => {
      element.tooltip('hide');
    }, 3000);
  }

  $(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip()
  });

</script>
<script>
  const module = {
    clickButtonTop: function (selectors) {
      const toTop = document.querySelector(selectors);

      if (toTop) {
        toTop.addEventListener('click', () => {
          backToTop(); // 부드러운 스크롤 함수 호출
        });
      }
    },

    ScrollTopButtonView: function () {
      // 페이지가 완전히 로드된 후 실행
      window.addEventListener('load', () => {
        const topButton = document.querySelector('.back_to_top');
        let y = window.scrollY;

        // 초기 상태 설정: 스크롤 위치에 따라 TOP 버튼 표시 여부 결정
        if (y >= 400) {
          module.addClass('.back_to_top', 'on');
        } else {
          module.removeClass('.back_to_top', 'on');
        }

        // 스크롤 이벤트 리스너 추가
        window.addEventListener('scroll', () => {
          y = window.scrollY;
          if (y >= 400) {
            module.addClass('.back_to_top', 'on');
          } else {
            module.removeClass('.back_to_top', 'on');
          }
        });

        // 버튼의 클릭 이벤트 설정
        this.clickButtonTop('.back_to_top');
      });
    },

    addClass: function (selectors, className) {
      let element = document.querySelector(selectors);

      if (element) {
        element.classList.add(className);
      }
    },

    removeClass: function (selectors, className) {
      let element = document.querySelector(selectors);

      if (element) {
        element.classList.remove(className);
      }
    }
  };

  // 부드러운 스크롤 함수 정의
  function backToTop() {
    const position = document.documentElement.scrollTop || document.body.scrollTop;
    if (position > 1) {
      window.requestAnimationFrame(() => {
        window.scrollTo(0, position - position / 5); // 점진적으로 스크롤 이동
        backToTop(); // 재귀 호출
      });
    }
  }

  // DOM이 준비된 후에 스크립트 실행
  document.addEventListener('DOMContentLoaded', function () {
    module.ScrollTopButtonView();
  });

</script>
<script>
  $(document).ready(function () {
    let debounceTimeout; // 디바운스 딜레이를 위한 변수
    $('#searchInput').on('input', function () {
      const query = $(this).val().trim();
      // 이전에 설정된 타이머가 있다면 취소
      clearTimeout(debounceTimeout);

      if (query.length > 0) {
        // 디바운스 : 입력이 멈추고나서 일정 시간 대기 후 요청 실행
        debounceTimeout = setTimeout(function () {
          $.ajax({
            url: '/ajax/searchTitles',
            type: 'GET',
            data: {query: query, categoryId: currentCategoryId}, // 검색어와 현재 카테고리 정보를 서버로 전달
            success: function (data) {
              // 제목을 matchDataList 에 저장
              matchDataList = data.map(item => item.book);
              inputArea.onkeyup(); // 자동완성 목록 갱신
            },
            error: function (xhr, status, error) {
              console.error('자동완성 요청 실패:', error);
            }
          });
        }, 150) // 150ms 의 딜레이 적용 (너무 짧지만 없는것보단 낫다)
      } else {
        clearAutocompleteList();  // 검색어가 없으면 자동완성 목록을 비움
      }
    });
  });

  let inputArea = document.getElementById('searchInput');
  let autocompleteList = document.getElementById('autocompleteList');
  let matchDataList = [];  // 자동완성 항목을 저장하는 배열
  let nowIndex = -1;  // 현재 선택된 항목을 추적
  let isNavigating = false; // 키보드 입력 이슈로 인해 넣은 변수 (키가 두번눌린다던가 뭐 그런게 좀 있었음)
  let autoBoxHeight = 0;
  let lastAutoCompleteIndex, autoCompleteElements;
  let autocompleteListClicked = false;
  let originalInputValue = ''; // 사용자가 원래 입력했던 인풋내용을 저장하는 변수

  function clearAutocompleteList() {
    // 기본적으로 자동완성 목록을 완전히 숨기기

    autocompleteList.style.visibility = 'hidden';
  }

  inputArea.onkeyup = function () {
    if (isNavigating) {
      return;
    }

    let q = this.value, autoCompletes = [];

    if (q.length === 0) {
      clearAutocompleteList();
      return;
    }

    autocompleteList.innerHTML = ""; // 기존 목록 초기화

    // 자동완성 목록 생성
    for (let i = 0; i < matchDataList.length; i++) {
      // 입력된 검색어가 자동완성 항목의 어느 부분에 위치하는지 확인
      const index = matchDataList[i].toLowerCase().indexOf(q.toLowerCase());

      if (index !== -1) {
        // 검색어와 일치하는 부분만 <span> 태그로 감싸기
        const highlightedText = matchDataList[i].substring(0, index) +
            "<span class='highlight'>" +
            matchDataList[i].substring(index, index + q.length) +
            "</span>" +
            matchDataList[i].substring(index + q.length);

        autoCompletes.push('<li class="autocompleteli">' + highlightedText + '</li>');
      }
    }

    autocompleteList.innerHTML = '<ul class="autocompleteul">' + autoCompletes.join("") + '<ul>';
    autocompleteList.style.visibility = "visible";
    lastAutoCompleteIndex = autoCompletes.length - 1;
    autoCompleteElements = autocompleteList.childNodes[0].childNodes;
    nowIndex = -1;

    autocompleteListClicked = false;
    autoBoxHeight = autocompleteList.clientHeight;
    autocompleteList.scrollTop = 0
  }

  autocompleteList.onclick = function (e) {
    // 클릭 시 해당 검색어 선택
    if (e.target.nodeName === "LI") {
      inputArea.value = e.target.innerText; // innerHTML하곤 다르게 화면에 출력된 텍스트만 가져옴. (하이라이트 태그까지 나와버려서 이걸로 교체함)
      clearAutocompleteList();
    }
  }

  autocompleteList.onmousedown = function (e) {
    autocompleteListClicked = true;
    e.preventDefault();
    setTimeout(function () {
      autocompleteListClicked = false;
    }, 0);
  }

  inputArea.onblur = function () {
    if (!autocompleteListClicked) {
      autocompleteList.style.visibility = "hidden";
    }
  }
  // 자동완성 목록의 스크롤을 현재 인덱스 위치와 동기화시키는 함수
  function synchroniseautocompleteList() {
    var sOffsetTop = autoCompleteElements[nowIndex].offsetTop,
        sHeight = autoCompleteElements[nowIndex].clientHeight;

    if ((sOffsetTop + sHeight - autocompleteList.scrollTop) > autoBoxHeight) {
      autocompleteList.scrollTop = sOffsetTop + sHeight - autoBoxHeight
    } else if (autocompleteList.scrollTop > sOffsetTop) {
      autocompleteList.scrollTop = sOffsetTop
    }
  }

  inputArea.onkeydown = function (e) {

    // 목록이 비활성화된 상태이고, 항목이 존재할 때만 목록을 다시 활성화
    if (autocompleteList.style.visibility !== 'visible' && autocompleteList.classList.length > 0) {
      if (e.keyCode === 40 || e.keyCode === 38) { // Down(40) / Up(38) Arrow keys
        autocompleteList.style.visibility = 'visible';  // 목록을 다시 표시
        e.preventDefault(); // 기본 동작 방지
        return; // 위나 아래 누르자마자 목록 선택되는거 방지
      }
    }

    // 목록이 비활성화된 상태라면 방향키 목록탐색을 허용하지 않음 (위의 조건을 만족하지 않을 경우)
    if (autocompleteList.style.visibility !== 'visible') {
      return;
    }
    isNavigating = false;

    if (e.keyCode === 40) { // 아래 방향키
      isNavigating = true;
      if (nowIndex === -1) {
        originalInputValue = inputArea.value; // 현재 인풋값을 저장
        autoCompleteElements[++nowIndex].classList.add("hl");
        inputArea.value = matchDataList[nowIndex]; // 현재 인덱스의 자동완성 항목을 안풋창에 반영
      } else if (nowIndex === lastAutoCompleteIndex) {
        autoCompleteElements[nowIndex].classList.remove("hl");
        nowIndex = -1;
        inputArea.value = originalInputValue; // 마지막 항목에서 빠져나오면 원래대로 복귀
      } else {
        autoCompleteElements[nowIndex].classList.remove("hl");
        autoCompleteElements[++nowIndex].classList.add("hl");
        inputArea.value = matchDataList[nowIndex];
      }
      if (nowIndex !== -1) synchroniseautocompleteList();
    } else if (e.keyCode === 38) { // 위 방향키
      isNavigating = true;
      if (nowIndex === -1) {
        originalInputValue = inputArea.value;
        nowIndex = lastAutoCompleteIndex;
        autoCompleteElements[nowIndex].classList.add("hl");
        inputArea.value = matchDataList[nowIndex];
      } else if (nowIndex === 0) {
        autoCompleteElements[nowIndex].classList.remove("hl");
        nowIndex = -1;
        inputArea.value = originalInputValue; // 첫항목에서 벗어나면....
      } else {
        autoCompleteElements[nowIndex].classList.remove("hl");
        autoCompleteElements[--nowIndex].classList.add("hl");
        inputArea.value = matchDataList[nowIndex];
      }
      if (nowIndex !== -1) synchroniseautocompleteList();
    } else if (e.keyCode === 13) { // 엔터키
      isNavigating = true;
      if (nowIndex !== -1) {
        inputArea.value = matchDataList[nowIndex];
        clearAutocompleteList();
      } else if (nowIndex === -1) {
        // 자동완성 목록에 포커싱하지 않고 엔터를 쳤을경우에도 자동완성 목록을 닫음
        clearAutocompleteList();
      }
    } else if (e.keyCode === 27) { // esc
      isNavigating = true;
      clearAutocompleteList();
    } else if (e.keyCode === 37 || e.keyCode === 39) { // 좌 우 방향키
      if (nowIndex !== -1) { // 자동완성 목록에 포커싱중일경우 작동
        inputArea.value = originalInputValue; // 원래대로 되돌림
      }
    }
  }
</script>
</html>