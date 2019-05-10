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
			
			
			if (withdrawAmountCheck.trim().equals("") )
			{
				out.println("<script>");
				out.println("window.alert('No Withdraw Amount Specified');");
				out.println("</script>");
				
				error = true;
			}
			
			if (error == true)
			{
				out.println("Return <a href='http://localhost:8080/Bank/home.jsp'>Home</a>");
			}
			else
			{
				try
				{
					if (Double.parseDouble(balance) - Double.parseDouble(withdrawAmount) < 0)
					{
						out.println("<script>");
						out.println("window.alert('Cant withdraw amount more than balance');");
						out.println("</script>");
					}
					else
					{
						Class.forName("com.mysql.cj.jdbc.Driver");
						con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
						st = con.createStatement();
						
						String s = "insert into transactions values (" + "'" + username + "'" + " , " + withdrawAmount + ", " + "now()" + "," + "'" + "W" + "'" + ")";
						st.executeUpdate(s);
						
						out.println("Withdraw of " + withdrawAmount + " made");
						out.println("<a href='http://localhost:8080/Bank/home.jsp'>Home</a>");
					}
				}
				catch (Exception e)
				{
					out.println("<script>");
					out.println("window.alert('Non numeric value entered');");
					out.println("</script>");
				}
			}
		}
		else
		{
			out.println("<center>");
			out.println("You have no permisssion to access this page go <a href='http://localhost:8080/Bank/home.jsp'>Home</a>");
			out.println("</center>");
		}
	}
	catch (Exception e)
	{
				
	}

	
	
%>

</html>