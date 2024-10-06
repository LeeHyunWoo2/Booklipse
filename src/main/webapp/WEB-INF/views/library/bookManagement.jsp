<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<style>
  input[readonly], textarea[readonly] {
    caret-color: transparent;
  }

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

  .tabs input[id="uploadByUrl"]:checked ~ .glider {
    transform: translateX(0);  /* 첫 번째 버튼 위치 */
  }

  .tabs input[id="uploadByFile"]:checked ~ .glider {
    transform: translateX(107%);  /* 두 번째 버튼 위치 */
  }


  .glider {
    position: absolute;
    display: flex;
    height: 37px;
    width: 85px;
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


  .deletecard {
    overflow: hidden;
    position: relative;
    background-color: #ffffff;
    text-align: left;
    border-radius: 0.5rem;
    max-width: 290px;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
  }

  .deleteheader {
    padding: 1.25rem 1rem 1rem 1rem;
    background-color: #ffffff;
  }

  .deleteimage {
    display: flex;
    margin-left: auto;
    margin-right: auto;
    background-color: #FEE2E2;
    flex-shrink: 0;
    justify-content: center;
    align-items: center;
    width: 3rem;
    height: 3rem;
    border-radius: 9999px;
  }

  .deleteimage svg {
    color: #DC2626;
    width: 1.5rem;
    height: 1.5rem;
  }

  .deletecontent {
    margin-top: 0.75rem;
    text-align: center;
  }

  .deletetitle {
    color: #111827;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1.5rem;
  }

  .deletemessage {
    margin-top: 0.5rem;
    color: #6B7280;
    font-size: 0.875rem;
    line-height: 1.25rem;
  }

  .deleteactions {
    margin: 0.75rem 1rem;
    background-color: #F9FAFB;
  }

  .desactivate {
    display: inline-flex;
    padding: 0.5rem 1rem;
    background-color: #DC2626;
    color: #ffffff;
    font-size: 1rem;
    line-height: 1.5rem;
    font-weight: 500;
    justify-content: center;
    width: 100%;
    border-radius: 0.375rem;
    border-width: 1px;
    border-color: transparent;
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  }

  .deletecancel {
    display: inline-flex;
    margin-top: 0.75rem;
    padding: 0.5rem 1rem;
    background-color: #ffffff;
    color: #374151;
    font-size: 1rem;
    line-height: 1.5rem;
    font-weight: 500;
    justify-content: center;
    width: 100%;
    border-radius: 0.375rem;
    border: 1px solid #D1D5DB;
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  }

  /* From Uiverse.io by Yaya12085 */
  .addcard {
    overflow: hidden;
    position: relative;
    text-align: left;
    border-radius: 0.5rem;
    max-width: 290px;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    background-color: #fff;
  }

  .addheader {
    padding: 1.25rem 1rem 1rem 1rem;
  }

  .addimage {
    display: flex;
    margin-left: auto;
    margin-right: auto;
    background-color: #e2feee;
    flex-shrink: 0;
    justify-content: center;
    align-items: center;
    width: 3rem;
    height: 3rem;
    border-radius: 9999px;
    animation: animate .6s linear alternate-reverse infinite;
    transition: .6s ease;
  }

  .addimage svg {
    color: #0afa2a;
    width: 2rem;
    height: 2rem;
  }

  .addcontent {
    margin-top: 0.75rem;
    text-align: center;
  }

  .addtitle {
    color: #066e29;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1.5rem;
  }

  .addmessage {
    margin-top: 0.5rem;
    color: #595b5f;
    font-size: 0.875rem;
    line-height: 1.25rem;
  }

  .addactions {
    margin: 0.75rem 1rem;
  }

  .addhistory {
    display: inline-flex;
    padding: 0.5rem 1rem;
    background-color: #1aa06d;
    color: #ffffff;
    font-size: 1rem;
    line-height: 1.5rem;
    font-weight: 500;
    justify-content: center;
    width: 100%;
    border-radius: 0.375rem;
    border: none;
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  }

  .addtrack {
    display: inline-flex;
    margin-top: 0.75rem;
    padding: 0.5rem 1rem;
    color: #242525;
    font-size: 1rem;
    line-height: 1.5rem;
    font-weight: 500;
    justify-content: center;
    width: 100%;
    border-radius: 0.375rem;
    border: 1px solid #D1D5DB;
    background-color: #fff;
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  }

  @keyframes animate {
    from {
      transform: scale(1);
    }

    to {
      transform: scale(1.09);
    }
  }


  /* 모달을 화면 중앙에 띄우기 위한 기본 스타일 */

  .commonModal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(0, 0, 0, 0.5); /* 배경 오버레이 */
    z-index: 9500;
  }

  .commonModal-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.7); /* 오버레이 */
    z-index: 9000;
  }

  .commonModal-content {
    background-color: white;
    padding: 1.5rem;
    border-radius: 0.5rem;
    z-index: 9999; /* 오버레이보다 위 */
  }

  .hidden {
    display: none;
  }

  .toast-container * {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    border: none;
    font-family: "Poppins", sans-serif, "Noto Sans KR";
    font-size: 14px;
  }

  .toast-container {
    width: 380px;
    position: fixed;
    transform: translate(-50%, -50%);
    top: 50%;
    left: 50%;
    display: flex;
    z-index: 1000;
    margin-bottom: 50px;
    flex-direction: column;
  }

  .toast-message {
    width: 100%;
    height: 80px;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 7px;
    display: grid;
    grid-template-columns: 1.3fr 6fr 0.5fr;
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
    opacity: 0;
    transition: opacity 0.3s ease, transform 0.3s ease;
    position: relative;
  }

  .success {
    border-left: 8px solid #47D764;
  }

  .error {
    border-left: 8px solid #ff355b;
  }

  .info {
    border-left: 8px solid #2F86EB;
  }

  .warning {
    border-left: 8px solid #FFC021;
  }

  .error i {
    color: #ff355b;
  }

  .info i {
    color: #2F86EB;
  }

  .warning i {
    color: #FFC021;
  }

  .toast-message:not(:last-child) {
    margin-bottom: 20px;
  }

  .container-1, .container-2 {
    align-self: center;
  }

  .container-1 i {
    font-size: 35px;
  }

  .success i {
    color: #47D764;
  }

  .container-2 p:first-child {
    color: #101020;
    font-weight: 600;
    font-size: 16px;
  }

  .container-2 p:last-child {
    font-size: 12px;
    font-weight: 400;
    color: #656565;
  }

  .toast-container p {
    margin: 0;
    padding: 0;
    font-size: 12px;
    line-height: 1.4;
  }

  #closebutton {
    align-self: flex-start;
    background-color: transparent;
    font-size: 25px;
    color: #656565;
    line-height: 0;
    cursor: pointer;
    outline: none;
  }


  .toast-message.show {
    opacity: 1;
    transform: translateY(0); /* 위치를 원래대로 */
  }

  .toast-message.hide {
    opacity: 0;
    transform: translateY(0); /* 사라질 때도 위치 변화 없이 */
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
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
          rel="stylesheet">

    <jsp:include page="../includes/header.jsp"/>
</head>
<body>
<div id="toastContainer" class="toast-container">
</div>
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
    <button type="button" id="deleteBookButton"
            class="btn btn-outline-danger" ${mode == 'edit' ? '' : 'disabled'}>책 삭제
    </button>
    <div class="row">
        <form class="needs-validation was-validated" enctype="multipart/form-data">
            <div class="row">
                <div id="preview" style="padding: 20px;">
                   <img id="bookImage" src="/library/books/${bookDetail.photo}" alt="${bookDetail.photo}"
                   ${mode == 'add' || bookDetail.photo != null && bookDetail.photo.startsWith('http') ? 'hidden' : ''}/>
                </div>
            </div>

            <!-- 공용 모달 -->
            <div id="commonModal" class="commonModal hidden">
                <div class="commonModal-overlay"></div>

                <div id="addModal" class="commonModal-content hidden">
                    <div class="addcard">
                        <div class="addheader">
                            <div class="addimage">
                                <svg viewBox="0 0 24 24" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
                                       stroke-linejoin="round"></g>
                                    <g id="SVGRepo_iconCarrier">
                                        <path d="M20 7L9.00004 18L3.99994 13" stroke="#000000"
                                              stroke-width="1.5" stroke-linecap="round"
                                              stroke-linejoin="round"></path>
                                    </g>
                                </svg>
                            </div>
                            <div class="addcontent">
                                <span class="addtitle">저장을 진행합니다.</span>
                                <p class="addmessage">올바르게 입력했는지 확인하셨나요? <br> 그렇다면 진행 하셔도 좋습니다.</p>
                            </div>
                            <div class="addactions">
                                <button id="${mode == 'edit' ? 'editBookButton' : 'confirmadd'}"
                                        class="addhistory" type="button">저장
                                </button>
                                <button id="cancleadd" class="addtrack cancelModal" type="button">취소
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="deleteModal" class="commonModal-content hidden">
                    <div class="deletecard">
                        <div class="deleteheader">
                            <div class="deleteimage">
                                <svg aria-hidden="true" stroke="currentColor" stroke-width="1.5"
                                     viewBox="0 0 24 24" fill="none">
                                    <path d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"
                                          stroke-linejoin="round" stroke-linecap="round"></path>
                                </svg>
                            </div>
                            <div class="deletecontent">
                                <span class="deletetitle">데이터 삭제를 진행합니까?</span>
                                <p class="deletemessage">삭제를 진행하면 돌이킬 수 없습니다.<br>신중한 판단 후 진행 하시길
                                    권합니다.</p>
                            </div>
                            <div class="deleteactions">
                                <button id="confirmDelete" class="desactivate" type="button">삭제
                                </button>
                                <button id="cancelDelete" class="deletecancel cancelModal"
                                        type="button">취소
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="tabs mb-2">
                <input type="radio" id="uploadByUrl" name="imageUploadType" value="url"
                ${bookDetail.photo != null && !bookDetail.photo.startsWith('http') ? '' : 'checked=""'}>
                <label class="tab" for="uploadByUrl">URL</label>
                <input type="radio" id="uploadByFile" name="imageUploadType" value="file"
                ${bookDetail.photo != null && !bookDetail.photo.startsWith('http') ? 'checked=""' : ''}>
                <label class="tab" for="uploadByFile">File</label>
                <span class="glider"></span>
            </div>
            <div class="col-sm-6">
                <div id="imageUrlInput" style="display:${bookDetail.photo != null && !bookDetail.photo.startsWith('http') ? 'none' : 'block'}">
                    <input type="text" id="photoUrl" name="photoUrl" class="form-control"
                           placeholder="이미지 URL을 입력하세요" maxlength="83"
                           value="${mode == 'edit' && bookDetail.photo != null && bookDetail.photo.startsWith('http') ? bookDetail.photo : ''}"
                           required="">
                </div>
                <div id="imageFileInput"
                     style="display:${bookDetail.photo != null && !bookDetail.photo.startsWith('http') ? 'block' : 'none'}">
                    <input type="file" id="fileInput" name="file" class="form-control"
                           value="${mode == 'edit' && bookDetail.photo != null && bookDetail.photo.startsWith('http') ? '' : bookDetail.photo}">
                </div>
            </div>

            <div class="row g-3">
                <div class="col-sm-6">
                    <label for="book" class="form-label">제목</label>
                    <input type="text" name="book" class="form-control" id="book"
                           placeholder="" maxlength="83"
                           value="${mode == 'edit' ? bookDetail.book : ''}" required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="manage col-sm-6">
                    <label for="author" class="form-label">작가</label>
                    <input type="text" name="author" class="form-control" id="author" placeholder=""
                           maxlength="83" value="${mode == 'edit' ? bookDetail.author : ''}" required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="col-sm-6">
                    <label for="publisher" class="form-label">출판사</label>
                    <input type="text" name="publisher" class="form-control" id="publisher"
                           placeholder="" maxlength="50"
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
                    <!-- 카테고리 목록 UI 영역 -->
                    <input type="text" value=""
                           class="form-control" id="categories" readonly>
                    <div id="categoryFeedback" class="invalid-feedback">
                        최소 1개의 카테고리가 선택되어야 합니다.
                    </div>
                    <div id="categoryListContainer" class="mt-3"></div>
                </div>
                <div class="btn-group" role="group">
                    <button id="dropdownMenuButton" type="button"
                            class="btn btn-secondary dropdown-toggle" data-toggle="dropdown"
                            aria-expanded="false">
                        카테고리
                    </button>
                    <ul id="categoryDropdownContainer" class="dropdown-menu"></ul>
                    <div id="subMenuWrapper"></div>
                </div>
                <button id="addCategoryButton" type="button" style="margin-left: 20px;">카테고리 추가
                </button>
                <div class="reset"
                     style="display: flex; justify-content: flex-end; margin-left: 20px">
                    <button id="resetButton" type="button" class="rebutton" style="outline: none;">
                        <span class="rebutton__text">메뉴 리셋</span>
                        <span class="rebutton__icon">
      <svg class="resvg" height="48" viewBox="0 0 48 48" width="48"
           xmlns="http://www.w3.org/2000/svg">
        <path d="M35.3 12.7c-2.89-2.9-6.88-4.7-11.3-4.7-8.84 0-15.98 7.16-15.98 16s7.14 16 15.98 16c7.45 0 13.69-5.1 15.46-12h-4.16c-1.65 4.66-6.07 8-11.3 8-6.63 0-12-5.37-12-12s5.37-12 12-12c3.31 0 6.28 1.38 8.45 3.55l-6.45 6.45h14v-14l-4.7 4.7z"></path>
        <path d="M0 0h48v48h-48z" fill="none"></path>
      </svg>
    </span>
                    </button>
                </div>
                <div class="manage col-12 mt-3">
                    <label for="isbn13" class="form-label">ISBN13</label>
                    <input type="text" name="isbn13" class="form-control" id="isbn13"
                           value="${mode == 'edit' ? bookDetail.isbn13 : ''}" placeholder=""
                    ${mode == 'edit' ? 'readonly' : ''} maxlength="13">
                    <!-- 경고 문구를 표시할 div 추가 -->
                    <div id="isbn-warning" class="invalid-feedback"
                         style="display: block;">
                        필수 항목 입니다. 13자리 숫자로 입력해 주세요.
                    </div>
                </div>
                <button type="button" id="confirm-button" class="btn btn-success mt-3"
                        style="min-width: 113px;" disabled>ISBN 확정하기
                </button>
                </button>
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
                    <input type="text" maxlength="10" name="bookPrice" value="${mode == 'edit' ? bookDetail.price
                    : ''}" class="form-control" id="bookPrice" placeholder="">
                    <div class="invalid-feedback">
                        Name on card is required
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="bookCount" class="form-label">재고수</label>
                    <input type="text" name="bookCount" maxlength="10"
                           value="${mode == 'edit' ? bookDetail.bookCount : ''}"
                           class="form-control" id="bookCount" placeholder=""
                           required="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="pageCount" class="form-label">쪽수</label>
                    <input type="text" name="pageCount" maxlength="5"
                           value="${mode == 'edit' ? bookDetail.pageCount : ''}"
                           class="form-control" id="pageCount" placeholder="">
                </div>
                <div class="col-md-3">
                    <label for="weight" class="form-label">무게(g)</label>
                    <input type="text" name="weight" maxlength="9"
                           value="${mode == 'edit' ? bookDetail.weight : ''}"
                           class="form-control" id="weight" placeholder="">
                    <div class="invalid-feedback">
                        필수 항목 입니다.
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="bookSize" class="form-label">크기(X*Y*Zmm)</label>
                    <input type="text" name="bookSize" maxlength="20"
                           value="${mode == 'edit' ? bookDetail.bookSize : ''}"
                           class="form-control" id="bookSize" placeholder="">
                    <div class="invalid-feedback">
                        Security code required
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="averageRating" class="form-label">평점</label>
                    <input type="text" name="averageRating" maxlength="4" value="${mode == 'edit' ? bookDetail.averageRating
                     : ''}" class="form-control" id="averageRating" placeholder="0.0" pattern="^(10\.0|[0-9]\.[0-9])$">
                    <div class="invalid-feedback">
                        0.0 ~ 10.0 사이의<br>숫자여야 합니다.
                    </div>
                </div>
                <div class="col-md-3">
                    <label for="reviewCount" class="form-label">리뷰수</label>
                    <input type="text" name="reviewCount" value="${mode == 'edit' ? bookDetail.reviewCount :
                     ''}" class="form-control" id="reviewCount" placeholder="" maxlength="6">
                    <div class="invalid-feedback">
                        Security code required
                    </div>
                </div>
                <div class="col-md-6 mt-4">
                    <label for="starRating1"></label><input type="text" id="starRating1"
                                                            style="margin-right: 15px"
                                                            class="form-control"
                                                            value="${mode == 'edit' ? (bookDetail.star1Count != null ? bookDetail.star1Count.replace('%', '') : '0') : '0'}"
                                                            name="starRating1"
                                                            placeholder="별 1개 비율">
                    <label for="starRating2"></label><input type="text" id="starRating2"
                                                            style="margin-right: 15px"
                                                            class="form-control"
                                                            value="${mode == 'edit' ? (bookDetail.star2Count != null ? bookDetail.star2Count.replace('%', '') : '0') : '0'}"
                                                            name="starRating2"
                                                            placeholder="별 2개 비율">
                    <label for="starRating3"></label><input type="text" id="starRating3"
                                                            style="margin-right: 15px"
                                                            class="form-control"
                                                            value="${mode == 'edit' ? (bookDetail.star3Count != null ? bookDetail.star3Count.replace('%', '') : '0') : '0'}"
                                                            name="starRating3"
                                                            placeholder="별 3개 비율">
                    <label for="starRating4"></label><input type="text" id="starRating4"
                                                            style="margin-right: 15px"
                                                            class="form-control"
                                                            value="${mode == 'edit' ? (bookDetail.star4Count != null ? bookDetail.star4Count.replace('%', '') : '0') : '0'}"
                                                            name="starRating4"
                                                            placeholder="별 4개 비율">
                    <label for="starRating5"></label><input type="text" id="starRating5"
                                                            style="margin-right: 15px"
                                                            class="form-control"
                                                            value="${mode == 'edit' ? (bookDetail.star5Count != null ? bookDetail.star5Count.replace('%', '') : '0') : '0'}"
                                                            name="starRating5"
                                                            placeholder="별 5개 비율">
                    <div id="starRatingInvalidFeedback" class="invalid-feedback"
                         style="display:none;">
                        별점은 총합 0 혹은 100 이어야 합니다.
                    </div>
                </div>
            </div>
            <hr class="my-4">
            <button class="w-50 btn btn-primary btn-lg" id="submitButton" type="button">저장</button>
        </form>
    </div>
