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
			
			Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
				
			rs = st.executeQuery("select * from accounts where AcNo=" + "'" + selectedCustomerAcNo + "'");
			rs.next();
			
			Statement st2 = con.createStatement();
			ResultSet rs2 = st2.executeQuery("select Password from users where AcNo=" + "'" + selectedCustomerAcNo + "'");
			rs2.next();
			
			out.println("<form action='http://localhost:8080/Bank/editcustomervalidation.jsp' method='post'>");
			out.println("<center>");
			out.println("<h1>AcNo:"+selectedCustomerAcNo+"</h1>");
			out.println("<input type='hidden' value=" + "'" + selectedCustomerAcNo + "'" + " name='acNo'>");
			out.println("<table>");
			out.println("<tr>");
			
			out.println("<td>Name:</td>");
			out.println("<td><input value=" + "'" + rs.getString(2) + "'" + " name='name'></td>");
			out.println("</tr>");
			
			out.println("<td>Address:</td>");
			out.println("<td><input value=" + "'" + rs.getString(3) + "'" + " name='address'></td>");
			out.println("</tr>");
		
			out.println("<td>Password:</td>");
			out.println("<td><input value=" + "'" + rs2.getString(1) + "'" + " name='password'></td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td><a href='http://localhost:8080/Bank/admin.jsp'><input type='button' value=Cancel></a></td>");
			out.println("<td><input type='submit'></td>");
			out.println("</tr>");
			out.println("</form>");
			
			

		}
	}
	catch (Exception e)
	{
		out.println("<center>");
		out.println("You have no permisssion to access this page go <a href='http://localhost:8080/Bank/home.jsp'>Home</a>");
		out.println("</center>");
	}
%>
</html>