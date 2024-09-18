package kr.co.librarylyh.domain;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BookListVO {
	private Long isbn13;
	private String book;
	private String author;
	private String publisher;
	private String photo;
	private String rentalAvailable;
	private int price;  // NUMBER(10, 2) 크기에 따라 long으로 할 수도 있음
	private int bookCount;
	private String bookDescription;  // CLOB 타입
	private String weight;
	private String bookSize;
	private int pageCount;
	private double averageRating;  // NUMBER(2, 1)
	private String star5Count;
	private String star4Count;
	private String star3Count;
	private String star2Count;
	private String star1Count;
	private int reviewCount;
	private List<CategoryVO> categories;

	// @DateTimeFormat 을 이용 (저 형식으로 문자열이 입력되면 LocalDate타입으로 자동변환)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private LocalDate publicationDate; // 날짜필드


}