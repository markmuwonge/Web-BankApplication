<html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%

	Connection con;
    Statement st;
    ResultSet rs;
	
	if ((Integer) session.getAttribute("role") == 2)
	{
		int lineNumber = 1;
		
		Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
		con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
		st = con.createStatement();
			
		rs = st.executeQuery("select * from accounts");
		
		out.println("<table border='1'>");
		out.println("<tr><td>S.No</td><td>Account Number</td><td>Name</td><td>Operations</td></tr>");
		while (rs.next()==true)
		{
			if (!(rs.getString(1).equals("Admin")))
			{
				
				out.println("<tr>");
				out.println("<td>" + lineNumber + "</td>");
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>" + rs.getString(2) + "</td>");
				out.println("<td><a href='#'>Edit</a>|<a href='#'>Block</a>|<a href='#'>Delete</a></td>");
				out.println("</tr>");
			
				lineNumber++;
			}
		}
		out.println("</table>");
		
		
	}
%>
</html>