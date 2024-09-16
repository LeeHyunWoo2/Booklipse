package kr.co.librarylyh.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import kr.co.librarylyh.domain.CategoryVO;

@Mapper
public interface CategoryMapper {

  // 특정 카테고리의 경로 조회
  List<CategoryVO> getCategoryPath(String category);

  // 모든 카테고리 목록 조회
  List<CategoryVO> getAllCategories();

  List<CategoryVO> getSubCategories(CategoryVO category);
}