let currentSortOrder = 'DESC';
let currentCategoryId = ''; // 현재 선택된 카테고리 ID를 저장하는 변수
let currentAmount = 10; // 현재 출력 개수를 저장할 전역 변수, 초기값 10
let currentSearchQuery = '';

$(document).ready(function() {
    loadPage(1, `b.publication_date ${currentSortOrder}`, currentSearchQuery, currentCategoryId, currentAmount);
});


function changeItemsPerPage(value) {
    currentAmount = value; // 선택한 출력 개수를 전역 변수에 저장
    document.getElementById('itemsPerPageButton').textContent = `${value}개씩 보기`; // 드롭다운 버튼의 텍스트 업데이트
    loadPage(1, `b.publication_date ${currentSortOrder}`, '', currentCategoryId, currentAmount); // 페이지 로드
}


function toggleSortOrder() {
    currentSortOrder = (currentSortOrder === 'DESC') ? 'ASC' : 'DESC';
    document.getElementById('sortButton').innerText = (currentSortOrder === 'DESC') ? '최신순' : '오래된순';
    const sortOption = `b.publication_date ${currentSortOrder}`;
    loadPage(1, sortOption, '', currentCategoryId);
}

function loadPage(pageNum, sortOption = `b.publication_date ${currentSortOrder}`, searchQuery = '', category_id = currentCategoryId, amount = currentAmount) {
    const searchParams = new URLSearchParams(window.location.search);

    const rentalAvailable = $("input[name='rentalAvailable']").is(":checked") ? 'Y' : '';
    const publicationDateFilter = $("select[name='publicationDateFilter']").val() || '';

    currentCategoryId = category_id;

    if (rentalAvailable) updateURLParam('rentalAvailable', rentalAvailable, false);
    if (publicationDateFilter) updateURLParam('publicationDateFilter', publicationDateFilter, false);
    if (category_id) updateURLParam('category', category_id, false); // URL에는 'category'로 표시

    // 검색어와 페이지 번호를 URL에 반영
    if (searchQuery !== '') {
        searchParams.set('searchQuery', searchQuery);
    } else if (searchParams.has('searchQuery')) {
        searchQuery = searchParams.get('searchQuery');
    }

    // amount가 10이 아닐 때만 URL에 추가
    if (amount !== 10) {
        searchParams.set('amount', amount);
    } else if (searchParams.has('amount')) {
        searchParams.delete('amount');
    }

    const newSearchQuery = searchParams.toString();
    const newUrl = window.location.pathname + (newSearchQuery ? '?' + newSearchQuery : '');
    window.history.pushState({ path: newUrl }, '', newUrl); // 히스토리 스택 업데이트

    // AJAX 요청으로 페이지 데이터 로드
    $.ajax({
        url: '/ajax/booklist',
        type: 'GET',
        data: {
            pageNum: pageNum,
            amount: amount,
            rentalAvailable: rentalAvailable,
            publicationDateFilter: publicationDateFilter,
            category_id: category_id,
            searchQuery: searchQuery,
            sort: sortOption
        },
        success: function (data) {
            if (data && data.list) {
                renderBookList(data.list);
                renderPaging(data);
            } else {
                alert('데이터를 불러오지 못했습니다.');
            }
        },
        error: function (xhr, status, error) {
            alert('도서 목록을 가져오는데 실패했습니다: ' + error);
        }
    });
}

    const radioButtons = document.querySelectorAll('input[name="tabs"]');
    const listContainer = document.querySelector('.list_wrap');

    radioButtons.forEach(function(radio) {
        radio.addEventListener('change', function() {
            if (this.value === 'list') {
                listContainer.classList.remove('grid-view'); // 바둑판형 스타일 제거
                renderBookList(bookList); // 리스트형 렌더링 함수 호출
            } else {
                listContainer.classList.add('grid-view'); // 바둑판형 스타일 적용
                renderBookGrid(bookList); // 바둑판형 렌더링 함수 호출
            }
        });
    });

