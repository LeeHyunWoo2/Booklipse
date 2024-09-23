package kr.co.librarylyh.controller;

import java.util.stream.Collectors;
import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.CategoryVO;
import kr.co.librarylyh.domain.ListPageDTO;
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
  public ResponseEntity<ListPageDTO> getBookList(
      @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
      @RequestParam(value = "amount", defaultValue = "10") int amount,
      @RequestParam(value = "categoryId", required = false) String categoryId,
      @RequestParam(value = "rentalAvailable", required = false) String rentalAvailable,
      @RequestParam(value = "publicationDateFilter", required = false) String publicationDateFilter,
      @RequestParam(value = "searchQuery", required = false) String searchQuery,
      @RequestParam(value = "sort", defaultValue = "b.publicationDate DESC") String sort) { // 정렬 옵션 추가


    // 페이징 객체 생성
    Paging pge = new Paging(pageNum, amount);

    // 검색 조건들을 맵으로 전달
    Map<String, Object> searchParams = new HashMap<>();
    searchParams.put("categoryId", categoryId);
    searchParams.put("rentalAvailable", rentalAvailable);
    searchParams.put("publicationDateFilter", publicationDateFilter);
    searchParams.put("searchQuery", searchQuery);
    searchParams.put("sort", sort); // 정렬 옵션 추가

    // 서비스 호출
    List<BookListVO> list = service.getListWithFiltersAndPaging(pge, searchParams);
    int total = service.getTotal(searchParams);

    // 페이지 정보 객체 생성
    ListPageDTO listPageDTO = new ListPageDTO(pge, total, list);

    return new ResponseEntity<>(listPageDTO, HttpStatus.OK);
  }

  @GetMapping(value = "/searchTitles", produces = { MediaType.APPLICATION_JSON_VALUE })
  public List<BookListVO> searchTitles(@RequestParam("query")String query){
    log.info("AJAX 요청 - 검색어: {}", query);
    List<BookListVO>result = service.searchTitles(query);
    log.info("AJAX 응답 - 검색 결과: {}", result);
    return result;
  }

  // 책의 카테고리 ID 목록 제공
  @GetMapping(value = "/getBookCategoryIds", produces = { MediaType.APPLICATION_JSON_VALUE })
  public ResponseEntity<List<String>> getBookCategoryIds(@RequestParam("isbn13") Long isbn13) {
    try {
      // 책의 카테고리 ID 목록을 가져오기
      List<String> categoryIds = service.getCategoriesByISBN(isbn13)
          .stream()
          .map(CategoryVO::getCategoryId) // CategoryVO에서 ID만 추출
          .collect(Collectors.toList());

      // 카테고리 ID 목록을 클라이언트에 전달
      return ResponseEntity.ok(categoryIds);
    } catch (Exception e) {
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }
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