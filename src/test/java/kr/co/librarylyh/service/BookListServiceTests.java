package kr.co.librarylyh.service;

import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.mapper.BookListMapper;
import lombok.extern.log4j.Log4j2;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.ui.Model;

import java.time.LocalDate;
import java.util.List;

import static org.junit.Assert.*;

@Log4j2
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BookListServiceTests {

  @Autowired
  private BookListService bookListService;

  private BookListVO testBook;

  @Before
  public void setUp() {
    // 테스트용 책 객체 생성
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
  }

  @Test
  public void testAddBook() {
    log.info("책 추가 테스트 시작");
    bookListService.add(testBook);
    BookListVO result = bookListService.get(testBook.getIsbn13());
    assertNotNull(result);
    assertEquals("테스트 책 제목", result.getBook());
    log.info("책 추가 테스트 종료");
  }

  @Test
  public void testModifyBook() {
    log.info("책 수정 테스트 시작");
    testBook.setBook("수정된 책 제목");
    boolean isUpdated = bookListService.modify(testBook);
    assertTrue(isUpdated);
    BookListVO result = bookListService.get(testBook.getIsbn13());
    assertEquals("수정된 책 제목", result.getBook());
    log.info("책 수정 테스트 종료");
  }

  @Test
  public void testRemoveBook() {
    log.info("책 삭제 테스트 시작");
    boolean isRemoved = bookListService.remove(testBook.getIsbn13());
    assertTrue(isRemoved);
    assertNull(bookListService.get(testBook.getIsbn13()));
    log.info("책 삭제 테스트 종료");
  }
}
