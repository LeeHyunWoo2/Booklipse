package kr.co.librarylyh.domain;

import java.util.Date;
import lombok.Data;

@Data
public class CategoryPreferenceDTO {
  private String id;
  private Long categoryId;
  private int categoryLevel;          // 카테고리 레벨 (1 = 최상위, 2 = 2차 카테고리)
  private String categoryName;
  private double preferenceScore;     // 선호도 점수
  private Date updatedAt;             // 마지막 업데이트 시점
}
