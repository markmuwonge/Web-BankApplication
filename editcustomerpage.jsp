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
			
			String headContent = "<head>" + 
								"<title>Edit Customer | Mark's Bank </title>" + 
								"<link  href='http://localhost:8080/Bank/stylesheet.css' rel='stylesheet' type='text/css'>" + 
						 "</head>";
			
			out.println(headContent);
			
			out.println("<a href='http://localhost:8080/Bank/homepage.jsp' style='text-decoration:none'><h1><center>Mark's Bank</center></h1></a>");
			
			String selectedCustomerAcNo = request.getParameter("acNo");
			
			Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
				
			rs = st.executeQuery("select * from accounts where AcNo=" + "'" + selectedCustomerAcNo + "'");
			rs.next();
			
			Statement st2 = con.createStatement();
			ResultSet rs2 = st2.executeQuery("select Password from users where AcNo=" + "'" + selectedCustomerAcNo + "'");
			rs2.next();
			
			out.println("<div class='box2'>");
				out.println("<center><h2>Edit Customer</h2></center>");
				out.println("<center><h3>AcNo:"+selectedCustomerAcNo+"</h3></center>");
				
				out.println("<form action='http://localhost:8080/Bank/editcustomer.jsp' method='post' id='editcustomer'>");
					out.println("<center>");
					out.println("<input type='hidden' value=" + "'" + selectedCustomerAcNo + "'" + " name='acNo'>");
					out.println("<td><input value=" + "'" + rs.getString(2) + "'" + " name='name' placeholder='Name'class='formTextField'></td>");
					out.println("<td><input value=" + "'" + rs.getString(3) + "'" + " name='address' placeholder='Address' class='formTextField'></td>");
					out.println("<td><input value=" + "'" + rs2.getString(1) + "'" + " name='password' placeholder='Password' class='formTextField'></td>");
					
					out.println("<a href='http://localhost:8080/Bank/adminpage.jsp'>");
						out.println("<div class='redBtn'><center>Cancel</center></div>");
					out.println("</a>");
					
					out.println("<a href='#' onclick=document.getElementById('editcustomer').submit()>");
						out.println("<div class='greenBtn'><center>Submit</center></div>");
					out.println("</a>");
				out.println("</form>");
			out.println("</div>");
			
			out.println("<center>");
			
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