package kr.co.librarylyh.aop;

import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Aspect
@Component
@Log4j2
public class DataValidationAspect {

  @Autowired
  private LoggingAspect loggingAspect;

  @Before("execution(* kr.co.librarylyh.service.*.*(..))")
  public void validateSecurity(JoinPoint joinPoint) {
    Object[] args = joinPoint.getArgs();
    String input = (String) args[0];  // 입력 데이터

    if (input.contains("<script>")) {
      String alert = "XSS 공격 시도가 감지되었습니다.";
      logValidationError(alert, joinPoint, input);
      throw new SecurityException(alert);
    }

    if (input.matches(".*([';--]).*")) {
      String alert = "SQL 인젝션 시도가 감지되었습니다.";
      logValidationError(alert, joinPoint, input);
      throw new SecurityException(alert);
    }
  }

  // 유효성 검사 예외 발생 시 로그 처리
  private void logValidationError(String alertMessage, JoinPoint joinPoint, String input) {
    String location = joinPoint.getSignature().getDeclaringTypeName() + "." + joinPoint.getSignature().getName();
    String argsDetails = loggingAspect.formatArgs(joinPoint.getArgs());

    // 메시지 조립
    String logMessage = "유효성 검사 실패: [" + alertMessage + "]<br>위치 : " + location + ".<br>입력 값: " + input + ".<br>인자 값: " + argsDetails;

    // LoggingAspect를 통해 로그 전송
    loggingAspect.sendLog(logMessage);
  }
}
