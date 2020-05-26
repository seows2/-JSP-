<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="event" class="myapp.ch08.EventBean" scope="request"/>
<html>
<head>
<meta charset="UTF-8">
<title>Event View</title>
</head>
<body>
	<h2>이벤트 내용</h2>
	<table border="1">
		<tr> <td>ID</td>
			<td><jsp:getProperty property="id" name="event"/></td></tr>
		<tr> <td>Title</td>
			<td><jsp:getProperty property="title" name="event"/></td></tr>
		<tr> <td>Owner</td>
			<td><jsp:getProperty property="owner" name="event"/></td></tr>
		<tr> <td>Content</td>
			<td><jsp:getProperty property="content" name="event"/></td></tr>	
	</table>
	<br><a href="/webservice/EventControl?action=list">이벤트 목록 보기</a>
</body>
</html>