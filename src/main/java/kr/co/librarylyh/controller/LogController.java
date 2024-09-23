package kr.co.librarylyh.controller;

import kr.co.librarylyh.aop.LoggingAspect;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Log4j2
@RestController
@RequestMapping("/logs")
public class LogController {

  @Autowired
  private LoggingAspect loggingAspect;

  // SSE를 통해 실시간 로그 전송, 새로운 SseEmitter 생성 및 재연결 관리
  @GetMapping("/stream")
  public SseEmitter streamLogs() {
    // 새로운 SseEmitter를 항상 생성
    SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);

    // 연결 끊김 여부 확인 후 재연결 처리
    if (loggingAspect.isDisconnected()) {
      loggingAspect.onReconnect();
    }

    // 새로운 Emitter로 교체
    loggingAspect.setEmitter(emitter);

    return emitter;
  }

}