<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>
.bookDetail *{
  font-family: "Noto Sans KR", sans-serif;
  font-optical-sizing: auto;
  font-size: 1rem;
  font-weight: 500; /* 일반 글씨 */
  font-style: normal;
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


</style>
<head>
    <title>책 상세정보</title>
    <meta charset="utf-8">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <jsp:include page="../includes/header.jsp"/>
</head>
<body class="bookDetail">
<div id="bookDetail" data-isbn13="${bookDetail.isbn13}">

        <div class="home2">
            <div class="home_background_container prlx_parent">
                <div class="home_background prlx2"
                     style="background-image:url(/resources/images/courses_background.jpg)"></div>
            </div>
            <div class="home_content">
                <h1>도서목록</h1>
            </div>
        </div>
    <div style="margin-top: 5%">
        <button onclick='backtolist()'>뒤로가기</button>


    <h1><c:out value="${bookDetail.book}"/></h1>
    <p>isbn13 : <c:out value="${bookDetail.isbn13}"/></p>
    <p>photo: <c:out value="${bookDetail.photo}"/></p>
    <p>Author: <c:out value="${bookDetail.author}"/></p>
    <p>Publisher: <c:out value="${bookDetail.publisher}"/></p>
    <p>Publication Date: <c:out value="${bookDetail.publicationDate}"/></p>
    <p>Description: <c:out value="${bookDetail.bookDescription}"/></p>
    <p>Page Count: <c:out value="${bookDetail.pageCount}"/></p>
    <p>Weight: <c:out value="${bookDetail.weight}"/></p>
    <p>Size: <c:out value="${bookDetail.bookSize}"/></p>
    <p>Average Rating: <fmt:formatNumber value="${bookDetail.averageRating}" minFractionDigits="1"/></p>
    <p>Review Count: <c:out value="${bookDetail.reviewCount}"/></p>
    <p>rentalAvailable: <c:out value="${bookDetail.rentalAvailable}"/></p>

    <div>
        <p>Star 1: <c:out value="${bookDetail.star1Count}"/></p>
        <p>Star 2: <c:out value="${bookDetail.star2Count}"/></p>
        <p>Star 3: <c:out value="${bookDetail.star3Count}"/></p>
        <p>Star 4: <c:out value="${bookDetail.star4Count}"/></p>
        <p>Star 5: <c:out value="${bookDetail.star5Count}"/></p>
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


<script>
  // 전역에 함수 정의
  function getCategoryDataFromSessionStorage() {
    const data = sessionStorage.getItem('categoryData');
    return data ? JSON.parse(data) : null;
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


        breadcrumbHtml += '<li class="breadcrumb-item">' +
            '<button class="breadcrumb-btn" onclick="changeCategoryAndLoadPage(\'' + id + '\'); return false;">' +
            categoryName +
            '</button>' +
            '</li>';
      });
      breadcrumbHtml += '</ol>'; // 하나의 경로가 끝날 때마다 <ol> 닫기
  });
    $('.breadcrumb_container').html(breadcrumbHtml); // 부트스트랩 브레드크럼 요소에 동적으로 생성된 HTML 추가
  }
  // 뒤로 가기 버튼 함수
  function backtolist() {
    history.back();
  }



  // document ready 내부에 AJAX 호출
  $(document).ready(function() {
    const isbn13 = $('#bookDetail').data('isbn13'); // 책의 isbn13 가져오기

    // AJAX로 카테고리 ID 요청
    $.ajax({
      url: '/ajax/getBookCategoryIds', // REST 컨트롤러의 엔드포인트
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
  });


</script>
<jsp:include page="../includes/footer.jsp"/>
<script src="/resources/js/booklist_ajax.js"></script>
</html>