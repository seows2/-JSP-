<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- ch10 추가된 코드 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- ch10 여기까지 --%>
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
	<h2> EL 예제 - 상품 목록</h2>
	<hr>
	<form name=form1  method="post" action="ProductSel.jsp">
		<select name="sel">
			<%--
				for(String item : product.getList())
					out.println("<option>" + item + "</option>");
			--%>
			<%-- ch10 추가된 코드 --%>
			<c:forEach items="${product.list}" var="item">
				<option>${item}</option>
			</c:forEach>
			<%-- ch10 여기까지 --%>
		</select>
		<input type="submit" value="선택"/>
	</form>
</body>
</html>