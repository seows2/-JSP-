<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/custom.tld" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<mytag:HelloWorld/>
	<br>
	<mytag:SendMessage from="alice" to="bob">See you later</mytag:SendMessage>
</body>
</html>