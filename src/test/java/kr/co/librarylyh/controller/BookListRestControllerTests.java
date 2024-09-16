package kr.co.librarylyh.controller;

import kr.co.librarylyh.domain.BookListVO;
import lombok.extern.log4j.Log4j2;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebAppConfiguration
@Log4j2
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class BookListRestControllerTests {

  @Autowired
  private WebApplicationContext ctx;

  private MockMvc mockMvc;

  @Before
  public void setUp() {
    // MockMvc 설정
    this.mockMvc = MockMvcBuilders.webAppContextSetup(this.ctx).build();
  }

  @Test
  public void testGetBookList() throws Exception {
    log.info(
    mockMvc.perform(MockMvcRequestBuilders.get("/ajax/booklist")).andReturn().getModelAndView().getModelMap()
    );
  }

  @Test
  public void testGetBook() throws Exception {
    log.info("책 상세 조회 REST API 테스트 시작");
    mockMvc.perform(get("/api/booklist/1234567890123")
            .accept(MediaType.APPLICATION_JSON))
        .andExpect(status().isOk())
        .andExpect(content().contentType(MediaType.APPLICATION_JSON))
        .andExpect(jsonPath("$.book").value("테스트 책 제목"));  // 책 제목이 올바른지 테스트
    log.info("책 상세 조회 REST API 테스트 종료");
  }

  @Test
  public void testAddBook() throws Exception {
    log.info("책 추가 REST API 테스트 시작");
    mockMvc.perform(post("/api/booklist")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{\"isbn13\":1234567890123, \"book\":\"테스트 책 제목\", \"author\":\"테스트 저자\", \"publisher\":\"테스트 출판사\", \"price\":10000}")
            .accept(MediaType.APPLICATION_JSON))
        .andExpect(status().isOk());
    log.info("책 추가 REST API 테스트 종료");
  }

  @Test
  public void testModifyBook() throws Exception {
    log.info("책 수정 REST API 테스트 시작");
    mockMvc.perform(put("/api/booklist/1234567890123")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{\"book\":\"수정된 책 제목\"}")
            .accept(MediaType.APPLICATION_JSON))
        .andExpect(status().isOk());
    log.info("책 수정 REST API 테스트 종료");
  }

  @Test
  public void testRemoveBook() throws Exception {
    log.info("책 삭제 REST API 테스트 시작");
    mockMvc.perform(delete("/api/booklist/1234567890123")
            .accept(MediaType.APPLICATION_JSON))
        .andExpect(status().isNoContent());
    log.info("책 삭제 REST API 테스트 종료");
  }
}