</main>
</body>

<jsp:include page="../includes/footer.jsp"/>
<script src="/resources/js/booklist_ajax.js"></script>
<script src="/resources/js/category_ajax.js"></script>

<script>
  document.addEventListener('mousedown', function(event) {
    if (event.target.tagName !== 'INPUT' && event.target.tagName !== 'TEXTAREA') {
      event.preventDefault();  // 비인풋 요소가 클릭되면 기본 포커스 방지
    }
  });

  let isStarRatingValid = true;
  let isCategoryValid = false;
  let isIsbnValid = false;
  let isImageOrUrlValid = false;

  $(document).ready(function () {

    // submitButton 클릭 이벤트
    document.getElementById('submitButton').addEventListener('click', function () {
      console.log('submitButton 클릭됨');
      openModal('add');
    });

    // deleteBookButton 클릭 이벤트
    document.getElementById('deleteBookButton').addEventListener('click', function () {
      console.log('deleteBookButton 클릭됨');
      openModal('delete');
    });

    // 모달 열기 함수
    function openModal(modaltype) {
      console.log('모달 열기 호출됨:', modaltype);  // 로그 추가
      document.getElementById('commonModal').classList.remove('hidden');
      if (modaltype === 'add') {
        console.log('add')
        document.getElementById('addModal').classList.remove('hidden');
      } else if (modaltype === 'delete') {
        console.log('delete')
        document.getElementById('deleteModal').classList.remove('hidden');
      }
    }

    // '아니오' 버튼 클릭 시 모달 숨기기
    $('.cancelModal').click(function () {
      closeModal();
    });

    // 책 추가 버튼 클릭 시 (/addBook)
    $('#confirmadd').on('click', function (e) {
      if (validateAllFields()) { // 최종 유효성 검사 통과시
        const formData = collectFormData();  // 공통 데이터 수집 함수 호출
        sendFormData('/book/add', formData, 'POST');  // 책 추가 API에 데이터 전송
        closeModal();
      }
    });

    // 책 수정 버튼 클릭 시 (/editBook)
    $('#editBookButton').on('click', function (e) {
      closeModal();
      if (validateAllFields()) { // 최종 유효성 검사 통과시
        const isbn13 = $('#isbn13').val();  // ISBN13 수집
        const formData = collectFormData();
        sendFormData('/book/'+isbn13, formData, 'PUT');  // 책 수정
      }
    });

    // 삭제 버튼 클릭 시 (경로: /deleteBook)
    $('#confirmDelete').on('click', function (e) {
      closeModal();
      const isbn13 = $('#isbn13').val();  // ISBN13 수집
      const formData = new FormData();
      formData.append('isbn13', isbn13);  // 삭제 요청 시 ISBN13만 전송
      sendFormData('/book/'+isbn13, formData, 'DELETE');
    });

    function collectFormData() {
      // 전체 책 정보 객체 생성
      const bookData = {
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
        star5Count: (($('#starRating5').val() || '0') + '%').replace(/\s+/g, '').trim(),
        star4Count: (($('#starRating4').val() || '0') + '%').replace(/\s+/g, '').trim(),
        star3Count: (($('#starRating3').val() || '0') + '%').replace(/\s+/g, '').trim(),
        star2Count: (($('#starRating2').val() || '0') + '%').replace(/\s+/g, '').trim(),
        star1Count: (($('#starRating1').val() || '0') + '%').replace(/\s+/g, '').trim(),
        rentalAvailable: $('input[name="rentalAvailable"]:checked').val(),
        categories: selectedCategories.map(asdf => asdf.categoryId)
      };

      // formData 객체 생성 후, 전체 데이터를 JSON 형태로 추가
      const formData = new FormData();
      formData.append('bookData', JSON.stringify(bookData));  // 전체 데이터를 JSON으로 묶어서 추가

      // 이미지 업로드 방식 확인
      const imageUploadType = $('input[name="imageUploadType"]:checked').val();
      formData.append('imageUploadType', imageUploadType);  // 업로드 방식 추가

      // 이미지 업로드 방식에 따른 데이터 처리
      if (imageUploadType === 'url') {
        // URL 방식의 경우, photoUrl 필드를 추가
        const photoUrl = $('#photoUrl').val();
        formData.append('photoUrl', photoUrl);
      } else if (imageUploadType === 'file') {
        // 파일 업로드 방식의 경우, 파일 필드를 추가
        const fileInput = $('#fileInput')[0].files[0];
        formData.append('file', fileInput);
      }

      // 수집된 formData 반환
      return formData;
    }

    // 공통 AJAX 데이터 전송 함수
      function sendFormData(endpointUrl, formData, methodType) {
        $.ajax({
          url: '/ajax' + endpointUrl,  // 경로 설정
          type: methodType,  // 요청 타입 (POST/PUT/DELETE)
          data: formData,
          processData: false,  // FormData 사용 시 설정
          contentType: false,  // FormData 사용 시 설정
          success: function (response) {
            showToast('요청이 성공적으로 처리되었습니다!', 'success');
            setTimeout(() => {
                window.location.href = '/library/booklist'
            }, 800);
          },
          error: function (xhr, status, error) {
            console.error('에러 발생:', status, error);
            showToast('오류가 발생했습니다. 다시 시도해 주세요.', 'error');
          }
        });
      }
    });
  // 모달 닫기 함수
  function closeModal() {
    console.log('모달 닫기 호출됨')
    document.getElementById('commonModal').classList.add('hidden');
    document.getElementById('addModal').classList.add('hidden');
    document.getElementById('deleteModal').classList.add('hidden');
  }
