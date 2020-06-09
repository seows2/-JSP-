<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
	<h2>EL 예제</h2>
	<hr>
	선택한 상품은 : ${param.sel}
	num1 + num2 = ${product.num1 + product.num2 }
</body>
</html>