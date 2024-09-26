<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<style>
  .bookManagement * {
    font-family: "Noto Sans KR", sans-serif;
    font-optical-sizing: auto;
    font-size: 1rem;
    font-weight: 500; /* 일반 글씨 */
    font-style: normal;
    color: #000;
  }

  .home2 {
    width: 100%;
    height: 50vh;
  }

  .supercon {
    padding: 200px;
  }

  .manage {
    margin-bottom: 1vh;
  }

  .bookform {
    background-color: #fff;
    border: 1px solid rgb(159, 159, 160);
    border-radius: 20px;
    padding: 2rem .7rem .7rem .7rem;
    text-align: center;
    font-size: 1.125rem;
    max-width: 320px;
    max-height: 323px;
    margin-bottom: 130px;
  }

  .bookform-title {
    color: #000000;
    font-size: 1.8rem;
    font-weight: 500;
  }

  .bookform-paragraph {
    margin-top: 10px;
    font-size: 0.9375rem;
    color: rgb(105, 105, 105);
  }

  .bookdrop-container {
    background-color: #fff;
    position: relative;
    display: flex;
    gap: 10px;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 10px;
    margin-top: 2.1875rem;
    border-radius: 10px;
    border: 2px dashed rgb(171, 202, 255);
    color: #444;
    cursor: pointer;
    transition: background .2s ease-in-out, border .2s ease-in-out;
  }

  .bookdrop-container:hover {
    background: rgba(0, 140, 255, 0.164);
    border-color: rgba(17, 17, 17, 0.616);
  }

  .bookdrop-container:hover .bookdrop-title {
    color: #222;
  }

  .bookdrop-title {
    color: #444;
    font-size: 20px;
    font-weight: bold;
    text-align: center;
    transition: color .2s ease-in-out;
  }


  #preview img {
    max-width: 600px;
    height: auto;
    border: 2px solid #a1a1a1;
  }

  .toast-container {
    position: fixed;
    bottom: 10px;
    right: 10px;
    z-index: 1000;
    display: flex;
    flex-direction: column-reverse;
  }

  .toast-message {
    background-color: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 10px 20px;
    margin: 10px 0;
    border-radius: 5px;
    display: inline-block;
    opacity: 0;
    transition: opacity 0.5s ease;
  }

  .toast-message.show {
    opacity: 1;
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


</style>
<head>
    <title>도서 관리</title>
    <meta charset="utf-8">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
          rel="stylesheet">
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
        <h1>도서 관리</h1>
    </div>
</div>
<main class="supercon" style="color:#000;">
    <button type="button" class="btn btn-primary" onclick='backtolist()'>
        뒤로가기
    </button>
    <button type="button" id="deleteBookButton" class="btn btn-outline-danger">책 삭제</button>
    <div class="row">
        <form class="needs-validation was-validated" enctype="multipart/form-data">
            <div class="row">
                <div id="preview" style="padding: 20px;"></div>
            </div>

            <div class="tabs mb-2">
                <input type="radio" id="uploadByUrl" name="imageUploadType" value="url" checked="">
                <label class="tab" for="uploadByUrl">URL</label>
                <input type="radio" id="uploadByFile" name="imageUploadType" value="file">
                <label class="tab" for="uploadByFile">File</label>
                <span class="glider"></span>
            </div>
            <div class="col-sm-6">
                <div id="imageUrlInput" style="display: block;">
                    <input type="text" id="photoUrl" name="photoUrl" class="form-control"
                           placeholder="이미지 URL을 입력하세요"
                           value="${mode == 'edit' && bookDetail.photo != null && bookDetail.photo.startsWith('http') ? bookDetail.photo : ''}" required="">
                </div>
                <div id="imageFileInput"
                     style="display:${bookDetail.photo != null && !bookDetail.photo.startsWith('http') ? 'block' : 'none'}">
                    <input type="file" id="fileInput" name="file" class="form-control">
                </div>
            </div>

            <div class="row g-3">
                <div class="col-sm-6">
                    <label for="book" class="form-label">제목</label>
                    <input type="text" name="book" class="form-control" id="book"
                           placeholder=""
                           value="${mode == 'edit' ? bookDetail.book : ''}" required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="manage col-sm-6">
                    <label for="author" class="form-label">작가</label>
                    <input type="text" name="author" class="form-control" id="author" placeholder=""
                           value="${mode == 'edit' ? bookDetail.author : ''}" required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="col-sm-6">
                    <label for="publisher" class="form-label">출판사</label>
                    <input type="text" name="publisher" class="form-control" id="publisher"
                           placeholder=""
                           value="${mode == 'edit' ? bookDetail.publisher : ''}" required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="manage col-sm-6">
                    <label for="publicationDate" class="form-label">발행일</label>
                    <input type="date" name="publicationDate" class="form-control"
                           id="publicationDate" placeholder=""
                           value="${mode == 'edit' ? bookDetail.publicationDate : ''}" required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="manage col-12">
                    <label for="bookDescription" class="form-label">책 소개 <span
                            class="text-body-secondary">(선택)</span></label>
                    <input type="text" class="form-control" name="bookDescription"
                           value="${mode == 'edit' ? bookDetail.bookDescription : ''}"
                           id="bookDescription">
                </div>
                <div class="manage col-12">
                    <label for="categories" class="form-label">카테고리</label>
                    <input type="text" value="${mode == 'edit' ? bookDetail.categories : ''}"
                           class="form-control" id="categories" readonly required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div id="categoryListContainer">
                    <!-- 카테고리 드롭다운 메뉴가 여기에 표시 -->
                </div>
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
                <div id="toastContainer" class="toast-container"></div>
                <button id="addCategoryButton" type="button" style="margin-left: 20px;">카테고리 추가
                </button>
                <div class="reset"
                     style="display: flex; justify-content: flex-end; margin-left: 20px">
                    <button id="resetButton" type="button" class="rebutton" style="outline: none;
                        ">
                        <span class="rebutton__text">메뉴 리셋</span>
                        <span class="rebutton__icon"><svg class="resvg" height="48"
                                                          viewBox="0 0 48 48"
                                                          width="48"
                                                          xmlns="http://www.w3.org/2000/svg"><path
                                d="M35.3 12.7c-2.89-2.9-6.88-4.7-11.3-4.7-8.84 0-15.98 7.16-15.98 16s7.14 16 15.98 16c7.45 0 13.69-5.1 15.46-12h-4.16c-1.65 4.66-6.07 8-11.3 8-6.63 0-12-5.37-12-12s5.37-12 12-12c3.31 0 6.28 1.38 8.45 3.55l-6.45 6.45h14v-14l-4.7 4.7z"></path><path
                                d="M0 0h48v48h-48z" fill="none"></path></svg></span>
                    </button>
                </div>
                <div class="manage col-12 mt-3">
                    <label for="isbn13" class="form-label">ISBN13</label>
                    <input type="text" name="isbn13" class="form-control" id="isbn13"
                           value="${mode == 'edit' ? bookDetail.isbn13 : ''}" placeholder=""
                           required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
            </div>
            <hr class="my-4">
            <h4 class="mb-3">대여 가능 여부</h4>
            <div class="my-3">
                <div class="form-check">
                    <input id="available" name="rentalAvailable" type="radio"
                           class="form-check-input" value="Y" checked="" required="">
                    <label class="rentalAvailable" for="available">가능</label>
                </div>
                <div class="form-check">
                    <input id="notAvailable" name="rentalAvailable" value="N" type="radio"
                           class="form-check-input"
                           required="">
                    <label class="rentalAvailable" for="notAvailable">불가능</label>
                </div>
            </div>
            <div class="row gy-3">
                <div class="col-md-6">
                    <label for="bookPrice" class="form-label">가격</label>
                    <input type="text" name="bookPrice" value="${mode == 'edit' ? bookDetail.price
                    : ''}" class="form-control" id="bookPrice" placeholder="">
                    <div class="invalid-feedback">
                        Name on card is required
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="bookCount" class="form-label">재고수</label>
                    <input type="text" name="bookCount"
                           value="${mode == 'edit' ? bookDetail.bookCount : ''}"
                           class="form-control" id="bookCount" placeholder=""
                           required="">
                    <div class="invalid-feedback">
                        Expiration date required
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="pageCount" class="form-label">쪽수</label>
                    <input type="text" name="pageCount"
                           value="${mode == 'edit' ? bookDetail.pageCount : ''}"
                           class="form-control" id="pageCount" placeholder="">
                </div>
                <div class="col-md-3">
                    <label for="weight" class="form-label">무게</label>
                    <input type="text" name="weight"
                           value="${mode == 'edit' ? bookDetail.weight : ''}"
                           class="form-control" id="weight" placeholder="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="bookSize" class="form-label">크기</label>
                    <input type="text" name="bookSize"
                           value="${mode == 'edit' ? bookDetail.bookSize : ''}"
                           class="form-control" id="bookSize" placeholder="">
                    <div class="invalid-feedback">
                        Security code required
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="averageRating" class="form-label">평점</label>
                    <input type="text" name="averageRating" value="${mode == 'edit' ? bookDetail.averageRating
                     : ''}" class="form-control" id="averageRating" placeholder="">
                    <div class="invalid-feedback">
                        Security code required
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="reviewCount" class="form-label">리뷰수</label>
                    <input type="text" name="reviewCount" value="${mode == 'edit' ? bookDetail.reviewCount :
                     ''}" class="form-control" id="reviewCount" placeholder="">
                    <div class="invalid-feedback">
                        Security code required
                    </div>
                </div>
                <div class="col-md-6 mt-4">
                    <label for="starRating1"></label><input type="number" id="starRating1"
                                                            style="margin-right: 15px"
                                                            value="${mode == 'edit' ? bookDetail.star1Count : ''}"
                                                            name="starRating1" placeholder="별 1개 비율"
                                                            min="0" max="100">
                    <label for="starRating2"></label><input type="number" id="starRating2"
                                                            style="margin-right: 15px"
                                                            value="${mode == 'edit' ? bookDetail.star2Count : ''}"
                                                            name="starRating2" placeholder="별 2개 비율"
                                                            min="0" max="100">
                    <label for="starRating3"></label><input type="number" id="starRating3"
                                                            style="margin-right: 15px"
                                                            value="${mode == 'edit' ? bookDetail.star3Count : ''}"
                                                            name="starRating3" placeholder="별 3개 비율"
                                                            min="0" max="100">
                    <label for="starRating4"></label><input type="number" id="starRating4"
                                                            style="margin-right: 15px"
                                                            value="${mode == 'edit' ? bookDetail.star4Count : ''}"
                                                            name="starRating4" placeholder="별 4개 비율"
                                                            min="0" max="100">
                    <label for="starRating5"></label><input type="number" id="starRating5"
                                                            style="margin-right: 15px"
                                                            value="${mode == 'edit' ? bookDetail.star5Count : ''}"
                                                            name="starRating5" placeholder="별 5개 비율"
                                                            min="0" max="100">
                </div>
            </div>
            <hr class="my-4">
            <button class="w-50 btn btn-primary btn-lg" id="addBookButton" type="submit">저장</button>
        </form>
    </div>