</script>
<script>
  // ------------------- 별점 필드 유효성 검사 -------------------
  document.addEventListener('DOMContentLoaded', function () {
    const starFields = document.querySelectorAll('input[name^=starRating]');  // 별점 필드 모두 선택
    let remainingPercentage = 100;  // 초기 남은 비율
    const starInvalidFeedback = document.getElementById('starRatingInvalidFeedback');  // 경고 메시지 div

    // 입력 필드에 이벤트 핸들러 추가
    starFields.forEach(field => {
      field.addEventListener('input', function (event) {
        const inputElement = this;

        // 입력값을 숫자 이외의 값은 막고, 즉시 숫자 필터링 적용
        let inputVal = inputElement.value.replace(/[^0-9]/g, '');
        inputVal = parseInt(inputVal) || 0;

        // 현재 필드의 최대값을 기준으로 입력값 제한
        let maxAllowed = parseInt(inputElement.max) || remainingPercentage;
        if (inputVal > maxAllowed) {
          inputVal = maxAllowed;  // 최대값 초과 시 최대값으로 강제 설정
          console.log(`입력값이 초과되어 \${inputElement.name} 필드가 최대값(\${maxAllowed})으로 고정`);
        }

        // 필드의 값을 최대값으로 설정
        inputElement.value = inputVal;

        // 남은 비율과 필드 제한 업데이트
        updateRemainingPercentage();
        updateFieldLimits();

        // 유효성 검사 업데이트
        showStarRatingWarning();  // 경고 div 상태 업데이트
      });
    });

    // 남은 비율 계산 함수
    function updateRemainingPercentage() {
      let total = 0;
      starFields.forEach(field => {
        const value = parseInt(field.value) || 0;
        total += value;
      });
      remainingPercentage = 100 - total;  // 남은 비율 계산
      console.log(`총합: \${total}, 남은 비율: \${remainingPercentage}`);
    }

    // 각 필드의 최대 입력값 조정
    function updateFieldLimits() {
      starFields.forEach(field => {
        const currentValue = parseInt(field.value) || 0;
        field.max = remainingPercentage + currentValue;  // 각 필드의 최대값 설정
        console.log(`필드 (\${field.name})의 최대값 설정: \${field.max}`);
      });
    }

    // 별점 필드의 경고 div 상태 업데이트
    function showStarRatingWarning() {
      let total = 0;

      // 현재 별점 필드의 총합 계산
      starFields.forEach(field => {
        const value = parseInt(field.value) || 0;
        total += value;
      });

      // 경고 조건: 총합이 1~99인 경우에만 경고 표시
      if (total > 0 && total < 100) {
        starInvalidFeedback.style.display = 'block';  // 경고 메시지 표시
        isStarRatingValid = false;  // 경고가 표시되면 유효하지 않은 상태로 설정
      } else {
        starInvalidFeedback.style.display = 'none';  // 경고 메시지 숨김
        isStarRatingValid = true;  // 총합이 0 또는 100이면 유효 상태로 설정
      }
    }
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
      }
    } else {
      showToast('카테고리 데이터를 찾을 수 없습니다. 관리자에게 문의하세요.', 'error');
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
    updateCategoryValidation();
  }

  // 부모 요소인 categoryDropdownContainer에 이벤트 위임 적용 (1차 카테고리)
  // 이후 동적으로 생성된 자식요소에서 이벤트가 발생했을때
  // 자동으로 부모요소가 감지해서 이벤트처리를 함 => 밑에 새로 생기는거 눌러도 다 이벤트가 작동하게 해준다
  document.getElementById('categoryDropdownContainer').addEventListener('click', function (event) {
    if (event.target && event.target.matches('.dropdown-item div')) {
      const categoryId = event.target.getAttribute('data-category-id');
      const categoryName = event.target.textContent;

      onCategorySelected(categoryId, categoryName);
    }
  });

  // 하위 카테고리 메뉴에도 이벤트 위임 적용 (2차 카테고리 이후)
  // 첫 카테고리는 페이지 시작부터 있는 categoryDropdownContainer 인데
  // 2차 이후 카테고리는 subMenuWrapper 라서 따로 위임을 시킴.
  document.getElementById('subMenuWrapper').addEventListener('click', function (event) {
    if (event.target && event.target.matches('.dropdown-item div')) {
      const categoryId = event.target.getAttribute('data-category-id');
      const categoryName = event.target.textContent;

      onCategorySelected(categoryId, categoryName);
    }
  });

  document.getElementById('addCategoryButton').onclick = function () {
    addCategory();
  };

  // '카테고리 추가' 버튼 클릭 시 호출될 함수.
  function addCategory() {
    if (currentLowestCategoryId && currentLowestCategoryName) {
      let shouldAdd = true;

      // 1. 하위 카테고리인지 확인 (목록의 카테고리가 새로 추가하려는 카테고리의 부모인지 확인)
      selectedCategories.forEach(category => {
        const isParentCategory = currentLowestCategoryId.startsWith(category.categoryId); // 하위 카테고리인지 확인
        const isSubCategory = category.categoryId.startsWith(currentLowestCategoryId); // 상위 카테고리인지 확인
        const isExactMatch = currentLowestCategoryId === category.categoryId; // 정확히 일치하는지 확인

        if (isExactMatch) {
          showToast('이미 추가된 카테고리와 동일한 카테고리입니다.', 'error');
          shouldAdd = false;
        } else if (isParentCategory) {
          // 하위 카테고리인 경우, 상위 카테고리를 교체
          selectedCategories = selectedCategories.filter(c => c.categoryId !== category.categoryId);
        } else if (isSubCategory) {
          // 상위 카테고리 추가를 막음
          showToast('하위 카테고리가 이미 추가되어 있으므로 상위 카테고리를 추가할 수 없습니다.', 'error');
          shouldAdd = false;
        }
      });

      // 카테고리 추가
      if (shouldAdd) {
        selectedCategories.push(
            {categoryId: currentLowestCategoryId, categoryName: currentLowestCategoryName});
        updateCategoryValidation();
      }

      updateCategoryListUI(); // UI와 텍스트 필드 업데이트
    } else {
      showToast('카테고리를 선택해주세요.', 'warning');
    }
  }

  const categoryFeedback = document.getElementById('categoryFeedback');  // 경고 메시지 div

  // 카테고리 유효성 검사 함수
  function updateCategoryValidation() {
    // selectedCategories 배열에 값이 하나라도 있으면 유효
    if (selectedCategories.length > 0) {
      categoryFeedback.style.display = 'none';  // 경고 메시지 숨김
      isCategoryValid = true;  // 유효 상태로 설정
    } else {
      categoryFeedback.style.display = 'block';  // 경고 메시지 표시
      isCategoryValid = false;  // 유효하지 않은 상태로 설정
    }
    console.log(`카테고리 유효성 검사: \${isCategoryValid ? '유효' : '유효하지 않음'}`);
  }

  // 초기 로딩 시 유효성 검사 수행
  updateCategoryValidation();

