package kr.co.librarylyh.mapper;

import java.util.List;
import java.util.Map;

import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.domain.CategoryVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

@Mapper
public interface BookListMapper {

	// 책 기본 정보 추가
	void insertBook(BookListVO book);

	// 책 상세 정보 추가
	void insertBookDetail(BookListVO bookDetail);

	// 책 카테고리 추가 (여러 개의 카테고리)
	void insertBookCategories(@Param("isbn13") Long isbn13, @Param("categoryIds") List<String> categoryIds);

	public BookListVO read(long isbn13);

	public List<CategoryVO> readCategoriesByISBN(long isbn13);

	// 책 기본 정보 수정
	void updateBook(BookListVO book);

	// 책 상세 정보 수정
	void updateBookDetail(BookListVO bookDetail);

	// 책 카테고리 정보 수정이 없는 이유는, 복합테이블을 사용하는 경우에는 일반적으로 직접 update 를 하는게 아니라 delete 후에 add 하는식으로 설계한다고 함

	// 책 기본 정보 삭제
	void deleteBook(@Param("isbn13") Long isbn13);

	// 책 상세 정보 삭제
	void deleteBookDetail(@Param("isbn13") Long isbn13);

	// 책 카테고리 삭제
	void deleteBookCategories(@Param("isbn13") Long isbn13);

	public List<BookListVO> getList();

	// 수정된 메서드: 검색 조건과 페이징 정보를 받기 위해 Map 타입 사용
	public List<BookListVO> getListWithFiltersAndPaging(Map<String, Object> searchParams);

	// 수정된 메서드: 총 카운트를 가져오는 메서드도 Map 타입 사용
	public int getTotalCount(Map<String, Object> searchParams);

	List<BookListVO> searchTitles(Map<String, Object> params);

	int checkIsbnExists(Long isbn13);
}

