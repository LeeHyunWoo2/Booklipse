package kr.co.librarylyh.aop;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import lombok.Data;
import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Aspect
@Component
@Log4j2
@Data
public class LoggingAspect {

  // SSE 방식 로그 전송을 위한 클래스
  private SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);

  // 멀티스레드 때문에 개인프로젝트에서 죽도록 사용한 ExecutorService
  private final ExecutorService executorService = Executors.newSingleThreadExecutor();
  // 연결이 5초 이상 끊기면 버퍼를 비우는 스케줄러
  private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

  // 메모리에 로그를 저장하는 임시 버퍼 (실제로 쓰이는 방법인진 모르겠으나 아이디어가 떠오른김에 시도해보려고 만듦)
  private List<String> logBuffer = new ArrayList<>();

  private boolean isDisconnected = true;

  // 연결 끊긴 시간을 기록할때 쓸 변수
  private long lastConnectedTime = 0;


  // 메서드 실행 전에 로그 기록
  @Before("execution(* kr.co.librarylyh.service.*.*(..)) || execution(* kr.co.librarylyh.controller.*.*(..)) || execution(* kr.co.librarylyh.mapper.*.*(..))")
  public void logBefore(JoinPoint joinPoint) {
    String message = "메서드 시작: " + joinPoint.getSignature().getName() + "\n"
        + "전달된 인자: " + Arrays.toString(joinPoint.getArgs());
    processLog(message);
    log.info(message);
  }

  // 메서드가 정상 종료된 후에 로그 기록
  @AfterReturning(pointcut = "execution(* kr.co.librarylyh.service.*.*(..)) || execution(* kr.co.librarylyh.controller.*.*(..)) || execution(* kr.co.librarylyh.mapper.*.*(..))", returning = "result")
  public void logAfterReturning(JoinPoint joinPoint, Object result) {
    String message = "메서드 정상 종료: " + joinPoint.getSignature().getName() + "\n"
        + "결과 값: " + result;
    processLog(message);
    log.info(message);
  }

  // 인자 포맷팅 메서드 (배열을 문자열로 변환. 이거 안하면 주소값 같은거만 보임)
  public String formatArgs(Object[] args) {
    StringBuilder formattedArgs = new StringBuilder();
    for (Object arg : args) {
      formattedArgs.append(arg.toString()).append("\n");  // 줄바꿈 처리
    }
    return formattedArgs.toString();
  }

  public void processLog(String logMessage) {
    if (isDisconnected) { // 연결이 끊긴 상태(디폴트) 일땐 버퍼에 저장
      logBuffer.add(logMessage); // 로그를 버퍼에 저장
      // 돌발상황을 염두하고 데드맨 스위치처럼 디폴트를 미접속을 가정하고 버퍼에 저장
      log.info("버퍼에 로그 저장: ");
      clearBuffer();  // 연결이 끊긴 동안 5초 이상 지난 경우 버퍼 비우기 시도
    } else {
      sendLog(logMessage);  // 연결이 된 상태면 즉시 전송
    }
  }

  public void sendLog(String logMessage) {
    executorService.submit(() -> {
      try {
        emitter.send(SseEmitter.event().data(logMessage).name("log"));
        lastConnectedTime = System.currentTimeMillis(); // 전송이 성공하면 시간을 기록
      } catch (IOException e) {
        log.warn("SSE 연결 끊김: 로그는 버퍼에 저장됨.");
        // 클라이언트 연결이 끊긴 경우에도 로그는 일단 메모리에 쌓임
        isDisconnected = true; // 끊김 상태로 전환
      }
    });
  }

  public void clearBuffer() {
    if (System.currentTimeMillis() - lastConnectedTime > 5000) {
      // 현재시간 - 기록시간이 5000ms 보다 높으면 (5초가 지났으면)
      logBuffer.clear();
      log.info("버퍼가 5초 이상 연결되지 않아 비워짐");
      lastConnectedTime = System.currentTimeMillis();
      // 버퍼를 비웠으니 5초 간격을 추가하기 위해 접속시간을 갱신시킴(실제 접속된게 아니지만, 0.001초단위로 계속 버퍼 비우면 안되니까)
    }
  }

  public void onReconnect() { // 접속 끊긴동안 쌓인 버퍼를 로그에 출력
    if (!logBuffer.isEmpty()) {
      log.info("재연결 시 버퍼에 저장된 로그 전송 중");
      logBuffer.forEach(this::sendLog); // 버퍼에 있는 로그 전송
      logBuffer.clear(); // 버퍼 비움, 어차피 sendLog가 작동할테니 시간 갱신은 안함.
      log.info("버퍼 털었다");
    }
    isDisconnected = false;
  }

/*  // 서버에서 클라이언트에게 주기적으로 핑 신호를 보내고 응답에 따라 연결상태 변수 갱신
  public void sendPing() {
    try {
      emitter.send(SseEmitter.event().name("ping").data("ping"));
      log.info("핑 전송");
    } catch (IOException e) {

    }
  }*/
}