<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>책 상세정보</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Course Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
    <!-- 브레드크럼 표시 부분 -->
    <ul id="breadcrumb"></ul>

    <!-- 책 상세 정보를 표시할 영역 -->
    <div id="category-content"></div>

    <h1><c:out value="${bookDetail.book}" /></h1>
    <p>photo: <c:out value="${bookDetail.photo}"/></p>
    <p>Author: <c:out value="${bookDetail.author}" /></p>
    <p>Publisher: <c:out value="${bookDetail.publisher}" /></p>
    <p>Publication Date: <c:out value="${bookDetail.publicationDateString}" /></p>
    <p>Description: <c:out value="${bookDetail.bookDescription}" /></p>
    <p>Page Count: <c:out value="${bookDetail.pageCount}" /></p>
    <p>Weight: <c:out value="${bookDetail.weight}" /></p>
    <p>Size: <c:out value="${bookDetail.bookSize}" /></p>
    <p>Average Rating: <fmt:formatNumber value="${bookDetail.averageRating}" minFractionDigits="1" /></p>
    <p>Review Count: <c:out value="${bookDetail.review_count}" /></p>
    <p>rentalAvailable: <c:out value="${bookDetail.rentalAvailable}" /></p>

    <div>
        <p>Star 1: <c:out value="${bookDetail.star_1}" /></p>
        <p>Star 2: <c:out value="${bookDetail.star_2}" /></p>
        <p>Star 3: <c:out value="${bookDetail.star_3}" /></p>
        <p>Star 4: <c:out value="${bookDetail.star_4}" /></p>
        <p>Star 5: <c:out value="${bookDetail.star_5}" /></p>
    </div>
</body>
<script>

  // 브레드크럼을 렌더링하는 함수
  function renderBreadcrumb(categoryPath) {
    const breadcrumbContainer = document.getElementById('breadcrumb');
    breadcrumbContainer.innerHTML = ''; // 기존 브레드크럼 초기화

    if (!categoryPath || categoryPath.length === 0) {
      return; // 카테고리 경로가 없으면 렌더링하지 않음
    }

    // 각 카테고리 경로를 반복하여 브레드크럼을 생성
    categoryPath.forEach((category, index) => {
      const breadcrumbItem = document.createElement('li');
      breadcrumbItem.className = 'breadcrumb-item';

      const link = document.createElement('a');
      link.href = '#'; // URL을 변경하지 않기 위해 "#"로 설정
      link.textContent = category.category_name;

      // 링크 클릭 시 동작을 정의
      link.onclick = function() {
        // 클릭한 카테고리로 이동하는 작업
        navigateToCategory(category.category);
      };

      breadcrumbItem.appendChild(link);
      breadcrumbContainer.appendChild(breadcrumbItem);
    });
  }

  // 페이지 로딩 시 카테고리 ID를 사용하여 브레드크럼을 로드
  $(document).ready(function () {
    const category = $('#bookDetail').data('category-id'); // 책 상세 데이터에서 카테고리 ID 가져오기
    loadCategoryPath(category);
  });


/*
  // 카테고리 이동 함수
  function navigateToCategory(category) {
    // AJAX 요청을 통해 카테고리에 해당하는 데이터를 불러옵니다.
    $.ajax({
      url: '/categories/path', // 실제 서버 API 엔드포인트
      type: 'GET',
      data: { category: category },
      success: function (data) {
        // 데이터를 받아서 새로운 페이지 내용을 동적으로 갱신합니다.
        updatePageContent(data);
      },
      error: function (xhr, status, error) {
        console.error('카테고리 정보를 불러오는 중 오류 발생:', error);
      }
    });
  }

  // 페이지 콘텐츠 갱신 함수
  function updatePageContent(categoryData) {
    // 불러온 데이터를 이용하여 페이지 내용을 동적으로 갱신하는 작업을 수행합니다.
    console.log('새로운 카테고리 데이터:', categoryData);

    // 예: 특정 DOM 요소에 카테고리 관련 내용을 업데이트
    const categoryContent = document.getElementById('category-content');
    categoryContent.innerHTML = ''; // 기존 내용 초기화

    categoryData.forEach(category => {
      const categoryElement = document.createElement('div');
      categoryElement.textContent = `카테고리: ${category.category_name}`;
      categoryContent.appendChild(categoryElement);
    });
  }

  // 카테고리 경로 로드 함수
  function loadCategoryPath(category) {
    $.ajax({
      url: '/categories/path',
      type: 'GET',
      data: { category: category },
      success: function (categoryPath) {
        renderBreadcrumb(categoryPath);
      },
      error: function (xhr, status, error) {
        console.error('카테고리 경로를 불러오는 중 오류 발생:', error);
      }
    });
  }
*/

</script>

</html>