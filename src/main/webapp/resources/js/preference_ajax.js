// 특정 카테고리 클릭 시 선호도 업데이트 함수
function updatePreferenceOnCategoryClick(categoryId, categoryName,
    categoryLevel, score) {
  if (categoryLevel !== 2 && categoryLevel !== 3) {
    return;
  }
  // 선호도 데이터를 생성
  const preference = {
    id: 'test123',
    categoryId: categoryId,
    categoryName: categoryName,
    categoryLevel: categoryLevel,
    preferenceScore: score
  };
  // 기존 선호도 데이터 업데이트 또는 삽입
  fetch(`/ajax/preferences/`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(preference)
  })
  .then(response => response.text())
  .then(data => {
  })
  .catch(error => console.error("선호도 업데이트 실패!!!!!!!!:", error));
}

// 버튼과 입력 필드 참조
const userIdInput = document.getElementById('userIdInput');
const getPreferencesButton = document.getElementById('getPreferencesButton');
const preferencesOutput = document.getElementById('preferencesOutput');

// 버튼 클릭 이벤트 리스너 설정
getPreferencesButton.addEventListener('click', () => {
  const userId = userIdInput.value.trim(); // 입력값 가져오기 및 공백 제거

  if (!userId) {
    alert("유저 ID를 입력해주세요.");
    return;
  }

// 선호도 데이터 조회
  fetch(`/ajax/preferences/user/${userId}`, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => response.json()) // JSON 형태로 변환
  .then(data => {
    if (data.length === 0) {
      preferencesOutput.innerHTML = `<p>해당 유저의 선호도 정보가 없습니다.</p>`;
      return;
    }

    // 1. 카테고리 레벨 2의 항목만 선별
    const level2Preferences = data.filter(item => item.categoryLevel === 2);

    // 2. 카테고리 레벨 2의 항목 중 점수 순으로 정렬하여 상위 3개 추출
    const topLevel2Preferences = level2Preferences
    .sort((a, b) => b.preferenceScore - a.preferenceScore)
    .slice(0, 3); // 상위 3개만 추출

    // 3. 각 상위 3개 레벨 2 카테고리의 하위 카테고리 (레벨 3) 추출 및 빈 항목 추가
    const topPreferencesWithSubCategories = topLevel2Preferences.map(level2 => {
      // 레벨 3의 항목을 해당 레벨 2 ID를 포함하는 항목만 필터링
      const level3Preferences = data.filter(
          item => item.categoryLevel === 3 && item.categoryId.toString().startsWith(level2.categoryId.toString())
      );

      // 레벨 3 카테고리 중 점수 순으로 정렬하여 상위 3개만 선택
      const topLevel3Preferences = level3Preferences
      .sort((a, b) => b.preferenceScore - a.preferenceScore)
      .slice(0, 3);

      // 3개보다 적을 경우, 빈 항목을 채워서 3개로 맞춤
      while (topLevel3Preferences.length < 3) {
        topLevel3Preferences.push({ categoryName: "빈 항목", preferenceScore: "-" });
      }

      return {
        ...level2,
        subCategories: topLevel3Preferences
      };
    });

    // 4. 아코디언 HTML 구조 생성 - 모든 collapse가 펼쳐진 상태로 설정
    let accordionHTML = `
      <div class="accordion" id="accordionExample">
    `;

    // 아코디언 카드 생성 - 각 collapse에 `show` 클래스 추가하여 기본적으로 열림 상태로 설정
    topPreferencesWithSubCategories.forEach((category, index) => {
      const categoryId = `collapse${index + 1}`;
      accordionHTML += `
        <div class="card">
          <div class="card-header" id="heading${index + 1}">
            <h2 class="mb-0">
              <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#${categoryId}" 
                      aria-expanded="true" aria-controls="${categoryId}">
                ${category.categoryName} (점수 : ${category.preferenceScore}) 최근 활동 : ${formatTimeStamp(category.updatedAt)}
              </button>
            </h2>
          </div>

          <div id="${categoryId}" class="collapse show" aria-labelledby="heading${index + 1}">
            <div class="card-body">
              ${category.subCategories.map(subCategory => `
                <div style="padding: 10px; color: ${subCategory.categoryName === "빈 항목" ? '#aaa' : '#000'}">
                  <strong>${subCategory.categoryName}</strong> ${subCategory.categoryName === "빈 항목" ? '' : `(점수 : ${subCategory.preferenceScore})`}
                </div>
              `).join('')}
            </div>
          </div>
        </div>
      `;
    });

    // 아코디언 종료 태그 추가
    accordionHTML += `</div>`;

    // 5. 결과를 출력
    preferencesOutput.innerHTML = accordionHTML;
  })
  .catch(error => {
    console.error("유저 선호도 조회 실패:", error);
    alert("유저 선호도 조회 중 오류가 발생했습니다.");
  });


  function formatTimeStamp(timestamp) {
    const date = new Date(Number(timestamp));

    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 0~11로 반환하므로 +1
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');

    const fewTimesAgo = new Date() - date;
    const fewDaysAgo = Math.floor(fewTimesAgo / (1000));

    // yyyy-MM-dd HH:mm:ss
    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds} (${fewDaysAgo}초 전)`;
  }
});

