<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="userinfo" class="myapp.ch07.UserBean" scope="request"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<style>
	body {text-align: center;}
</style>
<title>Insert title here</title>
</head>
<body>
	<h2> Login Success!</h2>
	<hr>
	사용자 아이디: <jsp:getProperty property="userid" name="userinfo"/>
	<br>
	사용자 패스워드: <jsp:getProperty property="passwd" name="userinfo"/>
</body>
</html>