</main>
<script>
  $(document).ready(function () {
    // 책 추가 버튼 클릭 시
    $('#addBookButton').on('click', function (e) {
      e.preventDefault(); // 폼 기본 제출 방지

      var formData = new FormData();
      var bookData = {
        book: $('#book').val(),
        author: $('#author').val(),
        publisher: $('#publisher').val(),
        price: $('#bookPrice').val(),
        isbn13: $('#isbn13').val(),
        bookDescription: $('#bookDescription').val(),
        weight: $('#weight').val(),
        bookSize: $('#bookSize').val(),
        pageCount: $('#pageCount').val(),
        averageRating: $('#averageRating').val(),
        reviewCount: $('#reviewCount').val(),
        publicationDate: $('#publicationDate').val(),
        bookCount: $('#bookCount').val(),
        star5Count: $('#starRating5').val(),
        star4Count: $('#starRating4').val(),
        star3Count: $('#starRating3').val(),
        star2Count: $('#starRating2').val(),
        star1Count: $('#starRating1').val(),
        rentalAvailable: $('input[name="rentalAvailable"]:checked').val(),
        categories: selectedCategories.map(asdf => asdf.categoryId)
      };


      // 업로드 방식 처리 (URL 또는 파일)
      var imageUploadType = $('input[name="imageUploadType"]:checked').val();
      formData.append('imageUploadType', imageUploadType);

      if (imageUploadType === 'url') {
        var photoUrl = $('#photoUrl').val();
        if (photoUrl) {
          formData.append('photoUrl', photoUrl);
        } else {
          alert("URL을 입력하세요");
          return;
        }
      } else if (imageUploadType === 'file') {
        var fileInput = $('#fileInput')[0].files[0];
        if (fileInput) {
          formData.append('file', fileInput);
        } else {
          alert("파일을 선택하세요");
          return;
        }
      }

      formData.append('bookData', JSON.stringify(bookData));

      $.ajax({
        url: '/ajax/book/add',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function (response) {
          alert('책이 성공적으로 추가되었습니다.');
        },
        error: function () {
          alert('책 추가에 실패했습니다.');
        }
      });
    });

    // 책 수정 버튼 클릭 시
    $('#editBookButton').on('click', function (e) {
      e.preventDefault(); // 폼 기본 제출 방지

      var formData = new FormData();
      var bookData = {
        book: $('#book').val(),
        author: $('#author').val(),
        publisher: $('#publisher').val(),
        price: $('#bookPrice').val(),
        isbn13: $('#isbn13').val()
      };
      formData.append('bookData', JSON.stringify(bookData));

      // 업로드 방식 처리
      var imageUploadType = $('input[name="imageUploadType"]:checked').val();
      formData.append('imageUploadType', imageUploadType);

      if (imageUploadType === 'url') {
        var photoUrl = $('#photoUrl').val();
        if (photoUrl) {
          formData.append('photoUrl', photoUrl);
        } else {
          alert("URL을 입력하세요");
          return;
        }
      } else if (imageUploadType === 'file') {
        var fileInput = $('#fileInput')[0].files[0];
        if (fileInput) {
          formData.append('file', fileInput);
        } else {
          alert("파일을 선택하세요");
          return;
        }
      }

      $.ajax({
        url: '/ajax/book/' + bookData.isbn13,
        type: 'PUT',
        data: formData,
        contentType: false,
        processData: false,
        success: function (response) {
          alert('책 정보가 성공적으로 수정되었습니다.');
        },
        error: function () {
          alert('책 정보 수정에 실패했습니다.');
        }
      });
    });

    // 폼 제출 시 기본 동작 방지 및 별점 유효성 검사
    $('#bookForm').on('submit', function (e) {
      e.preventDefault();

      var isValid = this.checkValidity();
      var starRating1 = parseInt($('#starRating1').val()) || 0;
      var starRating2 = parseInt($('#starRating2').val()) || 0;
      var starRating3 = parseInt($('#starRating3').val()) || 0;
      var starRating4 = parseInt($('#starRating4').val()) || 0;
      var starRating5 = parseInt($('#starRating5').val()) || 0;

      var total = starRating1 + starRating2 + starRating3 + starRating4 + starRating5;

      if (isValid && (total === 100 || total === 0)) {
        this.submit();  // 유효성 검사를 통과하면 폼 제출
      } else {
        $('#errorMessage').show();  // 오류 메시지 표시
      }
    });
  });
