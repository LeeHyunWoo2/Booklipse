package kr.co.librarylyh.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 모든 필드를 포함하는 생성자
public class CategoryVO {
  private String categoryId;   // 카테고리 ID
  private String categoryName; // 카테고리 이름
  private String categoryLevel; // 카테고리 레벨
  private String parentId;     // 상위 카테고리 ID

  // 문자열을 받아서 categoryId를 설정하는 생성자 추가
  public CategoryVO(String categoryId) {
    this.categoryId = categoryId;
  }

}
