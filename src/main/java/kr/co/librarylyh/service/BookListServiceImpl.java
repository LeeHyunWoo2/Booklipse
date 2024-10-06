package kr.co.librarylyh.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.naming.directory.SearchResult;
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
	@Transactional // DB에 직접 영향을 주는 작업은 트랜잭션 처리를 해주는게 좋다.
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
    log.info("책 조회: {}", isbn13);
		return mapper.read(isbn13);
	}

	@Override
	public List<CategoryVO> getCategoriesByISBN(long isbn13) {
		return mapper.readCategoriesByISBN(isbn13);  // 카테고리 정보 가져오기
	}


	@Override
	@Transactional
	public void modify(BookListVO bookList) {

		List<String> categoryIds = bookList.getCategories().stream()
						.map(CategoryVO::getCategoryId)
						.collect(Collectors.toList());

		// 책의 카테고리를 먼저 삭제하고, 다시 생성함.
		// (복합 테이블이기 때문에, 중복의 위험이 있고 각종 오류가 파생되기 쉬우므로 삭제 후 생성을 선택)
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
    log.info("필터, 페이징 조건으로 책 리스트 조회: {}", searchParams);

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
    log.info("총 책 수 조회: {}", searchParams);
		return mapper.getTotalCount(searchParams);
	}

	@Override
	public List<BookListVO> searchTitles(Map<String, Object> searchParams) {
		log.info("검색어: {}", searchParams);
		List<BookListVO> searchResult = mapper.searchTitles(searchParams);
    log.info("검색 결과: {}", searchResult);
		return searchResult;
	}

}