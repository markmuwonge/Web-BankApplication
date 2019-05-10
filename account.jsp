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
		if (((Integer) session.getAttribute("role") == 1) && username.equals(request.getParameter("username")))
		{
			int lineNumber = 1;
			double balance = 0;
			
			Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
				
			rs = st.executeQuery("select * from transactions where AcNo=" + "'" + username + "'" + "");
			
			out.println("<center>");
			out.println("Account Number: " + username);
			out.println("<br>");		
			out.println("<a href='http://localhost:8080/Bank/home.jsp'><button style='float:left'>Home</button></a>");
			out.println("<table border='1'>");
			out.println("<tr><td>S.No</td><td>Transaction Type</td><td>Date/Time</td><td>Amount</td></tr>");
			while (rs.next()==true)
			{
				out.println("<tr>");
				out.println("<td>" + lineNumber + "</td>");
				out.println("<td>" + rs.getString(4) + "</td>");
				out.println("<td>" + rs.getString(3) + "</td>");
				out.println("<td>" + rs.getString(2) + "</td>");
				out.println("</tr>");
				
				if (rs.getString(4).equals("D"))
				{
					balance = balance + rs.getInt(2);
				}
				else
				{
					balance = balance - rs.getInt(2);
				}
				
				lineNumber++;
			} 
			out.println("Balance: " + balance);
			
			out.println("</table>");
			
			out.println("<a href='http://localhost:8080/Bank/withdraw.jsp?acNo=" + username + "'>Withdraw</a>");
			out.println("<a href='deposit.jsp?acNo=" + username + "'>Deposit</a>");
			
			out.println("</center>");
			
			
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