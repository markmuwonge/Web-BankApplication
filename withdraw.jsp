<html>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%

	Connection con;
    Statement st;
    ResultSet rs;
	
	try
	{
		String username = (String) session.getAttribute("username");
		String withdrawAmount = request.getParameter("withdrawamount");
		String balance = request.getParameter("balance");

		if (((Integer) session.getAttribute("role") == 1) && username.equals(request.getParameter("acNo")))
		{
			String withdrawAmountCheck = withdrawAmount + " "; //prevent null exception if value missing
	
			boolean error = false;
			
			
			if (withdrawAmountCheck.trim().equals("") ) //No Withdraw Amount Specified
			{
				error = true;
				response.sendRedirect("http://localhost:8080/Bank/accountpage.jsp?username=" + username + "");
				return; 			
			}
			
			if (error == true)
			{
				response.sendRedirect("http://localhost:8080/Bank/accountpage.jsp?username=" + username + "");
				return; 
			}
			else
			{
				try
				{
					if (Double.parseDouble(balance) - Double.parseDouble(withdrawAmount) < 0)
					{
						response.sendRedirect("http://localhost:8080/Bank/accountpage.jsp?username=" + username + "");
						return; 
					}
					else
					{
						Class.forName("com.mysql.cj.jdbc.Driver");
						con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
						st = con.createStatement();
						
						String s = "insert into transactions values (" + "'" + username + "'" + " , " + withdrawAmount + ", " + "now()" + "," + "'" + "W" + "'" + ")";
						st.executeUpdate(s);
						
						con.close();
						response.sendRedirect("http://localhost:8080/Bank/accountpage.jsp?username=" + username + "");
						return; 
					}
				}
				catch (Exception e) //non numeric value entered
				{
					response.sendRedirect("http://localhost:8080/Bank/accountpage.jsp?username=" + username + "");
					return; 
				}
			}
		}
		else
		{
			out.println("<center>");
			out.println("You have no permisssion to access this page go <a href='http://localhost:8080/Bank/homepage.jsp'>Home</a>");
			out.println("</center>");
		}
	}
	catch (Exception e)
	{
		out.println("<center>");
		out.println("You have no permisssion to access this page go <a href='http://localhost:8080/Bank/homepage.jsp'>Home</a>");
		out.println("</center>");		
	}

	
	
%>

</html>