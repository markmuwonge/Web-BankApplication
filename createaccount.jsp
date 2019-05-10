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
	
	if (nameCheck.trim().equals("") )
	{
		out.println("<script>");
		out.println("window.alert('Name is missing');");
		out.println("</script>");
		
		error = true;
		
		
	}
	if (addressCheck.trim().equals(""))
	{
		out.println("<script>");
		out.println("window.alert('Address is missing');");
		out.println("</script>");
		
		error = true;
		
	}
	if (passwordCheck.trim().equals(""))
	{
		out.println("<script>");
		out.println("window.alert('Password is missing');");
		out.println("</script>");
		
		error = true;
		
	}
	if (accountType == null || accountType.isEmpty())
	{
		out.println("<script>");
		out.println("window.alert('Account Type is missing');");
		out.println("</script>");
		
		error = true;
		
	}
	if (gender == null || gender.isEmpty())
	{
		out.println("<script>");
		out.println("window.alert('Gender is missing');");
		out.println("</script>");
		
		error = true;
	}
	
	if (error == true)
	{
		out.println("Return <a href='http://localhost:8080/Bank/home.jsp'>Home</a>");
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
			
			out.println("Account " + accNo + " created");
			out.println("<a href='http://localhost:8080/Bank/loginpage.jsp'>Login</a>");
		}
		catch (Exception e)
		{
			
		}
	}
%>

</html>