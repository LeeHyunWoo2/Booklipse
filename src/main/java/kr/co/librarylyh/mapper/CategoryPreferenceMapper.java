package kr.co.librarylyh.mapper;

import java.util.List;
import kr.co.librarylyh.domain.CategoryPreferenceDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CategoryPreferenceMapper {

  // 유저의 선호도 정보 가져오기
  List<CategoryPreferenceDTO> getAllPreferencesByUser(@Param("id") String id);

  // 선호도 점수 삽입 혹은 갱신
  void insertOrUpdatePreference(CategoryPreferenceDTO preference);

  // 카테고리의 선호도 삭제
  void deletePreference(@Param("id") String id);

  // 전체 선호도 데이터 조회 (관리자용)
  List<CategoryPreferenceDTO> getAllPreferences();

}
