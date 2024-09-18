package kr.co.librarylyh.controller;

import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.CategoryVO;
import kr.co.librarylyh.domain.Paging;
import kr.co.librarylyh.service.BookListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
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

}