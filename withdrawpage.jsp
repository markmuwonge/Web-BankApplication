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
	
	DecimalFormat df = new DecimalFormat("0.00");
	
	try
	{
		String username = (String) session.getAttribute("username");
		if (((Integer) session.getAttribute("role") == 1) && username.equals(request.getParameter("acNo")))
		{
			String headContent = "<head>" + 
								"<title>Withdraw | Mark's Bank </title>" + 
								"<link  href='http://localhost:8080/Bank/stylesheet.css' rel='stylesheet' type='text/css'>" + 
						 "</head>";
			
			out.println(headContent);
			
			out.println("<a href='http://localhost:8080/Bank/homepage.jsp' style='text-decoration:none'><h1><center>Mark's Bank</center></h1></a>");
			
			
			double balance = 0;
			Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
			

			rs = st.executeQuery("select * from transactions where AcNo=" + "'" + username + "'" + "");
			
			while (rs.next()==true)
			{		
				if (rs.getString(4).equals("D"))
				{
					balance = balance + rs.getDouble(2);
				}
				else
				{
					balance = balance - rs.getDouble(2);
				}
				
			} 
			
			String accountNumber =  request.getParameter("acNo");
			
			
			out.println("<center>");
				out.println("<h2>Account Number: " + accountNumber + "</h2>");	
				out.println("<h3>Balance: " + df.format(balance) + "</h3>");
				
				out.println("<div class='box3'>");
					out.println("<center><h2>Withdraw</h2></center>");
						out.println("<form action='http://localhost:8080/Bank/withdraw.jsp' method='post' id='withdraw'>");
						out.println("<center>");
						out.println("<input name='withdrawamount'  placeholder='Withdraw Amount' class='formTextField'>");
						out.println("<td><input type='hidden' name='balance' value=" + balance + "></td>");
						out.println("<td><input type='hidden' name='acNo' value=" + username + "></td>");
						
						out.println("<a href='http://localhost:8080/Bank/accountpage.jsp?username=" + username + "'>");
							out.println("<div class='redBtn'><center>Cancel</center></div>");
						out.println("</a>");
						
						out.println("<a href='#' onclick=document.getElementById('withdraw').submit();>");
							out.println("<div class='greenBtn'><center>Submit</center></div>");
						out.println("</a>");
						
					out.println("</center>");
				out.println("</div>");
				
				out.println("<div style='position: fixed ; bottom: 0; left:0, right:0; width:100%;'>");
					out.println("<a href='http://localhost:8080/Bank/logout.jsp' style='text-decoration:none'>");
								out.println("<div class='redBtn2'><center>Log Out</center></div>");
					out.println("</a>");
				out.println("</div>");
			
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