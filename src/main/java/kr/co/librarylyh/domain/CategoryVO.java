package kr.co.librarylyh.domain;

import lombok.Data;

@Data
public class CategoryVO {
  private String category_id;   // 카테고리 ID
  private String category_name; // 카테고리 이름
  private String category_level; // 이게 쓸일 있나 싶긴한데 일단 만들어둠
  private String parent_id;     // 상위 카테고리 ID
}
