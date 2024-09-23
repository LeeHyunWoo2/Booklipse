package kr.co.librarylyh.domain;

import lombok.Data;
import org.springframework.web.util.UriComponentsBuilder;

@Data
public class Paging {

	private int pageNum;
	private int amount;

	private String type;
	private String keyword;

	public Paging() {
		this(1, 10);
	}

	public Paging(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public String[] getTypeArr() { // 검색 조건을 배열로 만들어서 한번에 처리하기 위해 만듦
		return type == null ? new String[] {} : type.split("");
	}

	public String getListLink() { // 링크 생성 (인코딩되어 한글도 신경안써도됨)
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}

}