</script>

<script>
  let selectedCategories = []; // 저장된 카테고리 목록

  // 최하위 카테고리 ID와 이름 저장 변수
  let currentLowestCategoryId = null;
  let currentLowestCategoryName = null;

  // 세션 스토리지에서 카테고리 데이터 가져오기
  function getCategoryDataFromSessionStorage() {
    const data = sessionStorage.getItem('categoryData');
    return data ? JSON.parse(data) : null;
  }

  function onCategorySelected(categoryId) {
    const categoryData = getCategoryDataFromSessionStorage();

    if (categoryData) {
      // 선택한 카테고리 ID에 맞는 카테고리 이름을 찾아서 저장
      const selectedCategory = categoryData.find(category => category.categoryId === categoryId);
      if (selectedCategory) {
        currentLowestCategoryId = selectedCategory.categoryId;
        currentLowestCategoryName = selectedCategory.categoryName;
      } else {
        console.error('해당 카테고리 ID를 찾을 수 없습니다:', categoryId);
      }
    } else {
      console.error('세션에서 카테고리 데이터를 찾을 수 없습니다.');
    }
  }

  // 카테고리 목록을 쉼표로 구분하여 텍스트 필드에 표시하는 함수
  function updateCategoryTextField() {
    document.getElementById('categories').value = selectedCategories.map(
        category => category.categoryName).join(', ');
  }

  // UI에 카테고리 목록을 업데이트하는 함수
  function updateCategoryListUI() {
    const container = document.getElementById('categoryListContainer');
    container.innerHTML = ''; // 기존 목록 초기화

    // 카테고리 목록을 표시
    selectedCategories.forEach((category, index) => {
      const item = document.createElement('div');
      item.textContent = category.categoryName; // 화면에 카테고리 이름 표시

      // 제거 버튼 추가
      const removeButton = document.createElement('button');
      removeButton.textContent = '제거';
      removeButton.addEventListener('click', function () {
        removeCategory(index); // 제거 함수 호출
      });
      item.appendChild(removeButton);
      container.appendChild(item);
    });

    // 텍스트 필드 업데이트
    updateCategoryTextField();
  }

  // 카테고리 목록에서 제거하는 함수
  function removeCategory(index) {
    selectedCategories.splice(index, 1); // 배열에서 해당 카테고리 제거
    updateCategoryListUI(); // UI와 텍스트 필드 업데이트
  }

  // 부모 요소인 categoryDropdownContainer에 이벤트 위임 적용 (1차 카테고리)
  document.getElementById('categoryDropdownContainer').addEventListener('click', function (event) {
    if (event.target && event.target.matches('.dropdown-item div')) {
      const categoryId = event.target.getAttribute('data-category-id');
      const categoryName = event.target.textContent;

      onCategorySelected(categoryId, categoryName);
    }
  });

  // 하위 카테고리 메뉴에도 이벤트 위임 적용 (2차 카테고리 이후)
  document.getElementById('subMenuWrapper').addEventListener('click', function (event) {
    if (event.target && event.target.matches('.dropdown-item div')) {
      const categoryId = event.target.getAttribute('data-category-id');
      const categoryName = event.target.textContent;

      onCategorySelected(categoryId, categoryName);
    }
  });

  // '카테고리 추가' 버튼 클릭 시 호출될 함수
  document.getElementById('addCategoryButton').onclick = function () {
    if (currentLowestCategoryId && currentLowestCategoryName) {

      let shouldAdd = true;

      // 1. 하위 카테고리인지 확인 (목록의 카테고리가 새로 추가하려는 카테고리의 부모인지 확인)
      selectedCategories.forEach(category => {
        const isParentCategory = currentLowestCategoryId.startsWith(category.categoryId); // 하위 카테고리인지 확인
        const isSubCategory = category.categoryId.startsWith(currentLowestCategoryId); // 상위 카테고리인지 확인
        const isExactMatch = currentLowestCategoryId === category.categoryId; // 정확히 일치하는지 확인

        if (isExactMatch) {
          // 카테고리가 정확히 일치하는 경우
          showToast('이미 추가된 카테고리와 동일한 카테고리입니다.');
          shouldAdd = false;
        } else if (isParentCategory) {
          // 하위 카테고리인 경우, 상위 카테고리를 교체
          selectedCategories = selectedCategories.filter(c => c.categoryId !== category.categoryId);
        } else if (isSubCategory) {
          // 상위 카테고리 추가를 막음
          showToast('하위 카테고리가 이미 추가되어 있으므로 상위 카테고리를 추가할 수 없습니다.');
          shouldAdd = false;
        }
      });

      // 카테고리 추가
      if (shouldAdd) {
        selectedCategories.push(
            {categoryId: currentLowestCategoryId, categoryName: currentLowestCategoryName});
      }

      updateCategoryListUI(); // UI와 텍스트 필드 업데이트
    } else {
      showToast('카테고리를 선택해주세요.');
    }
  };

  // 뒤로 가기 버튼 함수
  function backtolist() {
    history.back();
  }