</script>
<script>
  // 뒤로 가기 버튼 함수
  function backtolist() {
    history.back();
  }
</script>
<script>
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
  function showToast(message, type = 'success') {
    const toastContainer = document.getElementById('toastContainer');

    // 아이콘 선택 로직
    const iconClass = type === 'success' ? 'fas fa-check-circle'
        : type === 'error' ? 'fas fa-times-circle' : type === 'info' ? 'fas fa-info-circle'
            : 'fas fa-exclamation-circle';

    // Toast 메시지 생성
    const toast = document.createElement('div');
    toast.className = `toast-message ${'${type}'}`; // 타입선택 (success, warning, error)
    toast.innerHTML = `
      <div class="container-1">
          <i class="${'${iconClass}'}"></i>
      </div>
      <div class="container-2">
          <p>${'${type.charAt(0).toUpperCase() + type.slice(1)}'}</p>
          <p>${'${message}'}</p>
      </div>
      <button id="closebutton">&times;</button>
  `;

    // 닫기 버튼 이벤트 추가 - 애니메이션 추가
    const closeButton = toast.querySelector('button');
    closeButton.addEventListener('click', () => {
      toast.classList.remove('show');  // 서서히 사라지도록 show 클래스를 제거
      setTimeout(() => {
        toast.remove();  // 애니메이션이 끝난 후 완전히 제거
      }, 500); // 500ms 후에 제거 (opacity 애니메이션과 일치)
    });

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
        toast.remove();
      }, 500); // 사라지는 애니메이션을 위해 약간의 시간 추가
    }, 3000); // 3초 후에 Toast 닫힘
  }

