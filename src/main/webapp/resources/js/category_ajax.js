$(document).ready(function () {

    function saveCategoryDataToSessionStorage(categoryData) {
        sessionStorage.setItem('categoryData', JSON.stringify(categoryData));
    }

    function getCategoryDataFromSessionStorage() {
        const data = sessionStorage.getItem('categoryData');
        return data ? JSON.parse(data) : null;
    }

    // popstate 이벤트 리스너 추가
    window.addEventListener('popstate', function (event) {
        if (event.state) {
            const categoryId = event.state.categoryId ;
            updateCategoryUI(categoryId); // UI를 카테고리에 맞게 업데이트
            loadBooksByCategory(categoryId); // 비동기 요청으로 데이터를 다시 로드
        }
    });
    // 초기화 및 카테고리 로드
    loadCategories();
    // 초기화 버튼 클릭 이벤트
    document.getElementById('resetButton').onclick = function () {
        resetCategories();
    };

    function loadCategories() {
        const categoryData = getCategoryDataFromSessionStorage();

        if (categoryData) {
            buildCategoryDropdown(categoryData);
            console.log('세션 저장소에서 카테고리 데이터를 가져옴.');
        } else {
            $.ajax({
                url: '/categories/list',
                type: 'GET',
                dataType: 'json',
                success: function(categories) {
                    saveCategoryDataToSessionStorage(categories); // 데이터 저장
                    buildCategoryDropdown(categories);
                    console.log('서버에서 카테고리 데이터를 가져옴')
                },
                error: function(xhr, status, error) {
                    console.error('카테고리 데이터를 가져오는데 실패했습니다:', error);
                }
            });
        }
    }

    function buildCategoryDropdown(categories) {
        const dropdownMenu = document.getElementById('categoryDropdownContainer');
        dropdownMenu.innerHTML = '';

        const categoryMap = {};
        categories.forEach(category => {
            categoryMap[category.categoryId ] = category;
            category.children = [];
        });

        categories.forEach(category => {
            if (category.parentId && categoryMap[category.parentId]) {
                categoryMap[category.parentId].children.push(category);
            }
        });

        const topCategories = categories.filter(category => category.categoryName === '국내도서');

        if (topCategories.length > 0) {
            const domesticCategory = topCategories[0];
            const secondLevelCategories = domesticCategory.children || [];

            secondLevelCategories.forEach(category => {
                const menuItem = createCategoryMenuItem(category, 1);
                dropdownMenu.appendChild(menuItem);
            });
        }
    }

    function createCategoryMenuItem(category, level) {
        const item = document.createElement('li');
        item.className = 'dropdown-item';

        const link = document.createElement('div');
        link.textContent = category.categoryName;
        link.style.cursor = 'pointer';
        link.onclick = function () {
            clearSubCategoryMenus(level + 1);
            createSubCategoryMenu(category, level + 1);
            updateCategoryInURL(category.categoryId);
            loadBooksByCategory(category.categoryId);
        };

        item.appendChild(link);
        return item;
    }

    function createSubCategoryMenu(category, level) {
        if (level > 6) return;

        const subMenuContainer = document.createElement('div');
        subMenuContainer.className = 'btn-group';
        subMenuContainer.style.display = 'inline-block';
        subMenuContainer.style.marginLeft = '10px';
        subMenuContainer.id = `subCategoryContainer${level}`;

        if (category.children.length === 0) {
            const subMenuButton = document.createElement('button');
            subMenuButton.type = 'button';
            subMenuButton.className = 'btn btn-secondary';
            subMenuButton.textContent = category.categoryName;
            subMenuContainer.appendChild(subMenuButton);
        } else {
            const subMenuButton = document.createElement('button');
            subMenuButton.type = 'button';
            subMenuButton.className = 'btn btn-secondary dropdown-toggle';
            subMenuButton.setAttribute('data-toggle', 'dropdown');
            subMenuButton.textContent = category.categoryName;
            subMenuContainer.appendChild(subMenuButton);

            const subMenuList = document.createElement('ul');
            subMenuList.className = 'dropdown-menu';

            category.children.forEach(subCategory => {
                const subMenuItem = createCategoryMenuItem(subCategory, level);
                subMenuList.appendChild(subMenuItem);
            });

            subMenuContainer.appendChild(subMenuList);
        }

        document.getElementById('subMenuWrapper').appendChild(subMenuContainer);
    }

    function clearSubCategoryMenus(level) {
        for (let i = level; i <= 6; i++) {
            const subMenuToRemove = document.getElementById(`subCategoryContainer${i}`);
            if (subMenuToRemove) {
                subMenuToRemove.remove();
            }
        }
    }

    function resetCategories() {
        clearSubCategoryMenus(1);
        loadCategories();
        updateMenuTitle('카테고리');
        updateCategoryInURL('');
        resetBookFilters();
    }


    function updateCategoryInURL(categoryId) {
        const currentUrlParams = new URLSearchParams(window.location.search);
        const currentCategory = currentUrlParams.get('category');

        if (currentCategory !== categoryId){
            // 상태를 기록하는 경우에만 pushState 호출
            updateURLParam('category', categoryId, false);
        }

        updateURLParam('category', categoryId);
    }

    function loadBooksByCategory(categoryId) {
        loadPage(1, undefined, '', categoryId);
    }

    function updateMenuTitle(newTitle) {
        const menuButton = document.getElementById('dropdownMenuButton');
        menuButton.textContent = newTitle;
    }
    function updateCategoryUI(categoryId){
        // 현재 URI의 카테고리에 맞게 UI 업데이트하는 로직 만들 예정
        // (뒤로가기 앞으로가기에도 리스트가 갱신되어 보이게끔)
        // 캐싱 구현은 아직 잘 모르겠으니 그냥 popstate 로 서버에 재요청 하는 방식을 쓸듯
    }
});