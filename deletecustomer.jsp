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
		if ((Integer) session.getAttribute("role") == 2)
		{
			String accountNumber = request.getParameter("acNo");
			
			try
			{
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
				st = con.createStatement();
					
				String s = "delete from users where AcNo=" + "'" + accountNumber + "'" + "";
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
	catch(Exception e)
	{
		out.println("<center>");
		out.println("You have no permisssion to access this page go <a href='http://localhost:8080/Bank/homepage.jsp'>Home</a>");
		out.println("</center>");
	}
%>

</html>