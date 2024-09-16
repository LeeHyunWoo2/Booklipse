<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 9. 10.
  Time: 오후 3:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>책 상세 정보</title>
</head>
<body>
    <!-- 브레드크럼 표시 부분 -->
    <ul id="breadcrumb"></ul>

    <!-- 책 상세 정보를 표시할 영역 -->
    <div id="category-content"></div>
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

  // 페이지 로딩 시 카테고리 ID를 사용하여 브레드크럼을 로드
  $(document).ready(function () {
    const category = $('#bookDetail').data('category-id'); // 책 상세 데이터에서 카테고리 ID 가져오기
    loadCategoryPath(category);
  });

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



</script>


</html>