</script>

<script>
  document.getElementById('fileInput').addEventListener('change', function (event) {
    var files = event.target.files;
    if (files && files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        var imgElement = document.createElement('img');
        imgElement.src = e.target.result;
        imgElement.alt = "Uploaded Image";

        var previewContainer = document.getElementById('preview');
        previewContainer.innerHTML = '';  // 기존의 프리뷰를 삭제
        previewContainer.appendChild(imgElement);
      };

      reader.readAsDataURL(files[0]);
    }
  });

  function showInvalidFeedback(elementId) {
    const element = document.getElementById(elementId);
    const feedback = element.querySelector('.invalid-feedback');

    // invalid 클래스 추가하여 오류 메시지 표시
    element.classList.add('is-invalid');
    feedback.style.display = 'block';  // 오류 메시지 보이게 설정
  }

  function hideInvalidFeedback(elementId) {
    const element = document.getElementById(elementId);
    const feedback = element.querySelector('.invalid-feedback');

    // invalid 클래스 제거하여 오류 메시지 숨기기
    element.classList.remove('is-invalid');
    feedback.style.display = 'none';  // 오류 메시지 숨기기
  }

</script>
<script>
  // Toast 메시지를 생성하는 함수
  function showToast(message) {
    const toastContainer = document.getElementById('toastContainer');

    // Toast 메시지 생성
    const toast = document.createElement('div');
    toast.className = 'toast-message';
    toast.textContent = message;

    // Toast를 컨테이너에 추가
    toastContainer.appendChild(toast);

    // 잠시 후에 표시
    setTimeout(() => {
      toast.classList.add('show');
    }, 100);

    // 3초 후에 자동으로 사라지게 설정
    setTimeout(() => {
      toast.classList.remove('show');
      setTimeout(() => {
        toast.remove(); // DOM에서 제거
      }, 500); // 사라지는 애니메이션을 위해 약간의 시간 추가
    }, 3000); // 3초 후에 Toast 닫힘
  }

