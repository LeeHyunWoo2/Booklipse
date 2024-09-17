package kr.co.librarylyh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

	public void updateAvailable (BookListVO bookList){
		if(bookList.getB_count() <= 0){
			bookList.setRentalAvailable("N");
		} else {
			bookList.setRentalAvailable("Y");
		}
	}

	@Transactional
	@Override
	public void add(BookListVO bookList) {
		log.info("책 추가: " + bookList);
		updateAvailable(bookList);
		mapper.insert(bookList);
	}

	@Override
	public BookListVO get(long isbn13) {
		log.info("책 조회: " + isbn13);
		return mapper.read(isbn13);
	}

	@Override
	public List<CategoryVO> getCategoriesByISBN(long isbn13) {
		return mapper.readCategoriesByISBN(isbn13);  // 카테고리 정보 가져오기
	}


	@Override
	public boolean modify(BookListVO bookList) {
		log.info("책 수정: " + bookList);
		updateAvailable(bookList);
		return mapper.update(bookList) == 1;
	}

	@Override
	public boolean remove(long isbn13) {
		log.info("책 삭제: " + isbn13);
		return mapper.delete(isbn13) == 1;
	}

	@Override
	public List<BookListVO> getListWithFiltersAndPaging(Paging pge, Map<String, Object> searchParams) {
		log.info("필터 및 페이징 조건으로 책 리스트 조회: " + searchParams);

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
		log.info("총 책 수 조회: " + searchParams);
		return mapper.getTotalCount(searchParams);
	}

}