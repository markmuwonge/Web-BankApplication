<html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%

	Connection con;
    Statement st;
    ResultSet rs;
	
	int lineNumber = 1;
	String statusToShow = "";
	try
	{
		if ((Integer) session.getAttribute("role") == 2) //will throw error if not set
		{
			String headContent = "<head>" + 
								"<title>Admin | Mark's Bank </title>" + 
								"<link  href='http://localhost:8080/Bank/stylesheet.css' rel='stylesheet' type='text/css'>" + 
						 "</head>";
			
			out.println(headContent);
			
			out.println("<a href='http://localhost:8080/Bank/homepage.jsp' style='text-decoration:none'><h1><center>Mark's Bank</center></h1></a>");
			
			Class.forName("com.mysql.cj.jdbc.Driver"); //xamp...tomcat...lib..(jar file driver)
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
				
			rs = st.executeQuery("select * from accounts");
			
			out.println("<center>");
			
			out.println("<h2>Customers</h2>");
			
			out.println("<table border='1' id='tbl'>");
			out.println("<tr><td>S.No</td><td>Account Number</td><td>Name</td><td>Operations</td></tr>");
			while (rs.next()==true)
			{
				if (!(rs.getString(1).equals("Admin")))
				{
					out.println("<tr>");
					out.println("<td>" + lineNumber + "</td>");
					out.println("<td>" + rs.getString(1) + "</td>");
					out.println("<td>" + rs.getString(2) + "</td>");
					
					Statement st2 = con.createStatement();
					ResultSet rs2 = st2.executeQuery("select Active from users where AcNo=" + "'" + rs.getString(1) + "'" + "");
					rs2.next();
					
					
					if (rs2.getInt(1) == 1)
					{
						statusToShow = "Block";
					}
					else
					{
						statusToShow = "Activate";
					}
					
					out.println("<td><a href='http://localhost:8080/Bank/editcustomerpage.jsp?acNo=" +rs.getString(1)+ "'>Edit</a>|<a href='http://localhost:8080/Bank/blockoractivatecustomer.jsp?acNo=" +rs.getString(1)+ "&blockoractivate=" + statusToShow + " '>"+ statusToShow + "</a>|<a href='http://localhost:8080/Bank/deletecustomer.jsp?acNo=" +rs.getString(1)+ "'>Delete</a></td>");
					out.println("</tr>");
				
					lineNumber++;
				}
			}
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

	catch(Exception e)
	{
		out.println("<center>");
		out.println("You have no permisssion to access this page go <a href='http://localhost:8080/Bank/homepage.jsp'>Home</a>");
		out.println("</center>");
	}
%>
</html>