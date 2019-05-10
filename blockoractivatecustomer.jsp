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
			String selectedCustomerAcNo = request.getParameter("acNo");
			String blockoractivate = request.getParameter("blockoractivate");
			int action = 0;
			
			if (blockoractivate.equals("Block"))
			{
				action = 0;
			}
			else
			{
				action = 1;
			}
			
			Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
			
			String s = "update users set Active=" + action + " where AcNo=" + "'" + selectedCustomerAcNo + "'" + "";
			st.executeUpdate(s);
			
			if (action == 0)
			{
				out.println("<center>Block successful return to <a href='http://localhost:8080/Bank/admin.jsp'>Admin</a></center>");
			}
			else
			{
				out.println("<center>Activation successful return to <a href='http://localhost:8080/Bank/admin.jsp'>Admin</a></center>");
			}
		}
	}
	catch(Exception e)
	{
		out.println("<center>");
		out.println("You have no permisssion to access this page go <a href='http://localhost:8080/Bank/home.jsp'>Home</a>");
		out.println("</center>");
	}
%>

</html>