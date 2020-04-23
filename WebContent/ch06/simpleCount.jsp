<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%! int count = 0; %>
 <p> 당신은 <% out.print(++count); %>번째 접속자입니다.
</body>
</html>