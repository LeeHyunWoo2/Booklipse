package kr.co.librarylyh.controller;

import java.util.List;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import kr.co.librarylyh.domain.CategoryVO;
import kr.co.librarylyh.service.CategoryService;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/categories")
@RequiredArgsConstructor
@Log4j2
public class CategoryController {
  // 카테고리 컨트롤러쪽은 카테고리 이름표기 등등 여러 정보를 포함할거라서 category 라는 매개변수를 사용할것임

  private final CategoryService categoryService;

  // 전체 카테고리 목록 조회
  @GetMapping("/list")
  public ResponseEntity<List<CategoryVO>> getAllCategories() {
    try {
      log.info("전체 카테고리 조회");
      List<CategoryVO> categories = categoryService.getAllCategories();
      log.info("전체 카테고리 총 {}개", categories.size());

      return new ResponseEntity<>(categories, HttpStatus.OK);
    } catch (Exception e) {
      log.error(e.getMessage());
      return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  // 특정 카테고리의 경로 조회
  @GetMapping("/path")
  public ResponseEntity<List<CategoryVO>> getCategoryPath(@RequestParam("category") String category) {
    try {
      log.info("경로 조회 카테고리명: {}", category);
      List<CategoryVO> categoryPath = categoryService.getCategoryPath(category);

      if (categoryPath.isEmpty()) {
        log.warn("경로 조회 결과 없음 - 카테고리명: {}", category);
        return new ResponseEntity<>(categoryPath, HttpStatus.NOT_FOUND);
      }

      log.info("경로 조회 결과 - 카테고리명: {}, 경로 개수: {}", category, categoryPath.size());
      return new ResponseEntity<>(categoryPath, HttpStatus.OK);
    } catch (Exception e) {
      log.error(e.getMessage());
      return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
}