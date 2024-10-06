<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<style>
  /* 전체 페이지의 캐럿을 투명하게 설정 */
  body, * {
    caret-color: transparent; /* 기본적으로 모든 요소에서 캐럿 숨김 */
  }

  /* 입력 영역에는 캐럿을 표시 */
  input, textarea, [contenteditable=true] {
    caret-color: auto; /* 인풋 요소에서는 기본 캐럿 표시 */
  }

  .bookDetail *{
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
.breadcrumb-btn {
  background: none;
  border: none;
  color: #0D6EFD;
  cursor: pointer;
  text-decoration: underline;
}
.breadcrumb-btn:hover {
  text-decoration: none;
}
.img-thumbnail{
  max-height: 50vh;
}
.bold{
  font-weight: bold;
}
.bookinfo *{
  color: #000;
}
.card-img-top{
  max-width: 400px;
  border:2px solid #a1a1a1;
}
.rating-bar {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.star-label {
  width: 60px; /* 별점 텍스트의 너비 설정 */
  margin-right: 10%; /* 게이지 바와의 간격 설정 */
  font-size: 18px; /* 별 크기 */
}

.barGraphBase {
  position: relative;
  width: 70%;
  height: 20px;
  background-color: #e0e0e0; /* 바탕 게이지 색상 */
}

.barGraph {
  display: block;
  height: 100%;
  background-color: #67a3ff; /* 채워지는 게이지 색상 */
  border-radius: 5px 0 0 5px; /* 둥근 테두리 */
}

.barTxt {
  position: absolute;
  right: 10px;
  top: 0;
  color: white;
  font-size: 14px;
  line-height: 20px; /* 게이지 높이에 맞게 중앙 정렬 */
}
.rating-container{
  position: relative;
  padding: 31px;
  border: solid 1px #ebebeb;
  background-color: #f8f8f8;
  display: flex;
  justify-content: center;
}
.rating-box{
  width: 318px;
  border: solid 1px #ebebeb;
  background-color: #fff;
  margin-right: 10%;
}

</style>
<head>
    <title>도서 상세정보</title>
    <meta charset="utf-8">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/resources/styles/courses_styles.css">
    <link rel="stylesheet" type="text/css" href="/resources/styles/courses_responsive.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css"
          rel="stylesheet">
    <jsp:include page="../includes/header.jsp"/>
</head>


<body>
<div class="home2">
    <div class="home_background_container prlx_parent">
        <div class="home_background prlx2"
             style="background-image:url(/resources/images/courses_background.jpg)"></div>
    </div>
    <div class="home_content">
        <h1>상세보기</h1>
    </div>
</div>

<!-- Product section-->
<section class="bookinfo">
    <div class="container px-4 px-lg-5 my-5">
        <div class="row gx-4 gx-lg-5 align-items-center">
            <div class="col-md-6">
                <c:choose>
                    <c:when test="${empty bookDetail.photo}">
                        <img class="card-img-top mb-5 mb-md-0" src="" alt="${bookDetail.book}">
                    </c:when>
                    <c:when test="${bookDetail.photo.startsWith('http')}">
                        <img class="card-img-top mb-5 mb-md-0" src="${bookDetail.photo}" alt="${bookDetail.book}">
                    </c:when>
                    <c:otherwise>
                        <img class="card-img-top mb-5 mb-md-0" src="/library/books/${bookDetail.photo}" alt="${bookDetail.book}">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-md-6">
                <div class="small mb-1"><c:out value="${bookDetail.publisher}"/></div>
                <h1 class="display-5 fw-bolder">${bookDetail.book}</h1>
                <div class="fs-5 mb-5 mt-3">
                    <span class="text-decoration-line-through"><c:out value="${bookDetail.author}"/></span>
                </div>
                <p id="container"> <c:out value="${bookDetail.bookDescription}"/></p>
                <div class="d-flex">
                    <button id="btn" class="btn btn-outline-dark flex-shrink-0" type="button">
                        더보기
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="bookinfo py-5">
    <div class="container px-4 px-lg-5 my-5"style="display: flex; justify-content: center">
        <div class="row gx-4 gx-lg-5 align-items-center" >
                    <div class="col-md-12">
                        <dl>
                            <dt>
                                출판일
                            </dt>
                            <dd>
                                <c:out value="${bookDetail.publicationDate}"/>
                            </dd>
                        </dl>
                        <dl>
                            <dd>
                                <span class="bold">페이지 수 : </span><c:out value="${bookDetail.pageCount}"/><br>
                                <span class="bold">무게 : </span><c:out value="${bookDetail.weight}"/><br>
                                <span class="bold">크기 : </span><c:out value="${bookDetail.bookSize}"/>
                            </dd>
                            <dt>
                                대여 및 구매 여부 : <span id="available"></span>
                            </dt>
                        </dl>
                    </div>
                <div class="row">
                    <div class="col-md-4">
                        <button type="button" class="btn btn-warning" id="reservation" data-isbn="${bookDetail.isbn13}" onclick="window.location.href='/library/reservation/RsCreate'">
                            예약하기
                        </button>
                    </div>
                    <div class="col-md-4">
                        <button type="button" class="btn btn-info">
                            구매신청
                        </button>
                    </div>
                    <div class="col-md-4">
                        <button type="button" class="btn btn-primary" onclick='backtolist()'>
                            뒤로가기
                        </button>
                    </div>
                </div>
        </div>
    </div>
    <div class="rating-container">
        <div class="rating-box">
    <div class="rating-bar">
        <span class="star-label">★★★★★</span>
        <span class="barGraphBase">
    <span class="barGraph innerTxt rating-5" style="width: ${bookDetail.star5Count}">
      <em class="barTxt">${bookDetail.star5Count}</em>
    </span>
  </span>
    </div>
    <div class="rating-bar">
        <span class="star-label">★★★★☆</span>
        <span class="barGraphBase">
    <span class="barGraph innerTxt rating-4" style="width: ${bookDetail.star4Count}">
      <em class="barTxt">${bookDetail.star4Count}</em>
    </span>
  </span>
    </div>

    <div class="rating-bar">
        <span class="star-label">★★★☆☆</span>
        <span class="barGraphBase">
    <span class="barGraph innerTxt rating-3" style="width: ${bookDetail.star3Count}">
      <em class="barTxt">${bookDetail.star3Count}</em>
    </span>
  </span>
    </div>

    <div class="rating-bar">
        <span class="star-label">★★☆☆☆</span>
        <span class="barGraphBase">
    <span class="barGraph innerTxt rating-2" style="width: ${bookDetail.star2Count}">
      <em class="barTxt">${bookDetail.star2Count}</em>
    </span>
  </span>
    </div>

    <div class="rating-bar">
        <span class="star-label">★☆☆☆☆</span>
        <span class="barGraphBase">
    <span class="barGraph innerTxt rating-1" style="width: ${bookDetail.star1Count}">
      <em class="barTxt">${bookDetail.star1Count}</em>
    </span>
  </span>
    </div>
    </div>
    </div>

</section>


<div id="bookDetail" data-isbn13="${bookDetail.isbn13}">


    <div style="margin-top: 5%">

        <div class="row">


    <p>isbn13 : <c:out value="${bookDetail.isbn13}"/></p>

    <p>Average Rating: <fmt:formatNumber value="${bookDetail.averageRating}" minFractionDigits="1"/></p>

    <p>Review Count: <c:out value="${bookDetail.reviewCount}"/></p>
    
    <p>사진 제목 : <c:out value="${bookDetail.photo}"/></p>


</div>
</div>
    <div class="breadcrumb_container">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
        </ol>
    </nav>
    </div>
</div>
</body>
<jsp:include page="../includes/footer.jsp"/>
<script>

  // 뒤로 가기 버튼 함수
  function backtolist() {
    history.go(-2);
  }

  // 카테고리 ID를 변환하여 구조를 만드는 함수
  function transformCategoryId(categoryId) {
    const result = [];
    let currentId = categoryId;

    // 자릿수가 7이 남을 때까지 반복
    while (currentId.length > 7) {
      result.unshift(currentId); // 현재 ID를 결과 리스트 앞에 추가
      currentId = currentId.slice(0, -3); // 끝에서 3자리 잘라내기
    }

    result.unshift(currentId); // 마지막 남은 7자리 ID 추가
    return result;
  }

  // 브레드크럼 생성 함수
  function createBreadcrumb(categoryIds) {
    const categoryData = getCategoryDataFromSessionStorage(); // 세션 저장소에서 카테고리 데이터 불러오기

    if (!categoryData) {
      console.error('세션 저장소에서 카테고리 데이터를 찾을 수 없습니다.');
      return;
    }

    let breadcrumbHtml = '';
    categoryIds.forEach(categoryId => {
      // 카테고리 ID를 분해하여 상위 카테고리 ID 배열을 가져옴
      const transformedIds = transformCategoryId(categoryId);

      breadcrumbHtml += '<ol class="breadcrumb">'; // 새로운 <ol> 태그 열기

      transformedIds.forEach((id, index) => {
        const categoryName = categoryData.find(cat => cat.categoryId === id)?.categoryName || id;

        // 현재 브레드크럼을 눌렀을때 URL에 적용하는것까진 성공했으나, 이 상태로 비동기방식 리스트 로드를 어떻게 호출할지 고민중
        // 일단 리스트가 전부 비동기방식이기 때문에 window.onload를 활용해볼까함
        breadcrumbHtml += '<li class="breadcrumb-item">' +
            '<a href="/library/booklist/?category=' + id + '">' + categoryName + '</a>' +
            '</li>';
      });
      breadcrumbHtml += '</ol>'; // 하나의 경로가 끝날 때마다 <ol> 닫기
  });
    $('.breadcrumb_container').html(breadcrumbHtml); // 브레드크럼에 동적으로 생성된 HTML 추가
  }

  $(document).ready(function() {
    const isbn13 = $('#bookDetail').data('isbn13'); // 책의 isbn13 가져오기

    // AJAX로 카테고리 ID 요청
    $.ajax({
      url: '/ajax/getBookCategoryIds', // REST 컨트롤러 url
      type: 'GET',
      data: { isbn13: isbn13 },
      dataType: 'json',
      success: function(categoryIds) {
        createBreadcrumb(categoryIds); // 성공 시 브레드크럼 생성 함수 호출
      },
      error: function(xhr, status, error) {
        console.error('카테고리 ID를 가져오는데 실패했습니다:', error);
      }
    });
    isable = '${bookDetail.rentalAvailable}';
    console.log('${bookDetail.rentalAvailable}');
    if (isable === 'Y'){
      $("#available").html('<span id="available" style="color: blue">가능</span>');
    } else {
      $("#available").html('<span id="available" style="color: red">불가능</span>');
    }
  });
</script>
<script>
  var container = document.getElementById("container")
  var btn = document.getElementById("btn")
  var full = container.textContent
  var less = (container.textContent = full.substring(0,300) + "...")
  var isfull = '더보기';


  btn.addEventListener('click',function(){
    isfull === '더보기' ? (container.textContent = full) : (container.textContent = less);
    isfull = document.getElementById("btn").innerHTML = (isfull === '더보기') ? '숨기기' : '더보기';
  })
</script>

<script src="/resources/js/category_ajax.js"></script>
</html>