package kr.co.librarylyh.service;

import java.util.List;
import kr.co.librarylyh.domain.CategoryPreferenceDTO;


public interface CategoryPreferenceService {

  List<CategoryPreferenceDTO> getAllPreferencesByUser(String id);

  void insertOrUpdatePreference(CategoryPreferenceDTO preference);

  void deletePreference(String id);

  List<CategoryPreferenceDTO> getAllPreferences();

}
