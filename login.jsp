<html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	boolean error = false;
	
	Connection con;
    Statement st;
    ResultSet rs;
	
	if (username.trim().equals(""))
	{
		out.println("<script>");
		out.println("window.alert('User name is missing');");
		out.println("</script>");
		
		error = true;
		
		
	}
	if (password.trim().equals(""))
	{
		out.println("<script>");
		out.println("window.alert('Password is missing');");
		out.println("</script>");
		
		error = true;
		
	}	
	if (error == true)
	{
		out.println("Return <a href='http://localhost:8080/Bank/home.html'>Home</a>");
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
							
							out.println("Go to <a href='http://localhost:8080/Bank/admin.jsp'>Admin</a>");
							
						}
						else //customer
						{
							out.println("<script>");
							out.println("window.alert('Customer Found');");
							out.println("</script>");
						}
					}
					else
					{
						out.println("<script>");
						out.println("window.alert('Account Blocked');");
						out.println("</script>");
					}

				}
				else
				{
					out.println("<script>");
					out.println("window.alert('Invalid Credentials');");
					out.println("</script>");
				}

			}
			else
			{
				out.println("<script>");
				out.println("window.alert('Account Not Found');");
				out.println("</script>");
			}
		}
		catch (Exception e)
		{
			
		}
		
	}
%>

</html>