</script>
<script>
  $(document).ready(function () {
    const currentMode = '${mode}';
    if (currentMode === 'add') {
      return;
    }
    const currentCategories = '${categories}';
    const bookCategories = JSON.parse(currentCategories);

    console.log("타입:", typeof bookCategories);
    console.log("배열?:", Array.isArray(bookCategories));

    const categoryIds = bookCategories.find(category => category.categoryId);
    console.log("추출된 categoryIds:", categoryIds);

    if (currentMode === 'edit' && bookCategories.length > 0) {
      bookCategories.forEach(category => {
        // 카테고리 이름을 가져오기 위해서 매핑하는 함수 호출
        onCategorySelected(category.categoryId);
        // addCategory 함수를 직접 호출
        if (currentLowestCategoryId && currentLowestCategoryName) {
          addCategory();
        }
      });
    }
  });

</script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    // ------------------- ISBN 유효성 검사 -------------------
    const isbnInput = document.getElementById('isbn13');
    const confirmButton = document.getElementById('confirm-button');
    const isbnWarning = document.getElementById('isbn-warning'); // 경고 문구 div
    let timeout = null;

    const isbnValue = isbnInput.value;

    console.log(isbnValue)
    // 페이지 로드 시 readonly 상태 확인
    if (isbnValue.length === 13) {
      isIsbnValid = true; // ISBN이 확정된 상태이므로 유효 상태로 설정
      isbnWarning.style.display = 'none';
    }

    isbnInput.addEventListener('input', function () {
      // 입력값이 숫자가 아닌 경우 즉시 제거
      this.value = this.value.replace(/[^0-9]/g, '');

      if (isbnInput.hasAttribute('readonly')) return; // 읽기전용이라면 검사 중지

      // 입력값이 13자리가 아니라면 경고 표시 & 서버 요청 취소
      if (this.value.length !== 13) {
        clearTimeout(timeout);
        confirmButton.disabled = true; // 유효하지 않으면 "이름 확정" 버튼 비활성화
        isbnWarning.textContent = '필수 항목 입니다. 13자리 숫자로 입력해 주세요.';
        isbnWarning.style.display = 'block'; // 경고 표시
        isIsbnValid = false; // 유효하지 않은 상태
        return;
      }

      // 0.2초 딜레이 후 중복 검사
      clearTimeout(timeout);
      timeout = setTimeout(function () {
        fetch(`/ajax/checkIsbn?isbn13=${isbnInput.value}`) // 적힌걸 url로
        .then(response => response.text())
        .then(data => {
          if (data.isDuplicate) {
            isbnWarning.textContent = '이미 존재하는 ISBN입니다.';
            isbnWarning.style.display = 'block';
            confirmButton.disabled = true; // 중복일 경우 버튼 비활성화
            isIsbnValid = false;
          } else {
            isbnWarning.style.display = 'none'; // 유효성 검사 통과 시 경고 문구 숨김
            confirmButton.disabled = false; // 중복이 아닐 경우 버튼 활성화
          }
        })
        .catch(error => {
          console.error('Error:', error);
          isbnWarning.textContent = '오류가 발생했습니다. 다시 시도해 주세요.';
          isbnWarning.style.display = 'block';
          confirmButton.disabled = true; // 오류 발생 시 버튼 비활성화
          isIsbnValid = false;
        });
      }, 200); // 0.2초 딜레이
    });

    // 확정 버튼 클릭 시 ISBN 필드 읽기 전용으로 변경
    confirmButton.addEventListener('click', function () {
      isbnInput.setAttribute('readonly', 'true'); // ISBN 필드 읽기 전용으로 변경
      confirmButton.textContent = 'ISBN 확정완료'; // 버튼 텍스트 변경
      confirmButton.disabled = true; // 버튼 비활성화
      isIsbnValid = true;  // 확정 버튼 클릭 시 유효 상태로 설정
    });
  });
