package kr.co.librarylyh.domain;

import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BookListVO {
	private Long isbn13;
	private String book;
	private String bookDescription;  // CLOB 타입
	private String author;
	private String publisher;
	private String photo;
	private String weight;
	private String bookSize;
	private String rentalAvailable;
	private int price;  // NUMBER(10, 2) 크기에 따라 long으로 할 수도 있음
	private int pageCount;
	private int b_count;
	private double averageRating;  // NUMBER(2, 1)
	private String star_5;
	private String star_4;
	private String star_3;
	private String star_2;
	private String star_1;
	private int review_count;
  private List<CategoryVO> categories;

	// @DateTimeFormat 을 이용 (저 형식으로 문자열이 입력되면 LocalDate타입으로 자동변환)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private LocalDate publicationDate; // 날짜필드


	// 이거 - 빠지면 곤란한데 이때 대처방안
	// 1. HTML에서는 <input type="date"> 사용하면 해결가능
	
	// 2. js에서는 이걸로 해결가능
//	document.getElementById('publishDate').addEventListener('input', function (e) {
//	    const datePattern = /^\d{4}-\d{2}-\d{2}$/; // YYYY-MM-DD 형식
//	    const inputDate = e.target.value;
//	    
//	    if (!datePattern.test(inputDate)) {
//	        // 입력 형식이 맞지 않으면 사용자에게 알림
//	        alert('날짜 형식은 YYYY-MM-DD이어야 합니다.');
//	        e.target.value = ''; // 잘못된 입력 지우기
//	    }
//	});
	
	// 3. 그 후 서버에서도 한번 유효성 검사 가능 (컨트롤러)
	// if(변수명.hasErrors()){
	//    return "폼 이름";
	// } 유효성 검사 통과 시, 비즈니스 로직 수행
	// return "redirect:/링크";

}