<html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<%
	try
	{
		if ((Integer) session.getAttribute("role") == 2)
		{
			String accountNumber = request.getParameter("acNo");
			String name = request.getParameter("name");
			String address = request.getParameter("address");
			String password = request.getParameter("password");
			
			String nameCheck = name + " "; //prevent null exception if value missing
			String addressCheck = address + " ";
			String passwordCheck = password + " ";
			
			boolean error = false;
			
			Connection con;
			Statement st;
			ResultSet rs;
	
			if (nameCheck.trim().equals(""))
			{
				out.println("<script>");
				out.println("window.alert('Name is missing');");
				out.println("</script>");
				
				error = true;
				
				
			}
			if (addressCheck.trim().equals(""))
			{
				out.println("<script>");
				out.println("window.alert('Address is missing');");
				out.println("</script>");
				
				error = true;
				
			}
			if (passwordCheck.trim().equals(""))
			{
				out.println("<script>");
				out.println("window.alert('Password is missing');");
				out.println("</script>");
				
				error = true;
			}
			
			if (error == true)
			{
				out.println("Return <a href='http://localhost:8080/Bank/adminpage.jsp'>Admin</a>");
				
			}
			else
			{
				try
				{
					Class.forName("com.mysql.cj.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
					st = con.createStatement();
					
					String s = "update accounts set Name=" + "'" + name + "'" + ", Address=" + "'" + address + "'" + " where AcNo=" + "'" + accountNumber + "'" + "";
					st.executeUpdate(s);
					
					s = "update users set Password=" + "'" + password + "'" + "where AcNo=" + "'" + accountNumber + "'" + ""; 
					st.executeUpdate(s);
					
					con.close();
					
					response.sendRedirect("http://localhost:8080/Bank/adminpage.jsp");
					return; 
				}
				catch (Exception e)
				{
					
				}
			}
			
			
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