package kr.co.librarylyh.controller;

import com.google.gson.Gson;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.CategoryVO;
import kr.co.librarylyh.domain.Paging;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller // 스프링이 컨트롤러 역할을 제공
@Log4j2
@RequestMapping("/library/*")
@AllArgsConstructor
public class BookListController {

	private BookListService service;

	@GetMapping("/booklist")
	public String booklist(
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "amount", defaultValue = "10") int amount,
			@RequestParam(value = "categoryId", required = false) String categoryId,
			@RequestParam(value = "rentalAvailable", required = false) String rentalAvailable,
			@RequestParam(value = "publicationDateFilter", required = false) String publicationDateFilter,
			Model model) {

		Paging pge = new Paging(pageNum, amount);
		Map<String, Object> searchParams = new HashMap<>();

		// 필터 조건이 있을 경우에만 searchParams에 추가 (필터 설정 안할때 URL 난장판되길래 만듦)
		if (categoryId != null && !categoryId.isEmpty()) {
			searchParams.put("categoryId", categoryId);
		}
		if (rentalAvailable != null && !rentalAvailable.isEmpty()) {
			searchParams.put("rentalAvailable", rentalAvailable);
		}
		if (publicationDateFilter != null && !publicationDateFilter.isEmpty()) {
			searchParams.put("publicationDateFilter", publicationDateFilter);
		}

		// 기본 검색 조건에 맞는 모든 책 목록 가져오기
		List<BookListVO> bookList = service.getListWithFiltersAndPaging(pge, searchParams);
		model.addAttribute("bookList", bookList);
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
		log.info("Mode: " + mode);
		log.info("ISBN13: " + isbn13);

		if ("edit".equals(mode) && isbn13 != null) {
			// url의 mode가 'edit' 이고 isbn13 정보가 있다면 편집창으로 이동(isbn13을 기반으로 기존 책 정보 불러옴)

			BookListVO bookDetail = service.get(isbn13);
			log.info("Book Detail: " + bookDetail);  // 책 정보 체크용 로그
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
	@GetMapping("/files/{filename:.+}")  // 파일 경로 매핑
	public ResponseEntity<Resource> serveFile(@PathVariable String filename) {
		try {
			Path file = Paths.get("D:/upload/books/").resolve(filename).normalize();
			Resource resource = new UrlResource(file.toUri());

			if (!resource.exists()) {
				return ResponseEntity.notFound().build();
			}

			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
					.body(resource);

		} catch (MalformedURLException e) {
			return ResponseEntity.badRequest().build();
		}
	}

}