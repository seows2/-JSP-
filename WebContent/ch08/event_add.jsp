<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event add</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String jdbc_driver = "org.mariadb.jdbc.Driver";
	String jdbc_url = "jdbc:mariadb://localhost:3306/mydb?characterEncoding=utf8&serverTimezone=UTC";
	Class.forName(jdbc_driver);
	Connection con = DriverManager.getConnection(jdbc_url, "root", "kgu123");
	
	String sql = "insert into event values(?,?,?,?)";
	PreparedStatement stmt = con.prepareStatement(sql);
	
%>
<body>
	<h2>이벤트 추가</h2>
	ID : <%=request.getParameter("id") %><br>
	Title : <%=request.getParameter("title") %><br>
	Owner : <%=request.getParameter("owner") %><br>
	content : <%=request.getParameter("content") %><br>
	
	<%
		stmt.setInt(1, Integer.parseInt(request.getParameter("id")));
		stmt.setString(2, request.getParameter("title"));
		stmt.setString(3, request.getParameter("owner"));
		stmt.setString(4, request.getParameter("content"));
		stmt.executeUpdate();
		stmt.close();
		con.close();
	%>
	위 일정이 추가되었습니다.
	<br><a href="event_list.jsp">이벤트 목록 보기"</a>
</body>
</html>