<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>개발자 오류 메시지</title>
    <style>
      .developHelper * {
        font-family: "Noto Sans KR", sans-serif;
        font-optical-sizing: auto;
        font-size: 1rem;
        font-weight: 500; /* 일반 글씨 */
        font-style: normal;
      }
      .alertbox{
        position: relative;
        margin-top: -24%;
        margin-left: 100%;
        left: 30%;
        z-index: 9999;
      }
      .icon-box:hover {
        transform: scale(1.1);
        z-index: 9;
      }
      .icon-box {
        background-color: #ffffff;
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
        border-radius: 5px;
        transition: all 0.2s ease;
        position: relative;
      }
      .icon-box:hover button {
        margin-top: 5px;
      }
      .alert-circle {
        width: 30px;
        height: 30px;
        background-color: #ffffff;
        border-radius: 100%;
        border: solid 2px #2f363d;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        gap: 1px;
        cursor: pointer;
      }
      .alert-circle .line-1 {
        width: 3px;
        height: 10px;
        background-color: #2f363d;
        border-radius: 50px;
      }
      .alert-circle .line-2 {
        width: 3px;
        height: 4px;
        background-color: #2f363d;
        border-radius: 50px;
      }
      .collapse-box {
        position: absolute;
        background-color: #f9f9f9;
        height: 0;
        width: 0;
        border-radius: 5px;
        box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
        overflow: hidden;
        transition: opacity 0.3s ease, max-height 0.3s ease;
        opacity: 0;
        padding: 10px;
        margin-top: 10px;
        z-index: 9999;
      }
      .collapse-box.expanded {
        left: -15vh;
        height: 80vh;
        width: 120vh;
        opacity: 1;
      }
      .log-container {
        display: flex;
        gap: 20px;
        margin: 20px 0;
      }

      .log-box {
        width: 100%;
        background-color: #f0f0f0;
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 10px;
      }

      .log-content {
        min-height: 89%;
        max-height: 89%;
        overflow-y: auto;
        padding: 10px;
        color: #000;
        background-color: #ffffff;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin-bottom: 10px;
        white-space: pre-wrap;
        font-size: 0.9em;
        font-weight: 400;
      }

      .logbutton {
        padding: 5px 15px;
        background-color: #007bff;
        margin-left: 80%;
        color: white;
        border: none;
        border-radius: 3px;
        cursor: pointer;
      }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
          rel="stylesheet">
</head>
<body>

<div class="alertbox">
    <div class="icon-box" id="icon-box">
        <button class="alert-circle" onclick="onHelperToggle()">
            <span class="line-1"></span>
            <span class="line-2"></span>
        </button>
    </div>
    <div class="collapse-box" id="collapse-box">
            <%--<button class="logbutton" style="position: absolute; float: right;" id="helperToggle" onclick="()">일시정지</button>--%>
        <div class="log-container" style="height: 95%;">
            <div class="log-box">
                <h3>메서드 실행 로그</h3>
                <div id="method-log" class="log-content"></div>
                <button class="logbutton" onclick="clearLog('method-log')">초기화</button>
            </div>

            <div class="log-box">
                <h3>오류 로그</h3>
                <div id="error-log" class="log-content"></div>
                <button class="logbutton" onclick="clearLog('error-log')">초기화</button>
            </div>
        </div>
    </div>
</div>

<script>
  let helper = false;
  let sse;  // SSE 객체
  let disconnected = true;  // 기본 상태는 끊긴 상태
  let reConCount = 0; // 재연결 시도 횟수

  function onHelperToggle (){
    const collapseBox = document.getElementById('collapse-box');
    helper = !helper;

    if (helper){
      collapseBox.classList.add('expanded');
    } else {
      collapseBox.classList.remove('expanded');
    }
  }


  document.addEventListener("DOMContentLoaded", function (){
    startSseConnection();  // 연결이 자동으로 시작
  });

  // SSE 연결 시작
  function startSseConnection() {
    // 기존 객체가 있으면 연결 종료하고 다시 만듦
    if (sse){
      sse.close()
    }

    // SSE 연결 상태를 확인함. 닫힐경우 sse 객체 생성
    if (!sse || sse.readyState === EventSource.CLOSED) {
      const baseUrl = window.location.origin;
      const url = baseUrl + "/logs/stream";
      sse = new EventSource(url);
      console.log("SSE 연결 시작");

      sse.addEventListener("log", function (event) {
        addLog("error-log", event.data);
      });
      sse.onmessage = function (event) {
        console.log("로그수신 확인", event.data);
        try {
          const data = JSON.parse(event.data);
          addLog("error-log", event.data);
        } catch (e) {
          console.error("JSON 파싱 오류 : ", e);
        }
      };
      sse.onerror = function () {
        console.error("SSE 연결 오류 발생");
        stopSseConnection();
        if (reConCount < 4){
          setTimeout(startSseConnection, 2000);  // 2초 후 자동 재연결
          reConCount ++;
          console.log("2초 후 재연결 시도.... 시도횟수 : " + reConCount);
        } else {
          console.log("10초 경과로 재연결 시도 중단")
        }
      };
      disconnected = false;  // 연결 상태를 업데이트
    }
  }

  // SSE 연결 종료
  function stopSseConnection() {
    if (sse) {
      sse.close();
      sse = null;
      console.log("SSE 연결 종료");
      disconnected = true;  // 연결 끊김 상태로 업데이트
    }
  }

  window.addEventListener('beforeunload', function () {
    stopSseConnection();  // 새로고침이나 페이지 이동 시 연결 해제
    reConCount = 0;
    console.log('페이지 변화 감지, SSE 연결 해제');
  });

  // 로그 추가 함수
  function addLog(logId, message) {
    let logBox;

    function deleteLastLine (logBox) {
      let logContent = logBox.innerHTML;
      const maxLines = 100;  // 최대 100줄 유지

      // 로그 줄수 계산
      let logLines = logContent.split("<br>").filter(line => line !== "").length;

      // 최대 줄 수 초과시 가장 오래된 줄을 삭제
      if (logLines >= maxLines) {
        let logArray = logContent.split("<br>");
        logArray.splice(0, logLines - maxLines + 1); // 오래된 로그삭제
        logContent = logArray.join("<br>");
      }
    }

  // 메시지가 메서드 로그인지 오류 로그인지 구분
  if (message.includes("메서드 시작") || message.includes("메서드 종료")) {
    logBox = document.getElementById("method-log");
    logBox.innerHTML += "[Method] " + message + "<br>";  // 메서드 로그 추가
    deleteLastLine(logBox);
  } else {
    logBox = document.getElementById("error-log");
    logBox.innerHTML += "[Error] " + message + "<br>";  // 오류 로그 추가
    deleteLastLine(logBox);
  }

    // 스크롤을 맨 아래로 이동
    logBox.scrollTop = logBox.scrollHeight;
  }

  // 로그 초기화 함수
  function clearLog(logId) {
    const logBox = document.getElementById(logId);
    if (logId === "method-log") {
      logBox.innerHTML = '[Method 로그 초기화 -완- ]<br>';
    } else if (logId === "error-log") {
      logBox.innerHTML = '[Error 로그 초기화 -완- ]<br>';
    }
  }
</script>

</body>
</html>
