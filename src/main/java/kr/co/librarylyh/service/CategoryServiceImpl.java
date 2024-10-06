package kr.co.librarylyh.service;

import java.util.List;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.librarylyh.domain.CategoryVO;
import kr.co.librarylyh.mapper.CategoryMapper;
import lombok.Setter;

@Log4j2
@Service
public class CategoryServiceImpl implements CategoryService {

  @Setter(onMethod_ = @Autowired)
  private CategoryMapper categoryMapper;

  @Override
  public List<CategoryVO> getCategoryPath(String category) {
    log.info("카테고리 경로 조회{}", category);
    return categoryMapper.getCategoryPath(category);
  }

  @Override
  public List<CategoryVO> getAllCategories() {
    log.info("모든 카테고리 조회{}", categoryMapper.getAllCategories());
    return categoryMapper.getAllCategories();
  }
}