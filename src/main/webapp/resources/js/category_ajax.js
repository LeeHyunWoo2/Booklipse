$(document).ready(function () {
    function isManagePage() {
        return window.location.pathname.includes('/library/manage') &&
            (window.location.search.includes('mode=add') || window.location.search.includes('mode=edit'));
        // 원래는 한 jsp 파일에서 사용할 스크립트 파일이었는데, 쓸만한 기능이 많아서 다른 jsp파일에서도 사용하게되어서
        // include를 하다보니 원치않는 함수까지 작동되어 버리기 때문에 페이지 링크에 따른 필터를 적용시키려고 만든 함수

        // 이 부분은 모듈화를 할 생각이 없었다가 성급하게 아이디어가 추가되면서 발생한 일이기 때문에
        // 코드 작성 시 확장성을 염두해야 한다는걸 배웠습니다.
    }


    function saveCategoryDataToSessionStorage(categoryData) {
        // 카테고리 데이터를 세션 스토리지에 저장하는 함수
        sessionStorage.setItem('categoryData', JSON.stringify(categoryData));
    }
    // 해당 함수는 타 jsp 파일에서도 공통적으로 사용되기 때문에 전역으로 선언하였습니다.
    // 유틸리티 파일처럼 공통적으로 사용되는 로직을 모아두는 파일을 만들었어야 했는데 이 부분이 아쉬운점으로 남습니다.
    window.getCategoryDataFromSessionStorage = function () {
        // 세션 스토리지에서 카테고리 데이터를 가져오는 함수
        const data = sessionStorage.getItem('categoryData');
        return data ? JSON.parse(data) : null;
    };

    // 브라우저의 뒤로가기, 앞으로가기에 대응하는 popstate 이벤트 처리. 카테고리 정보가 히스토리가 변경될때 날라가는걸 확인 후 추가함
    window.addEventListener('popstate', function (event) {
        if (event.state) {
            const categoryId = event.state.categoryId;
            updateCategoryUI(categoryId); // 카테고리에 맞는 UI 업데이트
            loadBooksByCategory(categoryId); // 해당 카테고리의 도서 목록을 다시 로드
        }
    });

    // 페이지 초기화 및 카테고리 로드
    loadCategories();

    // 초기화 버튼 클릭 시 카테고리를 초기화하는 이벤트 처리
    // 카테고리 정보를 사용하는 각 페이지마다 동일한 id를 사용하는 버튼을 만들고, 동일한 디자인 동일한 로직을 사용하게 하려고 했는데
    // 굳이 이렇게 할 필요가 있었나 싶은점이 아쉬운점으로 남습니다.
    document.getElementById('resetButton').onclick = function () {
        resetCategories();
    };

    function loadCategories() {
        // 카테고리 데이터를 세션 스토리지에서 불러오거나, 없으면 서버에서 비동기로 로드
        const categoryData = getCategoryDataFromSessionStorage();

        if (categoryData) {
            buildCategoryDropdown(categoryData); // 세션 저장소의 데이터를 사용하여 드롭다운 메뉴 구성
            console.log('세션 저장소에서 카테고리 데이터를 가져옴.');
            console.log(categoryData);
        } else {
            $.ajax({
                url: '/categories/list', // 서버에서 카테고리 가져옴
                type: 'GET',
                dataType: 'json',
                success: function (categories) {
                    saveCategoryDataToSessionStorage(categories); // 서버에서 받은 데이터를 세션에 저장
                    buildCategoryDropdown(categories); // 카테고리 드롭다운 메뉴 구성 (첫 로드때 메뉴가 안보이기 때문에 여기서 따로 호출)
                    console.log('서버에서 카테고리 데이터를 가져옴');
                    console.log(categories);
                },
                error: function (xhr, status, error) {
                    console.error('카테고리 데이터를 가져오는데 실패했습니다:', error);
                }
            });
        }
    }


    // 현재 카테고리 ID는 1001"을 포함하여 모든 카테고리의 ID가 형성됨.
    // 예시: 1차 카테고리 "국내도서" → ID: 1001001 , 2차 카테고리 "요리" → ID: 1001001001
    // 즉, 1차 카테고리부터 뒤의 3자리수가 늘어나면 그 하위 카테고리 라는것을 의미합니다. (실제 Yes24의 카테고리 구조를 참고하였습니다.)
    // 따라서, parentId와 categoryId의 일치 여부를 비교할 때, 이 ID 구조를 고려하여 필터링합니다.

    function buildCategoryDropdown(categories) {
        // 카테고리 드롭다운 메뉴를 구성하는 함수
        const dropdownMenu = document.getElementById('categoryDropdownContainer');
        dropdownMenu.innerHTML = ''; // 기존 메뉴 초기화

        const categoryMap = {}; // 카테고리 ID로 카테고리를 찾기 위한 맵
        categories.forEach(category => {
            categoryMap[category.categoryId] = category; // 카테고리 맵에 등록
            category.children = []; // 각 카테고리의 하위 카테고리 배열 초기화
        });

        categories.forEach(category => {
            if (category.parentId && categoryMap[category.parentId]) {
                categoryMap[category.parentId].children.push(category); // 상위 카테고리에 하위 카테고리 추가
            }
        });

        const topCategories = categories.filter(category => category.categoryId === '1');
        // 카테고리 ID1 은 현재 DB상으로만 존재하는 최상위 카테고리이며, 원래 이름은 국내도서 입니다.
        // 해외도서 데이터도 사용할걸 감안하고 설계했으나 시간 관계상 취소되어 이렇게 되었습니다.
        // 원래는 parentId = null 이런식으로 가져오도록 설계했습니다.

        if (topCategories.length > 0) {
            const domesticCategory = topCategories[0];
            const secondLevelCategories = domesticCategory.children || []; // 2차 카테고리 가져오기

            secondLevelCategories.forEach(category => {
                const menuItem = createCategoryMenuItem(category, 1); // 1단계 카테고리 메뉴 생성
                dropdownMenu.appendChild(menuItem); // 드롭다운 메뉴에 추가
            });
        }
    }

    function createCategoryMenuItem(category, level) {
        // 카테고리 메뉴 항목을 생성하는 함수
        const item = document.createElement('li');
        item.className = 'dropdown-item'; // 메뉴 항목의 CSS 클래스 설정

        const link = document.createElement('div');
        link.textContent = category.categoryName; // 카테고리 이름 설정
        link.style.cursor = 'pointer'; // 커서를 포인터로 설정

        // 카테고리 ID를 data-category-id 속성에 추가
        link.setAttribute('data-category-id', category.categoryId);

        link.onclick = function () {
            if (!window.location.pathname.includes('/library/manage')){
            updatePreferenceOnCategoryClick(category.categoryId, category.categoryName, level+1, 1.0);
                // 클릭시 해당하는 카테고리의 선호도 점수 추가 (매니지먼트 페이지에선 비활성화)
            }
            clearSubCategoryMenus(level + 1); // 하위 카테고리 초기화
            createSubCategoryMenu(category, level + 1); // 하위 카테고리 메뉴 생성
            updateCategoryInURL(category.categoryId); // URL에 카테고리 반영
            loadBooksByCategory(category.categoryId); // 해당 카테고리 도서 목록 로드
        };

        item.appendChild(link); // 링크를 리스트 항목에 추가
        return item;
    }

    function createSubCategoryMenu(category, level) {
        // 하위 카테고리 메뉴를 생성하는 함수
        if (level > 6) return; // 최대 6단계까지만 생성

        const subMenuContainer = document.createElement('div');
        subMenuContainer.className = 'btn-group';
        subMenuContainer.style.display = 'inline-block';
        subMenuContainer.style.marginLeft = '10px';
        subMenuContainer.id = `subCategoryContainer${level}`; // 하위 카테고리 컨테이너 ID 설정

        if (category.children.length === 0) {
            const subMenuButton = document.createElement('button');
            subMenuButton.type = 'button';
            subMenuButton.className = 'btn btn-secondary'; // 하위 카테고리가 없을 경우 버튼만 표시
            subMenuButton.textContent = category.categoryName;
            subMenuContainer.appendChild(subMenuButton);
        } else {
            const subMenuButton = document.createElement('button');
            subMenuButton.type = 'button';
            subMenuButton.className = 'btn btn-secondary dropdown-toggle'; // 하위 카테고리가 있을 경우 드롭다운 버튼
            subMenuButton.setAttribute('data-toggle', 'dropdown');
            subMenuButton.textContent = category.categoryName;
            subMenuContainer.appendChild(subMenuButton);

            const subMenuList = document.createElement('ul');
            subMenuList.className = 'dropdown-menu'; // 하위 카테고리 리스트

            category.children.forEach(subCategory => {
                const subMenuItem = createCategoryMenuItem(subCategory, level); // 하위 카테고리 항목 생성
                subMenuList.appendChild(subMenuItem); // 하위 카테고리 추가
            });

            subMenuContainer.appendChild(subMenuList); // 하위 카테고리 리스트를 컨테이너에 추가
        }

        document.getElementById('subMenuWrapper').appendChild(subMenuContainer); // 서브메뉴를 메인 메뉴에 추가
    }

    function clearSubCategoryMenus(level) {
        // 지정된 레벨부터 모든 하위 카테고리 메뉴를 제거하는 함수
        for (let i = level; i <= 6; i++) {
            const subMenuToRemove = document.getElementById(`subCategoryContainer${i}`);
            if (subMenuToRemove) {
                subMenuToRemove.remove(); // 하위 카테고리 삭제
            }
        }
    }

    function resetCategories() {
        // 카테고리를 초기 상태로 되돌리는 함수
        clearSubCategoryMenus(1); // 모든 하위 카테고리 메뉴 초기화
        loadCategories(); // 카테고리 다시 로드
        updateMenuTitle('카테고리'); // 메뉴 제목을 '카테고리'로 초기화
        updateCategoryInURL(''); // URL에서 카테고리 정보 제거
        resetBookFilters(); // 도서 필터 초기화
    }

    function updateCategoryInURL(categoryId) {
        isManagePage();

        const currentUrlParams = new URLSearchParams(window.location.search);
        const currentCategory = currentUrlParams.get('category');

        if (currentCategory !== categoryId) {
            updateURLParam('category', categoryId, false);
            // 다른 카테고리인게 확인될 경우 히스토리를 교체하지 않고 추가하는 방식으로 URL에 반영
        } else {
            updateURLParam('category', categoryId, true);
            // 같은 카테고리 내에서 탐색할 경우 뒤로가기를 엄청 눌러야 하기 때문에 히스토리를 replace함
            // 정확한 히스토리 스택은 알 수 없으나, 예를 들어 같은 카테고리 탭에서
            // 페이지를 10곳을 드나들경우 뒤로가기를 10번 눌러야 할 수도 있기 때문에 사용자 경험에서 매우 중요함
        }
    }


    function loadBooksByCategory(categoryId) {
        isManagePage();

        loadPage(1, undefined, '', categoryId);
    }

    function updateMenuTitle(newTitle) {
        // 카테고리 드롭다운 버튼의 제목을 업데이트하는 함수
        const menuButton = document.getElementById('dropdownMenuButton');
        menuButton.textContent = newTitle;
    }

    function updateCategoryUI(categoryId) {
        // 브라우저의 뒤로가기/앞으로가기에서도 리스트가 갱신되도록 서버에 재요청할 계획이었으나, 현재 사용중인 도구로는 불가능함으로 차후 업데이트하는걸로...
    }
});
