<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless"%>

<%@ attribute name="bgcolor"%>
<%@ attribute name="border" %>

<jsp:useBean id="product" class="myapp.ch10.Product"/>

<h2><jsp:doBody/></h2>

<table border= "${border}" bgcolor=${bgcolor} width="150">
	<%
		for(String item: product.getList())
			out.println("<tr><td>" + item + "</td></tr>");
	%>

</table>