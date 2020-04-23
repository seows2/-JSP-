<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myapp.SingletonCounter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>카운터 2</h2>
	<% SingletonCounter.addCount(); %>
	<p> 당신은 <%= SingletonCounter.getCount() %>번째 사용자입니다.</p>
</body>
</html>