<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<style>
    .list_wrap .card {
        background: rgb(255, 255, 255);
        width: 975px;
        height: 219px;
        margin: 0 auto;
    }

    .card:hover {
        background-color: #f3f3f3;
    }

    .card .img-fluid {
        max-height: 215px;
    }

    .form-control {
        color: black;
    }

    .card-body {
        padding: 10px; /* 카드 내부 패딩 조절 */
    }

    .booktitle {
        margin-top: 35px;
        font-size: 22px; /* 제목 폰트 크기 조절 */
        font-weight: bold; /* 폰트 굵게 설정 */
        color: #4f4f4f; /* 검정색 */
        margin-bottom: 22px; /* 아래쪽 여백 */
    }

    .card-sub-text {
        font-size: 12px;
        font-weight: 500;
        color: #626262;
        margin-top: -12px;
    }

    .home2 {
        width: 100%;
        height: 50vh;

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
        width: 70%; /* 모달 창 크기 */
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
    }

    .page-mode {
        border: 2px solid #dc3545 !important; /* 점선 테두리 */
        border-radius: 5px !important; /* 모서리 더 둥글게 */
        background-color: #fff !important; /* 연한 회색 배경 */
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


    .list-container {
        min-height: 100vh;
    }
    .grid-view {
      display: grid;
      grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개 */
      gap: 16px; /* 카드 간의 간격 */
    }

    .grid-view .card {
      width: 100%; /* 카드의 너비를 그리드 셀에 맞게 조정 */
      height: auto; /* 카드 높이 자동 조정 */
      margin-bottom: 20px; /* 카드 하단 간격 */
    }

    .card-deck .card {
      margin-bottom: 1.5rem; /* 카드 하단 여백 */
    }

    /* From Uiverse.io by vinodjangid07 */
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


    .bi{
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
      background-color: rgb(129, 110, 216);
      border-radius: 10px;
      cursor: pointer;
      border: none;
      box-shadow: 0px 0px 0px 2px rgb(212, 209, 255);
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
      background-color: rgb(126, 117, 255);
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

</style>
<head>
    <title>도서목록</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Course Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/resources/styles/courses_styles.css">
    <link rel="stylesheet" type="text/css" href="/resources/styles/courses_responsive.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" rel="stylesheet">
    <jsp:include page="includes/header.jsp"/>
</head>
<body>

<div class="super_container">
    <!-- Menu -->
    <div class="menu_container menu_mm">

        <!-- Menu Close Button -->
        <div class="menu_close_container">
            <div class="menu_close"></div>
        </div>

        <!-- Menu Items -->

    </div>

    <!-- Home -->

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


    <div class="position-static" style="z-index: 1030;">
        <nav class="navbar navbar-light bg-light">
            <%--<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggle"
                    aria-controls="navbarToggle" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>--%>
            <button class="setting-btn" type="button" data-toggle="collapse" data-target="#navbarToggle"
                    aria-controls="navbarToggle" style="outline: none;" aria-expanded="false" aria-label="Toggle navigation">
                <span class="bar bar1"></span>
                <span class="bar bar2"></span>
                <span class="bar bar1"></span>
            </button>
            <form class="form-inline mt-1 mb-1" onsubmit="handleFormSubmit(event)">
                <button id="toggleButton" type="button" class="btn btn-outline-danger mr-2 my-sm-2 toggle-mode"
                        onclick="toggleFunction()"
                        data-toggle="tooltip" data-placement="top" title="검색모드로 전환합니다.">페이지 이동
                </button>

                <input id="searchInput" class="form-control search-mode mr-sm-2" type="search" placeholder="제목 간편검색"
                       aria-label="Search" required>

                <button id="toggleButton2" class="btn btn-outline-success my-2 my-sm-0 toggle-mode" type="submit"
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

            <button id="sortButton" class="btn btn-info" onclick="toggleSortOrder()" style="min-width: 90px; margin-bottom: 5%;">최신순
            </button>
                </div>
        </nav>
        <div class="collapse navbar-collapse" id="navbarToggle">
            <div class="bg-light p-5" style="min-height: 300px">
                <div class="btn-group" role="group">
                    <button id="dropdownMenuButton" type="button" class="btn btn-secondary dropdown-toggle"
                            data-toggle="dropdown" aria-expanded="false">
                        카테고리
                    </button>
                    <ul id="categoryDropdownContainer" class="dropdown-menu">
                    </ul>
                    <div id="subMenuWrapper">
                    </div>
                </div>
                <button id="resetButton" type="button" class="btn btn-danger">초기화</button>
                <!-- 고급 검색 버튼 -->
                <button class="btn btn-primary" data-toggle="modal" data-target="#modal1">고급 검색</button>
                <div class="btn-group">
                    <!-- 드롭다운 버튼 -->
                    <button type="button" class="btn btn-info dropdown-toggle" id="itemsPerPageButton" data-toggle="dropdown" aria-expanded="false">
                        10개씩 보기 <!-- 기본 선택 항목을 "10개씩 보기"로 설정 -->
                    </button>
                    <!-- 드롭다운 메뉴 -->
                    <ul class="dropdown-menu" id="itemsPerPageMenu">
                        <li class="dropdown-item" style="cursor: pointer;" onclick="changeItemsPerPage(10)">10개씩 보기</li>
                        <li class="dropdown-item" style="cursor: pointer;" onclick="changeItemsPerPage(20)">20개씩 보기</li>
                        <li class="dropdown-item" style="cursor: pointer;" onclick="changeItemsPerPage(50)">50개씩 보기</li>
                    </ul>
                </div>

                <!-- 모달 창 -->
                <div class="modal fade" id="modal1" tabindex="-1" role="dialog" aria-labelledby="advancedSearchLabel"
                     aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="advancedSearchLabel">고급 검색</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="advancedSearchForm">
                                    <!-- 검색어 입력 -->
                                    <div class="form-group">
                                        <label for="keyword">검색어</label>
                                        <input type="text" class="form-control" id="keyword" name="keyword">
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
                                        <label for="minPrice">최소 가격</label>
                                        <input type="text" class="form-control" id="minPrice" name="minPrice"
                                               placeholder="최소 가격">
                                    </div>
                                    <div class="form-group">
                                        <label for="maxPrice">최대 가격</label>
                                        <input type="text" class="form-control" id="maxPrice" name="maxPrice"
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
                                        <div>
                                            <label><input type="radio" name="minRating" value="1"> 1</label>
                                            <label><input type="radio" name="minRating" value="2"> 2</label>
                                            <label><input type="radio" name="minRating" value="3"> 3</label>
                                            <label><input type="radio" name="minRating" value="4"> 4</label>
                                            <label><input type="radio" name="minRating" value="5"> 5</label>
                                        </div>
                                    </div>
                                    <!-- 대여 가능 여부 -->
                                    <div class="form-group">
                                        <label for="rentalAvailable">대여 가능 여부</label>
                                        <input type="checkbox" id="rentalAvailable" name="rentalAvailable" value="Y">
                                    </div>
                                    <!-- 구매 가능 여부 -->
                                    <div class="form-group">
                                        <label for="purchaseAvailable">구매 가능 여부</label>
                                        <input type="checkbox" id="purchaseAvailable" name="purchaseAvailable"
                                               value="Y">
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                <button type="button" class="btn btn-primary" id="executeAdvancedSearch">검색</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-5 mb-5">
        </ul>
    </nav>

    <div class="list-container">
        <div id="list_wrap" class="list_wrap">
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(
            function () {

                document.addEventListener('DOMContentLoaded', function () {
                    // 공통적인 모달 열기 핸들러
                    document.querySelectorAll('[data-toggle="modal"]').forEach(function (button) {
                        button.addEventListener('click', function () {
                            const targetModalId = this.getAttribute('data-target');
                            document.querySelector(targetModalId).style.display = 'block'; // 모달 표시
                        });
                    });

                    // 공통적인 모달 닫기 핸들러
                    document.querySelectorAll('.modal .close').forEach(function (closeButton) {
                        closeButton.addEventListener('click', function () {
                            this.closest('.modal').style.display = 'none'; // 모달 숨기기
                        });
                    });

                });


                // 고급 검색 실행
                $("#executeAdvancedSearch").on("click", function () {
                    var formData = $("#advancedSearchForm").serialize(); // 폼 데이터 직렬화

                    $.ajax({
                        url: '/ajax/booklist', // 서버의 고급 검색 엔드포인트
                        type: 'GET',
                        data: formData,
                        success: function (data) {
                            renderBookList(data.list); // 검색 결과를 화면에 표시
                            renderPaging(data); // 페이지네이션 렌더링
                            $("#advancedSearchModal").modal('hide'); // 검색 후 모달 창 닫기
                        },
                        error: function (xhr, status, error) {
                            alert('검색 결과를 가져올 수 없습니다: ' + error);
                        }
                    });
                });
            });

        let isPageMode = false;
        let maxPage = 1;

        function toggleFunction () {
            $('#toggleButton').tooltip('hide');

            // 토글 상태 변경
            isPageMode = !isPageMode;

            // 토글 상태에 따라 placeholder 변경
            const searchInput = document.getElementById('searchInput');
            const toggleButton = document.getElementById('toggleButton');
            const toggleButton2 = document.getElementById('toggleButton2');
            searchInput.value = '';
            searchInput.placeholder = isPageMode ? '페이지 입력 1 ~ ' + maxPage + '' : '제목 간편검색';
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

        function handleFormSubmit (event) {
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
                const searchQuery = query;
                loadPage(1, undefined, searchQuery);
            }
        }


        function showTooltip (element, message) {
            element.tooltip('dispose')
                .attr('title', message)
                .tooltip({trigger: 'manual'})
                .tooltip('show');

            setTimeout(() => {
                element.tooltip('hide');
            }, 3000);
        }

        function titleSearchHandler (event) {
            event.preventDefault(); // 폼 기본 제출 방지
            const searchQuery = document.getElementById('searchInput').value.trim();
            loadPage(1, undefined, searchQuery);
        }

        function changeButtonText (element) {
            document.getElementById('dropdownMenuButton').textContent = element.textContent;
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
        function backToTop () {
            const position = document.documentElement.scrollTop || document.body.scrollTop;
            if (position) {
                window.requestAnimationFrame(() => {
                    window.scrollTo(0, position - position / 10); // 점진적으로 스크롤 이동
                    backToTop(); // 재귀 호출
                });
            }
        }

        // DOM이 준비된 후에 스크립트 실행
        document.addEventListener('DOMContentLoaded', function () {
            module.ScrollTopButtonView();
        });
    </script>


    <jsp:include page="includes/footer.jsp"/>
    <script src="/resources/js/booklist_ajax.js"></script>
    <script src="/resources/js/category_ajax.js"></script>

</div>
</body>
</html>
