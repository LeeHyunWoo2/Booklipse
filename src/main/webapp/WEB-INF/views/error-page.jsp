<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오류 발생</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #ffffff;
        color: #000000;
        text-align: center;
        padding: 50px;
      }
      .error-container {
        margin: auto;
        padding: 20px;
        border: 2px solid #ffffff;
        background-color: #f3f3f3;
        max-width: 600px;
        border-radius: 10px;
      }
      h1 {
        font-size: 2.5em;
      }
      p {
        font-size: 1.2em;
      }
    </style>
</head>
<body>
<jsp:include page="includes/header.jsp"/>
<div class="error-container" style="margin-top: 130px; margin-bottom: 130px">
    <h1>문제가 발생했습니다</h1>
    <p>요청을 처리하는 도중 오류가 발생했습니다.</p>
    <p>오류 코드: <strong><%= request.getAttribute("javax.servlet.error.status_code") %></strong></p>
    <p>오류 메시지: <strong><%= exception != null ? exception.getMessage() : "오류 정보를 확인할 수 없습니다." %></strong></p>
    <button class="btn btn-primary" onclick="history.back()">돌아가기</button>
</div>
<jsp:include page="includes/footer.jsp"/>
</body>
</html>