<html>
<%
	session.invalidate();
	response.sendRedirect("http://localhost:8080/Bank/homepage.jsp");
%>
</html>