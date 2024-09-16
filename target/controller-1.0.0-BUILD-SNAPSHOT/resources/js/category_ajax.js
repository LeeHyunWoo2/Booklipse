$(document).ready(function () {
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
            categoryMap[category.category_id] = category;
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
        link.style.padding = '8px 16px';
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
        loadBooksByCategory('');
    }

    function updateCategoryInURL(categoryId) {
        const newURL = categoryId ? `${window.location.pathname}?category=${categoryId}` : window.location.pathname;
        window.history.pushState({ path: newURL }, '', newURL);
    }

    function loadBooksByCategory(categoryId) {
        loadPage(1, undefined, '', categoryId);
    }

    function updateMenuTitle(newTitle) {
        const menuButton = document.getElementById('dropdownMenuButton');
        menuButton.textContent = newTitle;
    }
});
