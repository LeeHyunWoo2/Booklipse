package kr.co.librarylyh.service;
import java.util.List;
import kr.co.librarylyh.domain.CategoryPreferenceDTO;
import kr.co.librarylyh.mapper.CategoryPreferenceMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Log4j2
@Service
public class CategoryPreferenceServiceImpl implements CategoryPreferenceService {

  // Mapper 주입
  @Setter(onMethod_ = @Autowired)
  private CategoryPreferenceMapper categoryPreferenceMapper;

  @Override
  public List<CategoryPreferenceDTO> getAllPreferencesByUser(String id) {
    // 입력 파라미터 확인 (서비스 실행 전)
    log.info("[getAllPreferencesByUser] Input - id: {}", id);

    // 매퍼 호출 (서비스 로직 실행)
    List<CategoryPreferenceDTO> preferences = categoryPreferenceMapper.getAllPreferencesByUser(id);

    // 결과 값 확인 (서비스 실행 후)
    log.info("[getAllPreferencesByUser] Result - Preferences: {}", preferences);

    return preferences;
  }

  @Transactional
  @Override
  public void insertOrUpdatePreference(CategoryPreferenceDTO preference) {
    // 입력 파라미터 확인 (서비스 실행 전)
    log.info("[insertPreference] Input - Preference: {}", preference);

    // 매퍼 호출 (서비스 로직 실행)
    categoryPreferenceMapper.insertOrUpdatePreference(preference);

    // 서비스 실행 후 확인 메시지
    log.info("[insertPreference] Inserted Successfully - CategoryId: {}, Score: {}",
        preference.getCategoryId(), preference.getPreferenceScore());
  }


  @Override
  public void deletePreference(String id) {
    // 입력 파라미터 확인 (서비스 실행 전)
    log.info("[deletePreference] Input - id: {}", id);

    // 매퍼 호출 (서비스 로직 실행)
    categoryPreferenceMapper.deletePreference(id);
  }

  @Override
  public List<CategoryPreferenceDTO> getAllPreferences() {
    // 매퍼 호출 전 메시지
    log.info("[getAllPreferences] Retrieving All Preferences");

    // 매퍼 호출 (서비스 로직 실행)
    List<CategoryPreferenceDTO> preferences = categoryPreferenceMapper.getAllPreferences();

    // 결과 값 확인 (서비스 실행 후)
    log.info("[getAllPreferences] Result - All Preferences: {}", preferences);

    return preferences;
  }
}