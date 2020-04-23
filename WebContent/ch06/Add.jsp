<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>1~10 더하기</h2>
	<%
		int sum = 0;
		int i;
		for(i=1; i<=10; i++){
			out.print(i+ " ");
			if(i != 10){
				out.print("+ ");
			} else {
				out.print("= ");
			}
				sum = sum+i;
		}
		out.print(sum);
	%>
</body>
</html>