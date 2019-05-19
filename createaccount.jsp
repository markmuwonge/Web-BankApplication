<html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String password = request.getParameter("password");
	String accountType = request.getParameter("accountType");
	String gender = request.getParameter("gender");
	
	String nameCheck = name + " "; //prevent null exception if value missing
	String addressCheck = address + " ";
	String passwordCheck = password + " ";
	
	boolean error = false;
	
	Connection con;
    Statement st;
    ResultSet rs;
	
	if (nameCheck.trim().equals(""))
	{	
		error = true;	
	}
	if (addressCheck.trim().equals(""))
	{
		error = true;	
	}
	if (passwordCheck.trim().equals(""))
	{
	
		error = true;
		
	}
	if (accountType == null || accountType.isEmpty())
	{
		error = true;
		
	}
	if (gender == null || gender.isEmpty())
	{
		error = true;
	}
	
	if (error == true)
	{
		response.sendRedirect("http://localhost:8080/Bank/createaccountpage.html");
		return; 
	}
	else
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/marks_test_db_2", "root", "");
			st = con.createStatement();
				
			rs = st.executeQuery("select concat("+ "'"+ accountType + "'" + "," + "'" + gender + "'" + ", (select lpad((select ifnull((SELECT max(substr(AcNo, 3, 3)) from users as t where substr(AcNo, 1, 1) = " + "'" +accountType + "'" + "), 0) + 1), 3, '0')))");
            rs.next();         
            String accNo = rs.getString(1);
			
			String s = "insert into users values "+ "((select concat("+ "'"+ accountType + "'" + "," + "'" + gender + "'" + ", (select lpad((select ifnull((SELECT max(substr(AcNo, 3, 3)) from users as t where substr(AcNo, 1, 1) = " + "'" +accountType + "'" + "), 0) + 1), 3, '0')))), " + "'" + password + "'" + "," +  1 + "," + 1 + ")";
            st.executeUpdate(s);
			
			String s2 = "insert into accounts values (" + "'" + accNo + "'" + " , " + "'" + name + "'" + ", " + "'" + address + "'" + ")";
			st.executeUpdate(s2);
			
			con.close();
			
			out.println("<script>");
				out.println("window.alert('Your username is: " + accNo + "' );");	
				out.println("window.location= 'http://localhost:8080/Bank/loginpage.jsp';");
			out.println("</script>");
		}
		catch (Exception e)
		{
			
		}
	}
%>

</html>