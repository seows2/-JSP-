<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="product" class="myapp.ch10.Product" scope="session"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	body {
	text-align: center;
}
</style>
<body>
	<h2> EL 예저 - 상품 목록</h2>
	<hr>
	<form name=form1  method="post" action="ProductSel.jsp">
		<select name="sel">
			<%
				for(String item : product.getList())
					out.println("<option>" + item + "</option>");
			%>
		</select>
		<input type="submit" value="선택"/>
	</form>
</body>
</html>