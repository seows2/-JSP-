<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="user" class ="myapp.ch07.UserBean" scope="session"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>인증된 유저</h3>
	<jsp:getProperty property="userid" name="user"/>
</body>
</html>