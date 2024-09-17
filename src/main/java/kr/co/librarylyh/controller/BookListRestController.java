package kr.co.librarylyh.controller;

import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.PageDTO;
import kr.co.librarylyh.domain.Paging;
import kr.co.librarylyh.service.BookListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Log4j2
@RequestMapping("/ajax")
@AllArgsConstructor
public class BookListRestController {

  private final BookListService service;

  // 책 목록 조회 (페이징 및 필터 적용)
  @GetMapping(value = "/booklist", produces = { MediaType.APPLICATION_JSON_VALUE })
  public ResponseEntity<PageDTO> getBookList(
      @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
      @RequestParam(value = "amount", defaultValue = "10") int amount,
      @RequestParam(value = "category_id", required = false) String category_id,
      @RequestParam(value = "rentalAvailable", required = false) String rentalAvailable,
      @RequestParam(value = "publicationDateFilter", required = false) String publicationDateFilter,
      @RequestParam(value = "searchQuery", required = false) String searchQuery,
      @RequestParam(value = "sort", defaultValue = "b.publication_date DESC") String sort) { // 정렬 옵션 추가


    // 페이징 객체 생성
    Paging pge = new Paging(pageNum, amount);

    // 검색 조건들을 맵으로 전달
    Map<String, Object> searchParams = new HashMap<>();
    searchParams.put("category_id", category_id);
    searchParams.put("rentalAvailable", rentalAvailable);
    searchParams.put("publicationDateFilter", publicationDateFilter);
    searchParams.put("searchQuery", searchQuery);
    searchParams.put("sort", sort); // 정렬 옵션 추가

    // 서비스 호출
    List<BookListVO> list = service.getListWithFiltersAndPaging(pge, searchParams);
    int total = service.getTotal(searchParams);

    // 페이지 정보 객체 생성
    PageDTO pageDTO = new PageDTO(pge, total, list);

    return new ResponseEntity<>(pageDTO, HttpStatus.OK);
  }

  @GetMapping("/{isbn13}")
  public ResponseEntity<BookListVO> getBookInfo(@PathVariable("isbn13") long isbn13) {
    BookListVO bookDetail = service.get(isbn13);
    return ResponseEntity.ok(bookDetail);
  }

  // 책 추가 (모달을 통해 처리)
  @PostMapping(produces = { MediaType.APPLICATION_JSON_VALUE })
  public ResponseEntity<String> addBook(@RequestBody BookListVO bookList) {
    service.add(bookList); // 책 추가 처리
    return new ResponseEntity<>("success", HttpStatus.CREATED);
  }

  // 책 수정
  @PutMapping(value = "/{isbn13}", produces = { MediaType.APPLICATION_JSON_VALUE })
  public ResponseEntity<String> modifyBook(@PathVariable("isbn13") Long isbn13, @RequestBody BookListVO bookList) {
    bookList.setIsbn13(isbn13); // 책 수정시 isbn13 설정
    if (service.modify(bookList)) {
      return new ResponseEntity<>("success", HttpStatus.OK);
    } else {
      return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
    }
  }

  // 책 삭제
  @DeleteMapping(value = "/{isbn13}", produces = { MediaType.APPLICATION_JSON_VALUE })
  public ResponseEntity<String> removeBook(@PathVariable("isbn13") Long isbn13) {
    if (service.remove(isbn13)) {
      return new ResponseEntity<>("success", HttpStatus.NO_CONTENT);
    } else {
      return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
    }
  }
}