function renderBookList(bookList) {
    const listBox = $('.list_wrap');
    listBox.empty();
    bookList.forEach(function (book) {
        let publicationDate;
        if (book.publicationDate && typeof(book.publicationDate) === 'object') {
            const {year, month, dayOfMonth} = book.publicationDate;
            const monthIndex = new Date(Date.parse(`${month} 1, ${year}`)).getMonth();
            publicationDate = new Date(year, monthIndex, dayOfMonth);
        }
        const formattedDate = `${publicationDate.getFullYear()}-${String(publicationDate.getMonth() + 1).padStart(2, '0')}-${String(publicationDate.getDate()).padStart(2, '0')}`;
        const bookItem = `
            <div class="card border border-dark mb-3">
                <div class="row g-0">
                    <div class="col-md-4">
                        <span class="img position-absolute border border-dark">
                            <img src="${book.photo}" class="img-fluid rounded-start" alt="${book.book}">
                        </span>
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <p class="booktitle">${book.book}</p>
                            <p class="card-sub-text">${book.author}</p>
                            <p class="card-sub-text">${book.publisher}</p>
                            <p class="card-sub-text">${formattedDate}</p>
                        </div>
                    </div>
                </div>
            </div>
        `;
        listBox.append(bookItem);
    });
}
// 바둑판형 렌더링 함수
function renderBookGrid(bookList) {
    const listBox = $('.list_wrap');
    listBox.empty();
    bookList.forEach(function (book) {
        let publicationDate = formatPublicationDate(book.publicationDate);
        const bookItem = `
            <div class="grid-item">
                <div class="card border border-dark mb-3">
                    <span class="img position-absolute border border-dark">
                        <img src="${book.photo}" class="img-fluid rounded-start" alt="${book.book}">
                    </span>
                    <div class="card-body">
                        <p class="booktitle">${book.book}</p>
                        <p class="card-sub-text">${book.author}</p>
                        <p class="card-sub-text">${book.publisher}</p>
                        <p class="card-sub-text">${publicationDate}</p>
                    </div>
                </div>
            </div>
        `;
        listBox.append(bookItem);
    });
}
function renderPaging(pageData) {
    const pagingBox = $('.pagination');
    pagingBox.empty();

    const firstPageItem = `<li class="page-item ${pageData.startPage === 1 ? 'disabled' : ''}">
        <button class="page-link" onclick="loadPage(1)">처음으로</button>
    </li>`;
    pagingBox.append(firstPageItem);

    const prevPageItem = `<li class="page-item ${pageData.startPage === 1 ? 'disabled' : ''}">
        <button class="page-link" onclick="loadPage(${Math.max(1, pageData.startPage - 10)})">이전페이지</button>
    </li>`;
    pagingBox.append(prevPageItem);

    for (let i = pageData.startPage; i <= pageData.endPage; i++) {
        const pageItem = `<li class="page-item ${pageData.pge.pageNum === i ? 'active' : ''}">
            <button class="page-link" onclick="loadPage(${i})">${i}</button>
        </li>`;
        pagingBox.append(pageItem); // 현재 페이지 나타낼땐 pageDate.pge.pageNum 임
    }

    const nextPageItem = `<li class="page-item ${pageData.next ? '' : 'disabled'}">
        <button class="page-link" onclick="loadPage(${Math.min(pageData.endPage + 1, pageData.finalPage)})">다음페이지</button>
    </li>`;
    pagingBox.append(nextPageItem);

    const lastPageItem = `<li class="page-item ${pageData.next ? '' : 'disabled'}">
        <button class="page-link" onclick="loadPage(${pageData.finalPage})">끝으로</button>
    </li>`;
    pagingBox.append(lastPageItem);
    maxPage = pageData.finalPage; // 페이지 이동 입력창에 쓰이는 코드
}

function updateURLParam(paramName, paramValue, shouldReplace = false) {
    const searchParams = new URLSearchParams(window.location.search);

    if (paramName !== 'initialLoad' && paramName !== 'pageNum' && paramName !== 'sortOption') {
        if (paramValue) {
            searchParams.set(paramName, paramValue);
        } else {
            searchParams.delete(paramName);
        }
    }

    const newSearchQuery = searchParams.toString();
    const newUrl = window.location.pathname + (newSearchQuery ? '?' + newSearchQuery : '');

    if (shouldReplace) {
        window.history.replaceState({ path: newUrl }, '', newUrl);
    } else {
        const currentState = window.history.state || {};
        const currentCategory = currentState.category_id;

        if (currentCategory !== paramValue) {
            window.history.pushState({ category_id: paramValue }, '', newUrl);
        }
    }

    window.resetBookFilters = resetBookFilters;

    function resetBookFilters() {

        // 기타 필터 초기화 로직
        currentSortOrder = 'DESC';
        currentAmount = 10;
        currentSearchQuery ='';
        currentCategoryId = '';
        document.getElementById('sortButton').innerText = '최신순';
        document.getElementById('itemsPerPageButton').textContent = '10개씩 보기';
        document.getElementById('searchInput').value = '';

        // URL 파라미터 초기화
        updateURLParam('rentalAvailable', '');
        updateURLParam('publicationDateFilter', '');
        updateURLParam('searchQuery', '', true);

        loadPage(1); // 기본 페이지 로드
    }

}