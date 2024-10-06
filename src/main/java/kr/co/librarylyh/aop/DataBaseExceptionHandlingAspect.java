package kr.co.librarylyh.aop;

import java.sql.SQLException;
import lombok.Data;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.binding.BindingException;
import org.apache.ibatis.exceptions.TooManyResultsException;
import org.apache.ibatis.executor.ExecutorException;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Aspect
@Component
@Order(1) // 우선순위 설정 (DB쪽 문제는 여기서 처리)
@Log4j2
@Data
public class DataBaseExceptionHandlingAspect {

  @Autowired
  private LoggingAspect loggingAspect;

  @AfterThrowing(pointcut = "execution(* kr.co.librarylyh.mapper.*.*(..)) && args(..)", throwing = "ex")
  public void handleDatabaseException(JoinPoint joinPoint, Throwable ex) {

    Throwable rootCause = findRootCause(ex);

    String location = joinPoint.getSignature().getDeclaringTypeName() + "." + joinPoint.getSignature().getName();
    Object[] args = joinPoint.getArgs();

    String argDetails = loggingAspect.formatArgs(args);

    if (rootCause instanceof BindingException) {
      handleBindingException((BindingException) rootCause, location, argDetails);
    } else if (rootCause instanceof ExecutorException) {
      handleExecutorException((ExecutorException) rootCause, location, argDetails);
    } else if (rootCause instanceof TooManyResultsException) {
      handleTooManyResultsException((TooManyResultsException) rootCause, location, argDetails);
    } else if (rootCause instanceof SQLException) {
      handleSQLException((SQLException) rootCause, location, argDetails);  // ORA 코드 처리
    }
  }

  // 근본 원인(root cause)을 찾는 메서드
  private Throwable findRootCause(Throwable ex) {
    Throwable rootCause = ex;
    while (rootCause.getCause() != null && rootCause.getCause() != rootCause) {
      rootCause = rootCause.getCause();
    }
    return rootCause;
  }

  // MyBatis 예외 처리
  private void handleBindingException(BindingException ex, String location, String args) {
    String message = "전달된 값이 누락되었거나 잘못 매핑되었습니다. (값이 이상한데로 가던가 증발하던가 했다는 뜻)";
    sendFormattedLog("BindingException", location, args, ex.getMessage(), message);
  }

  private void handleExecutorException(ExecutorException ex, String location, String args) {
    String message = "잘못된 SQL 구문이거나, 실행 중 문제가 발생했습니다.";
    sendFormattedLog("ExecutorException", location, args, ex.getMessage(), message);
  }

  private void handleTooManyResultsException(TooManyResultsException ex, String location, String args) {
    String message = "단일 결과를 받아야 하는데 여러 결과가 반환되었습니다.";
    sendFormattedLog("TooManyResultsException", location, args, ex.getMessage(), message);
  }

  // ORA 코드 처리
  private void handleSQLException(SQLException ex, String location, String args) {
    String errorCode = "ORA-" + ex.getErrorCode();  // ORA 오류 코드 문자열로 변환
    String message;

    switch (errorCode) {
      case "ORA-01400":
        message = "NULL 값을 허용하지 않는 열에 NULL이 입력되었습니다.";
        break;
      case "ORA-02291":
        message = "무결성 제약조건 검색 ㄱㄱ 보통 부모키가 없거나 부모테이블에 없는 데이터를 자식테이블에 넣으려고 하면 발생합니다.";
        break;
      case "ORA-02292":
        message = "자식 행이 존재하는 상태에서 삭제하려고 했습니다.";
        break;
      case "ORA-12154":
        message = "데이터베이스 연결 설정을 확인하세요. id pw 1521 xe 이런거";
        break;
      case "ORA-12560":
        message = "네트워크 상태와 데이터베이스 서버를 확인하세요.";
        break;
      case "ORA-00001":
        message = "PK에 중복된 값을 입력하지 마세요.";
        break;
      case "ORA-03113":
        message = "데이터베이스와의 연결이 끊어졌습니다.";
        break;
      case "ORA-00942":
        message = "참조된 테이블이나 뷰가 존재하지 않습니다. 테이블 이름과 경로를 확인하세요.";
        break;
      case "ORA-00904":
        message = "유효하지 않은 식별자 또는 열 이름이 참조되었습니다. 쿼리에서 열 이름을 확인하세요.";
        break;
      case "ORA-01722":
        message = "숫자 변환 오류가 발생했습니다. 입력된 데이터가 유효한 숫자인지 확인하세요.";
        break;
      case "ORA-01438":
        message = "자릿수가 테이블에 지정된 크기보다 큽니다. 입력 데이터를 조정하세요.";
        break;
      case "ORA-02899":
        message = "컬럼의 크기보다 입력할 내용이 큽니다. 입력 데이터를 조정하세요.";
        break;
      case "ORA-00907":
        message = "쿼리에 괄호가 짝짝이로 맞지 않습니다. 쿼리 구문을 확인하세요.";
        break;
      case "ORA-01861":
        message = "값이 형식에 맞지 않습니다. 날짜나 시간 형식을 확인하세요.";
        break;
      default:
        message = "저도 모르겠으니 오류 코드를 구글에 검색하세요.";
        break;
    }
    sendFormattedLog("SQLException : " + errorCode, location, args, ex.getMessage(), message);
  }

  // 공통 로그 출력 메서드
  private void sendFormattedLog(String exceptionName, String location, String args, String exceptionMessage, String message) {
    log.error("예외 발생: [{}] at [{}]. 인자 값: [{}]. 예외 메시지: [{}]", exceptionName, location, args, exceptionMessage);
    log.error("해결방안 : {}", message);

    // 예외 메시지를 리스트에 추가
    String alertMessage = "[Error] 예외 발생: [" + exceptionName + "]<br>위치 : " + location + ".<br>인자 값: " + args +
        ".<br>예외 메시지: " + exceptionMessage + ".<br> " + message;
    loggingAspect.sendLog(alertMessage);
  }

}