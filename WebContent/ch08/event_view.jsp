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
	String sql = "select id, title, owner, content from event where id =" + request.getParameter("id");
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	
%>
<body>
	<h2>이벤트 내용</h2>
	<table border="1">
		<tr> <td>ID</td>
			<td><%=rs.getInt("id") %></td></tr>
		<tr> <td>Title</td>
			<td><%=rs.getString("title") %></td></tr>
		<tr> <td>Owner</td>
			<td><%=rs.getString("owner") %></td></tr>
		<tr> <td>Content</td>
			<td><%=rs.getString("content") %></td></tr>	
	</table>
	<%
		stmt.close();
		con.close();
	%>
	<br><a href="event_list.jsp">이벤트 목록 보기</a>
</body>
</html>