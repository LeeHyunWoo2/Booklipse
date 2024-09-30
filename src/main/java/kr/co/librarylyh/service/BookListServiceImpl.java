package kr.co.librarylyh.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import kr.co.librarylyh.domain.CategoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.Paging;
import kr.co.librarylyh.mapper.BookListMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class BookListServiceImpl implements BookListService {

	@Setter(onMethod_ = @Autowired)
	private BookListMapper mapper;


	@Override
	@Transactional
	public void add(BookListVO bookListVO) {
		// 1. 책 기본 정보 저장
		mapper.insertBook(bookListVO);

		// 2. 책 상세 정보 저장

		mapper.insertBookDetail(bookListVO);

		// 3. 카테고리 여러 개 저장
		List<String> categoryIds = bookListVO.getCategories().stream()
				// streamAPI는 리스트에 있는 데이터를 하나씩 처리해줌
				.map(CategoryVO::getCategoryId)
				// CategoryVO에서 getCategoryId 메서드를 참조함
				.collect(Collectors.toList());
				// 리스트로 반환 => categoryIds 라는 List<String> 이 만들어짐
		mapper.insertBookCategories(bookListVO.getIsbn13(), categoryIds);
	}

	@Override
	public BookListVO get(long isbn13) {
		// log.info("책 조회: " + isbn13);
		return mapper.read(isbn13);
	}

	@Override
	public List<CategoryVO> getCategoriesByISBN(long isbn13) {
		return mapper.readCategoriesByISBN(isbn13);  // 카테고리 정보 가져오기
	}


	@Override
	@Transactional
	public void modify(BookListVO bookList) {

		// url과 파일 방식을 교체했는지 검증 및 그에 맞는 로직을 추가해야함

		List<String> categoryIds = bookList.getCategories().stream()
						.map(CategoryVO::getCategoryId)
								.collect(Collectors.toList());

		// 책의 카테고리를 먼저 삭제하고, 다시 생성함. (복합 테이블은 보통 이렇게 설계 한다고 함)
		mapper.deleteBookCategories(bookList.getIsbn13());
		mapper.insertBookCategories(bookList.getIsbn13(), categoryIds);
		mapper.updateBookDetail(bookList);
		mapper.updateBook(bookList);
	}

	@Override
	@Transactional
	public void remove(long isbn13) {
		mapper.deleteBookCategories(isbn13);
		mapper.deleteBookDetail(isbn13);
		mapper.deleteBook(isbn13);
	}

	@Override
	public List<BookListVO> getListWithFiltersAndPaging(Paging pge, Map<String, Object> searchParams) {
		// log.info("필터 및 페이징 조건으로 책 리스트 조회: " + searchParams);

		// 페이징 정보 추가
		searchParams.put("pageNum", pge.getPageNum());
		searchParams.put("amount", pge.getAmount());
		searchParams.put("startRow", (pge.getPageNum() - 1) * pge.getAmount() + 1);
		searchParams.put("endRow", pge.getPageNum() * pge.getAmount());

		// MyBatis 매퍼 메서드 호출
		return mapper.getListWithFiltersAndPaging(searchParams);
	}

	@Override
	public int getTotal(Map<String, Object> searchParams) {
		// log.info("총 책 수 조회: " + searchParams);
		return mapper.getTotalCount(searchParams);
	}

	@Override
	public List<BookListVO> searchTitles(String query) {
		// log.info("검색어: {}", query);
		List<BookListVO>result = mapper.searchTitles(query);
		// log.info("검색 결과: {}", result);
		return result;
	}

}