<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="event" class="myapp.ch08.EventBean" scope="request"/>

<html>
<head>
<meta charset="UTF-8">
<title>Event add</title>
</head>
<body>
	<h2>이벤트 추가</h2>
	ID : <jsp:getProperty property="id" name="event"/><br>
	Title : <jsp:getProperty property="title" name="event"/><br>
	Owner : <jsp:getProperty property="owner" name="event"/><br>
	content : <jsp:getProperty property="content" name="event"/><br>
	위 일정이 추가되었습니다.
	<br><a href="/webservice/EventControl?action=list">이벤트 목록 보기"</a>
</body>
</html>