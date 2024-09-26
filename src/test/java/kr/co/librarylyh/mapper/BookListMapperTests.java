package kr.co.librarylyh.mapper;

import java.util.Arrays;
import java.util.stream.Collectors;
import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.CategoryVO;
import lombok.extern.log4j.Log4j2;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

@Log4j2
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BookListMapperTests {


  private BookListMapper mapper;

  private BookListVO testBook;

  @Before
  public void setUp() {
    testBook = new BookListVO();
    testBook.setIsbn13(1234567890123L);
    testBook.setBook("테스트 책 제목");
    testBook.setAuthor("테스트 저자");
    testBook.setPublisher("테스트 출판사");
    testBook.setPrice(10000);
    testBook.setRentalAvailable("Y");
    testBook.setPhoto("test_photo.jpg");
    testBook.setBookDescription("테스트 책의 설명");
    testBook.setPageCount(300);
    testBook.setWeight("100kg");
    testBook.setBookSize("100M");
    testBook.setBookCount(5);
    testBook.setAverageRating(4.5);
    testBook.setStar5Count("50%");
    testBook.setStar4Count("20%");
    testBook.setStar3Count("15%");
    testBook.setStar2Count("10%");
    testBook.setStar1Count("5%");
    testBook.setReviewCount(185);
    testBook.setPublicationDate(LocalDate.parse("2000-02-02"));
    List<CategoryVO> categoryList = Arrays.asList(
        new CategoryVO("1001"),
        new CategoryVO("1002"),
        new CategoryVO("1003")
    );
    testBook.setCategories(categoryList);
  }
  // CategoryVO 리스트에서 categoryId만 추출하여 String 리스트로 변환
  List<String> categoryIds = testBook.getCategories().stream()
      .map(CategoryVO::getCategoryId)
      .collect(Collectors.toList());

  @Test
  public void testInsert() {
    log.info("매퍼 책 추가 테스트 시작");
    mapper.insertBook(testBook);
    mapper.insertBookDetail(testBook);
    mapper.insertBookCategories(testBook.getIsbn13(), categoryIds);
    BookListVO result = mapper.read(testBook.getIsbn13());
    assertNotNull(result);
    log.info("매퍼 책 추가 테스트 종료");
  }

  @Test
  public void testRead() {
    log.info("매퍼 책 조회 테스트 시작");
    BookListVO result = mapper.read(testBook.getIsbn13());
    assertNotNull(result);
    assertEquals("테스트 책 제목", result.getBook());
    log.info("매퍼 책 조회 테스트 종료");
  }

  @Test
  public void testUpdate() {
    log.info("매퍼 책 수정 테스트 시작");
    testBook.setBook("수정된 책 제목");
    int updated = mapper.update(testBook);
    assertEquals(1, updated);
    BookListVO result = mapper.read(testBook.getIsbn13());
    assertEquals("수정된 책 제목", result.getBook());
    log.info("매퍼 책 수정 테스트 종료");
  }

  @Test
  public void testDelete() {
    log.info("매퍼 책 삭제 테스트 시작");
    int deleted = mapper.delete(testBook.getIsbn13());
    assertEquals(1, deleted);
    BookListVO result = mapper.read(testBook.getIsbn13());
    assertNull(result);
    log.info("매퍼 책 삭제 테스트 종료");
  }

}
