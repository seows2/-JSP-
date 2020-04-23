<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String product = request.getParameter("product");
		ArrayList<String> list = (ArrayList<String>)session.getAttribute("productlist");
		if(list == null){
			list = new ArrayList<String>();
		}
		list.add(product);
		session.setAttribute("productlist", list);
		out.println(product + "이(가) 추가되었습니다.");
	%>
</body>
</html>