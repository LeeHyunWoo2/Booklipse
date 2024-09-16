package kr.co.librarylyh.controller;

import kr.co.librarylyh.domain.BookListVO;
import kr.co.librarylyh.service.BookListService;
import lombok.extern.log4j.Log4j2;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@Log4j2
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class BookListControllerTests {

	@Autowired
	private WebApplicationContext ctx;

	private MockMvc mockMvc;

	@Before
	public void setUp() {
		// MockMvc 설정
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.ctx).build();
	}

	@Test
	public void testAddBook() throws Exception {
		log.info("책 추가 테스트 시작");
		mockMvc.perform(post("/booklist/add")
						.param("isbn13", "1234567890123")
						.param("book", "테스트 책 제목")
						.param("author", "테스트 저자")
						.param("publisher", "테스트 출판사")
						.param("price", "10000"))
				.andExpect(status().is3xxRedirection())
				.andExpect(redirectedUrl("/booklist/list"));
		log.info("책 추가 테스트 종료");
	}

}
