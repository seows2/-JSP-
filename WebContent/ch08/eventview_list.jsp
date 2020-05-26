<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myapp.ch08.EventBean"%>
<!DOCTYPE html>
<jsp:useBean id="eventlist" class="java.util.ArrayList" scope="request"/>
<html>
<head>
<meta charset="UTF-8">
<title>Event List</title>
</head>
<body>
	<h2>이벤트 목록</h2>
	<table border="1">
		<tr>
			<td>Index</td>
			<td>Title</td>
			<td>Owner</td>
		</tr>
		<%
			for(int i=0; i<eventlist.size(); i++) {
				EventBean event = (EventBean)eventlist.get(i);
		%>
		<tr>
			<td><%=event.getId() %></td>
			<td>
				<a href="EventControl?action=view&id<%=event.getId() %>">
					<%=event.getTitle() %>
				</a>
			</td>
			<td><%=event.getOwner() %></td>
		</tr>
		<%
			}
		%>
	</table>
	<br><hr>
	
	<form action="/webservice/EventControl" method="get">
		ID <input type="text" name="id" size=5/>
		Title <input type="text" name= "title" size=15/>
		Owner <input type="text" name= "owner" size=10/> <br>
		Content <input type="text" name= "content" size=40/> <br>
		<input type="hidden" name="action" value="add"/>
		<input type="submit" value="이벤트 추가"/>
	</form>
</body>
</html>