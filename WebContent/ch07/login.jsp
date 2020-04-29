<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myapp.ch07.LoginManager"%>
<!DOCTYPE html>

<jsp:useBean id="user" class="myapp.ch07.UserBean" scope="request"/>
<jsp:setProperty property="*" name="user"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<style>
	body {text-align: center;}
</style>
<title>Insert title here</title>
</head>
<body>
	<h2>로그인 예제</h2>
	<hr>
	<%
		LoginManager loginManager = new LoginManager();
	if(loginManager.authenticate(user)){
		out.println("Login Success!!");
	} else{
		out.println("Login Fail!!");
	}
	%>
	<hr>
	사용자 아이디: <jsp:getProperty property="userid" name="user"/>
	<br>
	사용자 패스워드: <jsp:getProperty property="passwd" name="user"/>
	<br>
	사용자 이메일: <jsp:getProperty property="email" name="user"/>
</body>
</html>