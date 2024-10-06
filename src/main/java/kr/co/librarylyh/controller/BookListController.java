package kr.co.librarylyh.controller;

import com.google.gson.Gson;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.CategoryVO;
import kr.co.librarylyh.service.BookListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;


@Controller // 스프링이 컨트롤러 역할을 제공
@Log4j2
@RequestMapping("/library/*")
@AllArgsConstructor
public class BookListController {

	private BookListService service;

	@GetMapping("/booklist")
	public String booklist() {
		return "library/booklist"; // 책 목록 뷰로 이동
	}


	@GetMapping("/read/{isbn13}")
	public String read(@PathVariable("isbn13") Long isbn13, Model model) {
		BookListVO bookDetail = service.get(isbn13);
		model.addAttribute("bookDetail", bookDetail);
		return "library/bookDetail"; // 책 상세 보기 뷰로 이동
	}

	@GetMapping("/manage")
	public String manageBook(@RequestParam(value = "isbn13", required = false) Long isbn13,
			@RequestParam("mode") String mode, Model model) {
    log.info("Mode: {}", mode);
    log.info("ISBN13: {}", isbn13);

		if ("edit".equals(mode) && isbn13 != null) {
			// url의 mode가 'edit' 이고 isbn13 정보가 있다면 편집창으로 이동(isbn13을 기반으로 기존 책 정보 불러옴)

			BookListVO bookDetail = service.get(isbn13);
      log.info("Book Detail: {}", bookDetail);  // 책 정보 체크용 로그
			// 카테고리 정보를 불러옴
			List<CategoryVO> categories = service.getCategoriesByISBN(isbn13);

			// Gson으로 카테고리 목록을 json 배열 형태로 전달 (이러고 또 파싱해야됨)
			model.addAttribute("categories", new Gson().toJson(categories));
			model.addAttribute("bookDetail", bookDetail);

		}
		// 이 'mode' 의 정보를 담은 파라미터를 제공
		model.addAttribute("mode", mode);
		return "library/bookManagement";
	}


	// 파일 제공 메서드 추가
	@GetMapping("/books/{filename:.+}")
	public ResponseEntity<Resource> serveBookImage(@PathVariable String filename) {
		try {
			// 경로 변수 디코딩
			String decodedFilename = URLDecoder.decode(filename, StandardCharsets.UTF_8.toString());

			// 디코딩된 파일명을 사용하여 경로 설정
			Path file = Paths.get("D:/upload/books/").resolve(decodedFilename).normalize();

			// 파일 존재 여부 확인
			Resource resource = new UrlResource(file.toUri());
			if (!resource.exists()) {
				return ResponseEntity.notFound().build();  // 파일이 없으면 404 반환
			}

			// 원본 파일명 추출 (UUID_제거)
			String originalFilename = decodedFilename.substring(
					decodedFilename.indexOf('_') + 1);  // UUID_ 제거
      log.info("원본 파일명: {}", originalFilename);  // 원본 파일명 출력

			// 브라우저에서 다운로드 시 표시할 파일명 설정 (UTF-8 인코딩)
			String encodedFilename = URLEncoder.encode(originalFilename, "UTF-8");
			String contentDisposition = "inline; filename=\"" + encodedFilename + "\"";

			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition)
					.header(HttpHeaders.CONTENT_TYPE, Files.probeContentType(file))
					.body(resource);

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}
	}
}