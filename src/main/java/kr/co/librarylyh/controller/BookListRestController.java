package kr.co.librarylyh.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
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
import org.springframework.web.multipart.MultipartFile;

@RestController
@Log4j2
@RequestMapping("/ajax")
@AllArgsConstructor
public class BookListRestController {

  private final BookListService service;

  // 책 목록 조회 (페이징 및 필터 적용)
  @GetMapping(value = "/booklist", produces = {MediaType.APPLICATION_JSON_VALUE})
  public ResponseEntity<ListPageDTO> getBookList(
      @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
      @RequestParam(value = "amount", defaultValue = "10") int amount,
      @RequestParam(value = "categoryId", required = false) String categoryId,
      @RequestParam(value = "rentalAvailable", required = false) String rentalAvailable,
      @RequestParam(value = "publicationDateFilter", required = false) String publicationDateFilter,
      @RequestParam(value = "searchQuery", required = false) String searchQuery,
      @RequestParam(value = "sort", defaultValue = "b.publicationDate DESC") String sort) {

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

  @GetMapping(value = "/searchTitles", produces = {MediaType.APPLICATION_JSON_VALUE})
  public List<BookListVO> searchTitles(@RequestParam("query") String query) {
    log.info("AJAX 요청 - 검색어: {}", query);
    List<BookListVO> result = service.searchTitles(query);
    log.info("AJAX 응답 - 검색 결과: {}", result);
    return result;
  }

  // 책의 카테고리 ID 목록 제공
  @GetMapping(value = "/getBookCategoryIds", produces = {MediaType.APPLICATION_JSON_VALUE})
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

  @PostMapping("/book/add")
  public ResponseEntity<String> addBook(
      @RequestParam("bookData") String bookData,
      @RequestParam("imageUploadType") String imageUploadType,
      @RequestParam(value = "photoUrl", required = false) String photoUrl,
      @RequestParam(value = "file", required = false) MultipartFile file) {

    try {
      ObjectMapper objectMapper = new ObjectMapper();
      objectMapper.registerModule(new JavaTimeModule());

      // JSON을 VO로 변환
      BookListVO bookListVO = objectMapper.readValue(bookData, BookListVO.class);

      // 업로드 방식에 따라 photo 필드 처리
      if ("url".equals(imageUploadType) && photoUrl != null) {
        // URL 방식으로 이미지 처리
        bookListVO.setPhoto(photoUrl);
      } else if ("file".equals(imageUploadType) && file != null) {
        // 파일 업로드 방식으로 이미지 처리
        String savedFileName = handleFileUpload(file);  // 파일 저장 후 저장된 파일명 가져옴
        bookListVO.setPhoto(savedFileName);
      }

      long isbn13 = Long.parseLong(String.valueOf(bookListVO.getIsbn13()));
      bookListVO.setIsbn13(isbn13);
      log.info(isbn13);


      // 책 정보 추가
      service.add(bookListVO);
      return new ResponseEntity<>("success", HttpStatus.CREATED);

    } catch (Exception e) {
      e.printStackTrace();
      return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
    }
  }

  // 책 수정
  @PutMapping("/book/{isbn13}")
  public ResponseEntity<String> modifyBook(@PathVariable("isbn13") Long isbn13,
      @RequestParam("bookData") String bookData,
      @RequestParam(value = "file", required = false) MultipartFile file) {
    try {
      // 기존 책 정보 로드
      BookListVO currentBook = service.get(isbn13);

      // 수정된 책 정보 변환
      BookListVO updatedBook = new ObjectMapper().readValue(bookData, BookListVO.class);

      // 파일 처리 (새 파일이 있을 경우)
      if (file != null && !file.isEmpty()) {
        String savedFileName = handleFileUpload(file);
        updatedBook.setPhoto(savedFileName);  // 새 이미지 파일 이름 설정
      } else {
        updatedBook.setPhoto(currentBook.getPhoto());  // 기존 파일 이름 유지
      }

      // 책 정보 수정
      service.modify(updatedBook);
      return new ResponseEntity<>("success", HttpStatus.OK);
    } catch (Exception e) {
      e.printStackTrace();
      return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
    }
  }

  // 책 삭제
  @DeleteMapping("/book/{isbn13}")
  public ResponseEntity<String> removeBook(@PathVariable("isbn13") Long isbn13) {
    try {
      service.remove(isbn13);
      return new ResponseEntity<>("success", HttpStatus.NO_CONTENT);
    } catch (Exception e) {
      return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
    }
  }

  private String handleFileUpload(MultipartFile file) throws IOException {
    String originalFileName = file.getOriginalFilename();
    String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
    String savedFileName = UUID.randomUUID() + fileExtension;

    String uploadDir = "D:/upload/books";  // 파일 저장 경로
    File saveFile = new File(uploadDir + savedFileName);
    file.transferTo(saveFile);  // 파일 저장

    return savedFileName;  // 저장된 파일 이름 반환
  }

}
