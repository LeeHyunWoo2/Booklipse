package kr.co.librarylyh.service;

import java.util.List;
import java.util.Map;
import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.CategoryVO;
import kr.co.librarylyh.domain.Paging;

public interface BookListService {

	// 기존 CRUD 메서드들은 그대로 유지
	public void add(BookListVO bookList);

	public BookListVO get(long isbn13);


	public List<CategoryVO> getCategoriesByISBN(long isbn13);

	public boolean modify(BookListVO bookList);

	public boolean remove(long isbn13);

	// 페이징 및 검색 조건을 처리하는 메서드
	public List<BookListVO> getListWithFiltersAndPaging(Paging pge, Map<String, Object> searchParams);

	public int getTotal(Map<String, Object> searchParams);

	public List<BookListVO> searchTitles(String query);
}
