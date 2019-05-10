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
		if (((Integer) session.getAttribute("role") == 1) && username.equals(request.getParameter("acNo")))
		{
			double balance = 0;
			Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
				
			rs = st.executeQuery("select * from transactions where AcNo=" + "'" + username + "'" + "");
			out.println("<a href='http://localhost:8080/Bank/home.jsp'><button style='float:left'>Home</button></a>");
			while (rs.next()==true)
			{		
				if (rs.getString(4).equals("D"))
				{
					balance = balance + rs.getInt(2);
				}
				else
				{
					balance = balance - rs.getInt(2);
				}
				
			} 
			
			String accountNumber =  request.getParameter("acNo");
			out.println("<center>");
			out.println("Account Number: " + accountNumber);
			out.println("<br>");	
			out.println("<td>Current Balance: " + balance + "</td>");
			out.println("<br>");
			
			out.println("<form action='http://localhost:8080/Bank/processwithdraw.jsp' method='post'>");
			out.println("Withdraw Amount: ");
			out.println("<input name='withdrawamount'>");
			out.println("<td><input type='hidden' name='balance' value=" + balance + "></td>");
			out.println("<td><input type='hidden' name='acNo' value=" + username + "></td>");
			out.println("<td><input type='submit'></td>");
			out.println("</center>");
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