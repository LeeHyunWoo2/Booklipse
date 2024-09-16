let currentSortOrder = 'DESC';

$(document).ready(function() {
    loadPage(1, `b.publication_date ${currentSortOrder}`);
    $('#sortButton').click(toggleSortOrder);
});

function toggleSortOrder() {
    currentSortOrder = (currentSortOrder === 'DESC') ? 'ASC' : 'DESC';
    const sortOption = `b.publication_date ${currentSortOrder}`;
    document.getElementById('sortButton').innerText = (currentSortOrder === 'DESC') ? '최신순' : '오래된순';
    loadPage(1, sortOption);
}

function loadPage(pageNum, sortOption = `b.publication_date ${currentSortOrder}`, searchQuery = '', categoryId = '') {
    const searchParams = new URLSearchParams(window.location.search);

    const rentalAvailable = $("input[name='rentalAvailable']").is(":checked") ? 'Y' : '';
    const publicationDateFilter = $("select[name='publicationDateFilter']").val() || '';

    if (rentalAvailable !== '') searchParams.set('rentalAvailable', rentalAvailable);
    if (publicationDateFilter !== '') searchParams.set('publicationDateFilter', publicationDateFilter);
    if (categoryId !== '') searchParams.set('categoryId', categoryId);

    if (searchQuery !== '') {
        searchParams.set('searchQuery', searchQuery);
    } else if (searchParams.has('searchQuery')) {
        searchQuery = searchParams.get('searchQuery');
    }

    if (!sortOption) {
        sortOption = `b.publication_date ${currentSortOrder}`;
    }

    const defaultSortOption = `b.publication_date DESC`;
    if (sortOption !== defaultSortOption && sortOption !== `b.publication_date ASC`) {
        searchParams.set('sort', sortOption);
    } else {
        searchParams.delete('sort');
    }

    const newUrl = window.location.pathname + (searchParams.toString() ? '?' + searchParams.toString() : '');
    history.replaceState({}, '', newUrl);

    $.ajax({
        url: '/ajax/booklist',
        type: 'GET',
        data: {
            pageNum: pageNum,
            rentalAvailable: rentalAvailable,
            publicationDateFilter: publicationDateFilter,
            categoryId: categoryId,
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

function renderBookList(bookList) {
    const listBox = $('.list_wrap');
    listBox.empty();
    bookList.forEach(function (book) {
        let publicationDate;
        if(book.publicationDate && typeof(book.publicationDate) === 'object') {
            const {year, month, dayOfMonth} = book.publicationDate;
            const monthIndex = new Date(Date.parse(`${month} 1, ${year}`)).getMonth();
            publicationDate = new Date(year, monthIndex, dayOfMonth);
        }
        const formattedDate = `${publicationDate.getFullYear()}-${String(publicationDate.getMonth() + 1)
            .padStart(2,'0')}-${String(publicationDate.getDate()).padStart(2,'0')}`;
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
        const pageItem = `<li class="page-item ${pageData.pageNum === i ? 'active' : ''}">
            <button class="page-link" onclick="loadPage(${i})">${i}</button>
        </li>`;
        pagingBox.append(pageItem);
    }

    const nextPageItem = `<li class="page-item ${pageData.next ? '' : 'disabled'}">
        <button class="page-link"  onclick="loadPage(${Math.min(pageData.endPage + 1, pageData.finalPage)})">다음페이지</button>
    </li>`;
    pagingBox.append(nextPageItem);

    const lastPageItem = `<li class="page-item ${pageData.next ? '' : 'disabled'}">
        <button class="page-link"  onclick="loadPage(${pageData.finalPage})">끝으로</button>
    </li>`;
    pagingBox.append(lastPageItem);
}
