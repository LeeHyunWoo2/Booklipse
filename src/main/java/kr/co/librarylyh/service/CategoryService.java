package kr.co.librarylyh.service;

import java.util.List;
import kr.co.librarylyh.domain.CategoryVO;

public interface CategoryService {
  // 카테고리 경로를 가져오는 메서드
  List<CategoryVO> getCategoryPath(String category);

  // 모든 카테고리 목록을 가져오는 메서드
  List<CategoryVO> getAllCategories();

  List<CategoryVO> getSubCategories(CategoryVO category);
}