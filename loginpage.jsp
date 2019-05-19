<html>
	
<%
	try
	{
		if ((Integer) session.getAttribute("role") == 2) //admin
		{
			response.sendRedirect("http://localhost:8080/Bank/admin.jsp");
			return; 
		}
		else if((Integer) session.getAttribute("role") == 1) //customer
		{
			String username = (String) session.getAttribute("username");
			response.sendRedirect("http://localhost:8080/Bank/accountpage.jsp?username=" + username + "");
			return; 
		}
	}

	catch (Exception e)
	{
		String headContent = "<head>" + 
								"<title>Login | Mark's Bank </title>" + 
								"<link  href='http://localhost:8080/Bank/stylesheet.css' rel='stylesheet' type='text/css'>" + 
						 "</head>";
		out.println(headContent);
		
		out.println("<body>");
			out.println("<a href='http://localhost:8080/Bank/homepage.jsp' style='text-decoration:none'><h1><center>Mark's Bank</center></h1></a>");
			out.println("<div class='box3'>");
				out.println("<center><h2>Login</h2></center>");
				out.println("<form action='http://localhost:8080/Bank/login.jsp' method='post' id='logIn'>");
					out.println("<center>");
						out.println("<input name='username' placeholder='Username' class='formTextField'>");
						out.println("<input name='password' type='password' placeholder='Password' class='formTextField'>");
						
						out.println("<a href='http://localhost:8080/Bank/homepage.jsp'>");
							out.println("<div class='redBtn'><center>Cancel</center></div>");
						out.println("</a>");
						
						out.println("<a href='#' onclick=document.getElementById('logIn').submit();> ");
							out.println("<div class='greenBtn'><center>Submit</center></div>");
						out.println("</a>");
						
					out.println("</center>");
				out.println("</form>");
				
		out.println("</body>");
	}
%>
	
</html>