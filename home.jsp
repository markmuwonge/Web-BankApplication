<html>
<center><h1>Login</h1></center>
<%
	try
	{
		if ((Integer) session.getAttribute("role") == 2) //admin
		{
			out.println("<center>");
			out.println("Go to <a href='http://localhost:8080/Bank/admin.jsp'>Admin</a>");
			out.println("</center>");
			
			out.println("<center>");
			out.println("<a href='http://localhost:8080/Bank/logout.jsp'>Log Out</a>");
			out.println("</center>");
			
		}
		else if((Integer) session.getAttribute("role") == 1) //customer
		{
			out.println("<center>");
			out.println("Go to <a href='http://localhost:8080/Bank/account.jsp'>Account</a>");
			out.println("</center>");
			
			out.println("<center>");
			out.println("<a href='http://localhost:8080/Bank/logout.jsp'>Log Out</a>");
			out.println("</center>");
		}
	}

	catch (Exception e)
	{
		out.println("<center>");
		
		out.println("<a href='http://localhost:8080/Bank/loginpage.jsp'>");
		out.println("<button>Login</button>");
		out.println("</a>");
		
		out.println("<br>");
		
		out.println("<a href='http://localhost:8080/Bank/createaccount.html'>");
		out.println("<button>Create Account</button>");
		out.println("</a>");
		
		out.println("<center>");
		
	}
%>
</html>
