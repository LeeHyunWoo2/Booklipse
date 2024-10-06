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
import kr.co.librarylyh.mapper.BookListMapper;
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
  private BookListMapper mapper; // 매퍼 인터페이스 직접 주입(비즈니스 로직이 아닌게 있어서 매퍼로 직행하기 위해 만듦)

  // 책 목록 조회 (페이징 및 필터 적용)
  @GetMapping(value = "/booklist", produces = {MediaType.APPLICATION_JSON_VALUE})
  public ResponseEntity<ListPageDTO> getBookList(
      @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
      @RequestParam(value = "amount", defaultValue = "10") int amount,
      @RequestParam(value = "categoryId", required = false) String categoryId,
      @RequestParam(value = "searchQuery", required = false) String searchQuery,
      @RequestParam(value = "sort", defaultValue = "b.publicationDate DESC") String sort) {

    // 페이징 객체 생성
    Paging pge = new Paging(pageNum, amount);

    // 검색 조건들을 맵으로 전달
    Map<String, Object> searchParams = new HashMap<>();
    searchParams.put("categoryId", categoryId);
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
  public ResponseEntity<List<BookListVO>> searchTitles(
      @RequestParam("query") String query,
      @RequestParam(value = "categoryId", required = false) String categoryId) {

    Map<String, Object> searchParams = new HashMap<>();
    searchParams.put("query", query);
    searchParams.put("categoryId", categoryId);

    log.info("AJAX 요청 - 검색어: {}", query);

    List<BookListVO> titles = service.searchTitles(searchParams);

    log.info("AJAX 응답 - 검색 결과: {}", searchParams);

    return ResponseEntity.ok(titles);
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
      @RequestParam("imageUploadType") String imageUploadType,  // 수정: 이미지 업로드 타입 추가
      @RequestParam(value = "photoUrl", required = false) String photoUrl,  // 수정: URL 파라미터 추가
      @RequestParam(value = "file", required = false) MultipartFile file) {
    try {
      ObjectMapper objectMapper = new ObjectMapper();
      objectMapper.registerModule(new JavaTimeModule());

      // 기존 책 정보 로드
      BookListVO currentBook = service.get(isbn13);

      // 수정된 책 정보 변환
      BookListVO updatedBook = objectMapper.readValue(bookData, BookListVO.class);

      // 이미지 업로드 타입에 따른 처리
      if ("url".equals(imageUploadType) && photoUrl != null) {
        updatedBook.setPhoto(photoUrl);  // URL 방식으로 이미지 설정
      } else if ("file".equals(imageUploadType) && file != null) {
        // 파일이 비어있거나 크기가 0인 경우 기존 파일명 유지
        if (file.isEmpty() || file.getSize() == 0) {
          log.info("파일이 비어있으므로 기존 파일명 유지");
          updatedBook.setPhoto(currentBook.getPhoto());  // 기존 파일명 유지
        } else {
          // 새로운 파일이 업로드된 경우에만 UUID 파일명 생성
          String savedFileName = handleFileUpload(file);
          updatedBook.setPhoto(savedFileName);  // 파일 업로드 방식으로 이미지 설정
        }
      } else {
        updatedBook.setPhoto(currentBook.getPhoto());  // 기존 이미지 유지
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
      return new ResponseEntity<>("success", HttpStatus.OK);
    } catch (Exception e) {
      return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
    }
  }

  private String handleFileUpload(MultipartFile file) throws IOException {
    String originalFileName = file.getOriginalFilename();

    // 경로 인젝션 방지 및 파일명 안전 처리
    if (originalFileName.contains("..")) {
      throw new IOException("인젝션당한다고!! : " + originalFileName);
    }

    // 정규식을 통해 한글, 영어, 숫자, 일부 특수문자만 허용
    String safeFileName = originalFileName.replaceAll("[^a-zA-Z0-9ㄱ-ㅎ가-힣.\\-_]", "_");

    // UUID와 원본 파일명 결합
    String savedFileName = UUID.randomUUID().toString() + "_" + safeFileName;

    // 파일 저장 경로 설정
    String uploadDir = "D:/upload/books/";
    File saveFile = new File(uploadDir + savedFileName);

    // 파일 저장
    file.transferTo(saveFile);

    // 저장된 파일명 반환
    return savedFileName;
  }


  @RequestMapping(value = "/checkIsbn", method = RequestMethod.GET, produces = "application/json")
  public Map<String, Boolean> checkIsbnExists(@RequestParam("isbn13") Long isbn13) {
    log.info("중복검사 시작");
    log.info("중복검사 시작" + isbn13);
    int count = mapper.checkIsbnExists(isbn13);
    Map<String, Boolean> response = new HashMap<>();
    response.put("isDuplicate", count > 0);
    return response;
  }
}
