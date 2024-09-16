package kr.co.librarylyh.controller;

import java.util.List;
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
public class CategoryController {
  // 카테고리 컨트롤러쪽은 카테고리 이름표기 등등 여러 정보를 포함할거라서 category 라는 매개변수를 사용할것임

  private final CategoryService categoryService;

  @GetMapping("/list")
  public ResponseEntity<List<CategoryVO>> getAllCategories() {
    List<CategoryVO> categories = categoryService.getAllCategories();
    return new ResponseEntity<>(categories, HttpStatus.OK);
  }

  @GetMapping("/path")
  public ResponseEntity<List<CategoryVO>> getCategoryPath(@RequestParam("category") String category) {
    List<CategoryVO> categoryPath = categoryService.getCategoryPath(category);
    return new ResponseEntity<>(categoryPath, HttpStatus.OK);
  }
}