</script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const previewContainer = document.getElementById('preview');  // 파일 미리보기 컨테이너
    const fileInput = document.getElementById('fileInput');  // 파일 입력 필드
    const photoUrlField = document.getElementById('photoUrl');  // URL 입력 필드
    const uploadFeedback = document.getElementById('uploadFeedback');
    const bookImage = document.getElementById('bookImage');

    if ((fileInput.files.length > 0) ||  // 파일이 선택되었는지 확인
        (photoUrlField.value.trim().length > 0) ||  // URL이 입력되었는지 확인
        (bookImage.src && !bookImage.hidden)){  // 이미지의 src가 존재하고 숨겨져 있지 않은지 확인
      isImageOrUrlValid = true;
    }

    fileInput.addEventListener('change', function (event) {
      let files = event.target.files;
      if (files && files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          let imgElement = document.createElement('img');
          imgElement.src = e.target.result;
          imgElement.alt = "Uploaded Image";

          previewContainer.innerHTML = '';  // 기존의 프리뷰를 삭제
          previewContainer.appendChild(imgElement);
        };
        reader.readAsDataURL(files[0]);  // 파일을 읽어 미리보기 생성
        isImageOrUrlValid = true;  // 파일이 선택된 경우 유효 상태로 설정
      } else {
        previewContainer.innerHTML = '';  // 파일 선택 취소 시 미리보기 제거
        isImageOrUrlValid = false;  // 파일이 선택되지 않은 경우 유효하지 않은 상태
      }
    });

    // URL 입력 시 유효성 검사
    photoUrlField.addEventListener('input', function () {
      const urlValue = this.value.trim();
      if (urlValue) {
        isImageOrUrlValid = true;  // URL 값이 입력된 경우 유효 상태로 설정
      } else {
        isImageOrUrlValid = false;  // URL 값이 비어있으면 유효하지 않은 상태
      }
    });

    // 라디오 버튼 전환 시 기존 데이터 초기화
    $('input[name="imageUploadType"]').on('change', function () {
      const selectedType = $(this).val();
      if (selectedType === 'url') {
        // URL로 전환 시 파일 입력 필드와 미리보기 완전 초기화
        fileInput.value = '';  // 파일 입력 필드 초기화
        previewContainer.innerHTML = '';  // 파일 미리보기 삭제

        // 유효성 상태 초기화
        isImageOrUrlValid = false;
        $('#photoUrl').prop('required', true);  // URL 필드에 required 적용
        $('#fileInput').prop('required', false);  // 파일 필드에서 required 제거
        $('#preview').hide();
        $('#imageUrlInput').show();
        $('#imageFileInput').hide();
      } else {
        // 파일로 전환 시 URL 필드 초기화
        photoUrlField.value = '';  // URL 필드 초기화
        isImageOrUrlValid = false;  // 유효성 상태 초기화
        $('#photoUrl').prop('required', false);  // URL 필드에서 required 제거
        $('#fileInput').prop('required', true);  // 파일 필드에 required 적용
        $('#preview').show();
        $('#imageUrlInput').hide();
        $('#imageFileInput').show();
      }
    });

    if (!isImageOrUrlValid) {
      uploadFeedback.style.display = 'block';
    } else {
      uploadFeedback.style.display = 'none';
    }
  });
