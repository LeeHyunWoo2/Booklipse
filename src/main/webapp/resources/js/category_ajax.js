$(document).ready(function () {
    // popstate 이벤트 리스너 추가
    window.addEventListener('popstate', function (event) {
        if (event.state) {
            const category_id = event.state.category_id ;
            updateCategoryUI(category_id); // UI를 카테고리에 맞게 업데이트
            loadBooksByCategory(category_id); // 비동기 요청으로 데이터를 다시 로드
        }
    });
    // 초기화 및 카테고리 로드
    loadCategories();
    // 초기화 버튼 클릭 이벤트
    document.getElementById('resetButton').onclick = function () {
        resetCategories();
    };

    function loadCategories() {
        $.ajax({
            url: '/categories/list',
            type: 'GET',
            dataType: 'json',
            success: function (categories) {
                buildCategoryDropdown(categories);
            },
            error: function (xhr, status, error) {
                console.error('카테고리 데이터를 가져오는데 실패했습니다:', error);
            }
        });
    }

    function buildCategoryDropdown(categories) {
        const dropdownMenu = document.getElementById('categoryDropdownContainer');
        dropdownMenu.innerHTML = '';

        const categoryMap = {};
        categories.forEach(category => {
            categoryMap[category.category_id ] = category;
            category.children = [];
        });

        categories.forEach(category => {
            if (category.parent_id && categoryMap[category.parent_id]) {
                categoryMap[category.parent_id].children.push(category);
            }
        });

        const topCategories = categories.filter(category => category.category_name === '국내도서');

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
        link.textContent = category.category_name;
        link.style.cursor = 'pointer';
        link.onclick = function () {
            clearSubCategoryMenus(level + 1);
            createSubCategoryMenu(category, level + 1);
            updateCategoryInURL(category.category_id);
            loadBooksByCategory(category.category_id);
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
            subMenuButton.textContent = category.category_name;
            subMenuContainer.appendChild(subMenuButton);
        } else {
            const subMenuButton = document.createElement('button');
            subMenuButton.type = 'button';
            subMenuButton.className = 'btn btn-secondary dropdown-toggle';
            subMenuButton.setAttribute('data-toggle', 'dropdown');
            subMenuButton.textContent = category.category_name;
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


    function updateCategoryInURL(category_id) {
        const currentUrlParams = new URLSearchParams(window.location.search);
        const currentCategory = currentUrlParams.get('category');

        if (currentCategory !== category_id){
            // 상태를 기록하는 경우에만 pushState 호출
            updateURLParam('category', category_id, false);
        }

        updateURLParam('category', category_id);
    }

    function loadBooksByCategory(category_id) {
        loadPage(1, undefined, '', category_id);
    }

    function updateMenuTitle(newTitle) {
        const menuButton = document.getElementById('dropdownMenuButton');
        menuButton.textContent = newTitle;
    }
    function updateCategoryUI(category_id){
        // 현재 URI의 카테고리에 맞게 UI 업데이트하는 로직 만들 예정
        // (뒤로가기 앞으로가기에도 리스트가 갱신되어 보이게끔)
        // 캐싱 구현은 아직 잘 모르겠으니 그냥 popstate 로 서버에 재요청 하는 방식을 쓸듯
    }
});