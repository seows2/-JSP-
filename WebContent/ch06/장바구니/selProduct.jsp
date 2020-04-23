<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {text-align: center;}
</style>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("username");
	session.setAttribute("username", name);
%>
</head>
<body>
	<h2>상품 선택</h2>
	<%= name %> 님이 로그인한 상태입니다.
	<form method=post action="addProduct.jsp">
		<select name=product>
			<option>사과</option>
			<option>오렌지</option>
			<option>레몬</option>
		</select>
		<input type=submit value="추가"/>
	</form>
	<a href=checkOut.jsp>계산</a>
</body>
</html>