package kr.co.librarylyh.controller;

import java.util.List;
import kr.co.librarylyh.domain.CategoryPreferenceDTO;
import kr.co.librarylyh.service.CategoryPreferenceService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Log4j2
@RestController
@RequestMapping("/ajax/preferences")
public class CategoryPreferenceRestController {

  @Autowired
  private CategoryPreferenceService categoryPreferenceService;

  // 특정 유저 선호도 조회
  @GetMapping(value = "/user/{id}", produces = "application/json")
  public List<CategoryPreferenceDTO> getAllPreferencesByUser(@PathVariable("id") String id) {

    log.info("특정 유저 선호도 조회 : {}", id);

    List<CategoryPreferenceDTO> preferences = categoryPreferenceService.getAllPreferencesByUser(id);

    log.info("선호도 데이터 조회 결과: {}", preferences);

    return preferences;
  }

  // 새로운 선호도 데이터 추가
  @PostMapping("/")
  public void insertOrUpdatePreference(@RequestBody CategoryPreferenceDTO preference) {
    log.info("선호도 데이터 추가 / 업데이트 : {}", preference);

    categoryPreferenceService.insertOrUpdatePreference(preference);

    log.info("선호도 데이터 추가 / 업데이트 완료 - CategoryId: {}, Score: {}", preference.getCategoryId(),
        preference.getPreferenceScore());
  }

  // 특정 유저의 선호도 삭제
  @DeleteMapping("/user/{id}")
  public void deletePreference(@PathVariable("id") String id) {

    log.info("특정 유저 선호도 데이터 삭제 - id: {}", id);

    categoryPreferenceService.deletePreference(id);
  }

  // 전체 유저의 모든 카테고리 선호도 조회 (관리자용)
  @GetMapping("/all")
  public List<CategoryPreferenceDTO> getAllPreferences() {

    log.info("전체 유저 선호도 조회 시작");

    List<CategoryPreferenceDTO> preferences = categoryPreferenceService.getAllPreferences();

    log.info("전체 유저 선호도 조회 완료 : {}", preferences);

    return preferences;
  }
}