<html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<%@ page import="java.text.DecimalFormat" %>

<%
	Connection con;
    Statement st;
    ResultSet rs;
	
	int lineNumber = 1;
	double balance = 0;
	
	DecimalFormat df = new DecimalFormat("0.00");
	
	try
	{ 
		String username = (String) session.getAttribute("username");
		if (((Integer) session.getAttribute("role") == 1) && username.equals(request.getParameter("username")))
		{
			String headContent = "<head>" + 
								"<title>Account | Mark's Bank </title>" + 
								"<link  href='http://localhost:8080/Bank/stylesheet.css' rel='stylesheet' type='text/css'>" + 
						 "</head>";
			
			out.println(headContent);
		
			out.println("<a href='http://localhost:8080/Bank/homepage.jsp' style='text-decoration:none'><h1><center>Mark's Bank</center></h1></a>");
	
			
			Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
				
			rs = st.executeQuery("select * from transactions where AcNo=" + "'" + username + "'" + "");
			out.println("<center>");
			out.println("<h2>Account Number: " + username + "</h2>");
			
			out.println("<table border='1' id='tbl'>");
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
					
					balance = balance + rs.getDouble(2);
				}
				else
				{
					balance = balance - rs.getDouble(2);
				}
				
				lineNumber++;
			} 
	
			out.println("<h3>Balance: " + df.format(balance) + "</h3>");
			
			out.println("</table>");
			
			out.println("<table>");	
				out.println("<tr>");
					out.println("<td>");
						out.println("<a href='http://localhost:8080/Bank/withdrawpage.jsp?acNo=" + username + "' style='text-decoration:none'>");
							out.println("<div class='redBtn2'><center>Withdraw</center></div>");
						out.println("</a>");
					out.println("</td>");
			
					out.println("<td>");
						out.println("<a href='http://localhost:8080/Bank/depositpage.jsp?acNo=" + username + "' style='text-decoration:none'>");
							out.println("<div class='greenBtn2'><center>Deposit</center></div>");
						out.println("</a>");
					out.println("</td>");
			
				out.println("<tr>");
			
			out.println("</table>");
			
			out.println("<div style='position: fixed ; bottom: 0; left:0, right:0; width:100%;'>");
				out.println("<a href='http://localhost:8080/Bank/logout.jsp' style='text-decoration:none'>");
								out.println("<div class='redBtn2'><center>Log Out</center></div>");
				out.println("</a>");
			out.println("</div>");
			
			out.println("</center>");
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