</script>
<script>
  $(document).on("keyup", "input[name^=starRating]", function () {
    var val = $(this).val();

    if (val.replace(/[0-9]/g, "").length > 0) {
      $(this).val('');
    }

    if (val < 1) {
      $(this).val('0');
    }

    if (val > 100) {
      $(this).val('100');
    }
  });
</script>
<script>
  document.querySelector('.dateaction').addEventListener('click', function (event) {
    event.preventDefault(); // 기본 제출 막기

    let year = document.getElementById('input2').value;
    let month = document.getElementById('input1').value;
    let day = document.getElementById('input3').value;

    if (month.length === 1) {
      month = '0' + month;
    }

    if (day.length === 1) {
      day = '0' + day;
    }

    // 숫자만 입력되었는지 확인
    const yearValid = /^[0-9]{4}$/.test(year); // 4자리 숫자
    const monthValid = /^[0-9]{2}$/.test(month) && parseInt(month, 10) >= 1 && parseInt(month, 10)
        <= 12; // 2자리 숫자, 1~12 사이
    const dayValid = /^[0-9]{2}$/.test(day) && parseInt(day, 10) >= 1 && parseInt(day, 10) <= 31; // 2자리 숫자, 1~31 사이

    // 검증 결과에 따른 처리
    if (!yearValid) {
      // 연도 검증 실패 시 토스트 메시지 출력
      showToast('연도는 4자리 숫자여야 합니다.');
    }

    if (!monthValid) {
      // 월 검증 실패 시 토스트 메시지 출력
      showToast('월은 01~12 사이의 숫자여야 합니다.');
    }

    if (!dayValid) {
      // 일 검증 실패 시 토스트 메시지 출력
      showToast('일은 01~31 사이의 숫자여야 합니다.');
    }

    // 모든 검증을 통과한 경우
    if (yearValid && monthValid && dayValid) {
      showToast('유효한 날짜입니다.');
    }
  });
</script>
<script>
  $(document).ready(function () {
    $('input[name="imageUploadType"]').on('change', function () {
      if ($(this).val() === 'url') {
        $('#photoUrl').prop('required', true);  // URL 필드에 required 적용
        $('#fileInput').prop('required', false);  // 파일 필드에서 required 제거
        $('#imageUrlInput').show();
        $('#imageFileInput').hide();
      } else {
        $('#photoUrl').prop('required', false);  // URL 필드에서 required 제거
        $('#fileInput').prop('required', true);  // 파일 필드에 required 적용
        $('#imageUrlInput').hide();
        $('#imageFileInput').show();
      }
    });
  });
</script>


<jsp:include page="../includes/footer.jsp"/>
<script src="/resources/js/booklist_ajax.js"></script>
<script src="/resources/js/category_ajax.js"></script>
</body>
</html>