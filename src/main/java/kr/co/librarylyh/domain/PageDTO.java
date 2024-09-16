package kr.co.librarylyh.domain;

import lombok.Data;
import lombok.Getter;
import lombok.ToString;

import java.util.List;


@Data
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private Paging pge;
	private List<BookListVO> list;
	private int finalPage;

	public PageDTO(Paging pge, int total, List<BookListVO> list) {
		this.total = total;
		this.pge = pge;
		this.list = list;

		// 한 블록 당 10페이지를 표시
		this.endPage = (int) (Math.ceil(pge.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;

		// 실제 마지막 페이지 계산
		int realEnd = (int) Math.ceil(total * 1.0 / pge.getAmount());
		this.finalPage = realEnd;  // 최종 페이지는 realEnd와 동일

		// 실제 마지막 페이지가 endPage보다 작으면, 실제 마지막 페이지를 endPage로 설정
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		// 이전 페이지 블록의 존재 여부
		this.prev = this.startPage > 1;

		// 다음 페이지 블록의 존재 여부
		this.next = this.endPage < realEnd;
	}
}