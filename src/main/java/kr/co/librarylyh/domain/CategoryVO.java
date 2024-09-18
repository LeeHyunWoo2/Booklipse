package kr.co.librarylyh.domain;

import lombok.Data;

@Data
public class CategoryVO {
  private String categoryId;   // 카테고리 ID
  private String categoryName; // 카테고리 이름
  private String categoryLevel; // 카테고리 레벨
  private String parentId;     // 상위 카테고리 ID
}