</script>
<script>
  // 최종 유효성 검사 함수
  function validateAllFields() {
    const errorMessages = {
      isIsbnValid: 'ISBN',
      isStarRatingValid: '별점',
      isImageOrUrlValid: '이미지 또는 URL',
      isCategoryValid: '카테고리'
    };

    const flagValues = {
      isIsbnValid,
      isStarRatingValid,
      isImageOrUrlValid,
      isCategoryValid
    };

    // 유효성 검사를 통과하지 못한 항목 수집
    const invalidFields = Object.entries(errorMessages)
    // 아래의 _ 는 해당 자리의 변수를 사용하지 않겠다는 관례적으로 쓰이는 국룰 표시. 그냥 비워놔도 작동함.

    .filter(([flag, _]) => !flagValues[flag])  // 플래그가 false인 항목만 필터링
    .map(([_, message]) => message);  // 각 항목의 이름만 추출

    if (invalidFields.length === 0) {
      console.log("모든 유효성 검사를 통과했습니다.");
      return true;  // 모든 필드가 유효하면 true 반환
    } else {
      closeModal();
      // 유효하지 않은 항목들을 모아 메시지 생성
      const toastMessage = `확인이 필요한 입력이 있습니다.<br> ${"${invalidFields.join('<br>')}"}`;
      showToast(toastMessage, 'error');  // 토스트 메시지 출력
      console.error("유효성 검사 실패:", toastMessage);
      return false;  // 하나라도 유효하지 않으면 false 반환
    }
  }
</script>
<script>
  // 사진 있는척하기
  const fileInput = document.querySelector('input[type="file"]');
  const originalPhoto = '${bookDetail.photo}';
  if (originalPhoto.length > 30){

  const displayPhoto = originalPhoto.substring(originalPhoto.indexOf('_') + 1);

  const myFile = new File([''], displayPhoto, {
    type: 'text/plain',
    lastModified: new Date(),
  });

  const dataTransfer = new DataTransfer();
  dataTransfer.items.add(myFile);
  fileInput.files = dataTransfer.files;
  }
</script>
</html>