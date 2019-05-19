<html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	String usernameCheck = username + " ";
	String passwordCheck = password + " ";
	
	boolean error = false;
	
	Connection con;
    Statement st;
    ResultSet rs;
	
	if (usernameCheck.trim().equals(""))
	{
		error = true;	
	}
	if (passwordCheck.trim().equals(""))
	{
		error = true;
	}	
	if (error == true)
	{	
		response.sendRedirect("http://localhost:8080/Bank/loginpage.jsp");
	}
	else
	{	
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
			
			rs = st.executeQuery("select * from users where AcNo="+ "'" + username + "'" + "");
			
			if (rs.next() == true)
			{
				if (rs.getString(2).equals(password))
				{
					if (rs.getInt(4) == 1) //role '1' active account
					{
						if (rs.getInt(3) == 2) //admin
						{
							
							ResultSet rs2 = st.executeQuery("select Name from accounts where AcNo="+ "'" + rs.getString(1) + "'" + "");
							rs2.next();
							
							
							
							session.setAttribute("username", username);
							session.setAttribute("role", 2);
							session.setAttribute("name", rs2.getString(1));
							
							con.close();
							
							response.sendRedirect("http://localhost:8080/Bank/adminpage.jsp");
							return; 
							
						}
						else //customer -> rs.getInt(3) == 1
						{
							ResultSet rs2 = st.executeQuery("select Name from accounts where AcNo="+ "'" + rs.getString(1) + "'" + "");
							rs2.next();
							
							
							
							session.setAttribute("username", username);
							session.setAttribute("role", 1);
							session.setAttribute("name", rs2.getString(1));
							
							con.close();
							
							response.sendRedirect("http://localhost:8080/Bank/accountpage.jsp?username=" + username + "");
							return; 
							
						}
					}
					else //account blocked
					{
						con.close();
						response.sendRedirect("http://localhost:8080/Bank/loginpage.jsp");
						return; 
					}

				}
				else //invalid credentials
				{
					con.close();
					response.sendRedirect("http://localhost:8080/Bank/loginpage.jsp");
					return; 
				}

			}
			else //account not found
			{
				con.close();
				response.sendRedirect("http://localhost:8080/Bank/loginpage.jsp");
				return; 
			}
		}
		catch (Exception e)
		{
			
		}
		
	}
%>

</html>