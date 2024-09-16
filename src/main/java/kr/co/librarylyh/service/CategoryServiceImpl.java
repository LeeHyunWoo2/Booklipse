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
    log.info("카테 getCategoryPath" + category);
    return categoryMapper.getCategoryPath(category);
  }

  @Override
  public List<CategoryVO> getAllCategories() {
    log.info("카테 getAllCategories" + categoryMapper.getAllCategories());
    return categoryMapper.getAllCategories();
  }

  @Override
  public List<CategoryVO> getSubCategories(CategoryVO category) {
    log.info("카테 getSubCategories" + category);
    return categoryMapper.getSubCategories(category);
  }
}