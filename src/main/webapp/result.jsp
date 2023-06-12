<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
  <style>
    body {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      height: 100vh;
    }
    h1, p, a {
      text-align: center;
    }
  </style>
</head>
<body>
<%
  String count = request.getParameter("count");
%>
<h1><%= count%>개의 WIFI 정보를 정상적으로 저장하였습니다.</h1>
<a href="index.jsp"> 홈으로 가기</a>
</body>
</html>