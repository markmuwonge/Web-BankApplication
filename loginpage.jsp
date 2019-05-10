<html>
	
<%
	try
	{
		if ((Integer) session.getAttribute("role") == 2) //admin
		{
			out.println("<center>");
			out.println("<a href='http://localhost:8080/Bank/home.jsp'><button style='float:left'>Home</button></a>");
			out.println("Go to <a href='http://localhost:8080/Bank/admin.jsp'>Admin</a>");
			out.println("</center>");
		}
		else if((Integer) session.getAttribute("role") == 1) //customer
		{
			out.println("customer logged in");
		}
	}

	catch (Exception e)
	{
		out.println("<center><h1>Login</h1></center>");
		out.println("<a href='http://localhost:8080/Bank/home.jsp'><button style='float:left'>Home</button></a>");
		out.println("<form action='http://localhost:8080/Bank/login.jsp' method='post'>");
		out.println("<center>");
		out.println("<table>");
		out.println("<tr>");
		out.println("<td>UserName</td>");
		out.println("<td><input name='username'></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td>Password</td>");
		out.println("<td><input name='password' type='password'></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td><input type='submit'></td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</center>");
		out.println("</form>");
	}
%>
	
</html>