<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	page_control_end.jsp output page
	<hr>
	name : <%= request.getParameter("username") %><br>
	tel : <%= request.getParameter("tel") %>
</body>
</html>