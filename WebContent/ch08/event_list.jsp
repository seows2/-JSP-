<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event List</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String jdbc_driver = "org.mariadb.jdbc.Driver";
	String jdbc_url = "jdbc:mariadb://localhost:3306/mydb?characterEncoding=utf8&serverTimezone=UTC";
	Class.forName(jdbc_driver);
	Connection con = DriverManager.getConnection(jdbc_url, "root", "kgu123");
	
	Statement stmt = con.createStatement();
	String sql = "select id, title, owner from event";
	ResultSet rs = stmt.executeQuery(sql);
	
%>
<body>
	<h2>이벤트 목록</h2>
	<table border="1">
		<tr>
			<td>Index</td>
			<td>Title</td>
			<td>Owner</td>
		</tr>
		<%
			while(rs.next()){
		%>
		<tr>
			<td><%=rs.getInt("id") %></td>
			<td>
				<a href="event_view.jsp?id=<%=rs.getString("id") %>">
					<%=rs.getString("title") %>
				</a>
			</td>
			<td><%=rs.getString("owner") %></td>
		</tr>
		<%
			}
			rs.close();
			stmt.close();
			con.close();
		%>
	</table>
	<br><hr>
	
	<form action="event_add.jsp" method="post">
		ID <input type="text" name="id" size=5/>
		Title <input type="text" name= "title" size=15/>
		Owner <input type="text" name= "owner" size=10/> <br>
		Content <input type="text" name= "content" size=40/> <br>
		<input type="submit" value="이벤트 추가"/>
	</form>
</body>
</html>