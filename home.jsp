<html>
	
<%!
	public String getBody(String button1, String button2, String link1, String link2)
	{
				String bodyContent = "<body>" +
								"<h1><center>Mark's Bank</center></h1>" + 
								"<div class='box'>" + 
									"<center><h1>Home</h1></center>" +
									"<a href=" + "'" + link1 + "'" + " >" + 
										"<div class='loginBtn'><center>" + button1 + "</center></div>" + 
									"</a>" + 
									"<a href=" + "'" + link2 + "'" + " >" + 
										"<div class='loginBtn'><center>" + button2 + "</center></div>" + 
									"</a>" + 
								"</div>" + 
						"</body>";
			return bodyContent;
	}
%>
<%

	String[] buttons = {"Login", "Create Account", "Admin", "Log Out", "Account"};
	String[] links = {"http://localhost:8080/Bank/loginpage.jsp", "http://localhost:8080/Bank/createaccount.html", "http://localhost:8080/Bank/admin.jsp", "http://localhost:8080/Bank/logout.jsp", "http://localhost:8080/Bank/account.jsp"};
	
	String headContent = "<head>" + 
								"<title>Home | Mark's Bank </title>" + 
								"<link  href='http://localhost:8080/Bank/stylesheet.css' rel='stylesheet' type='text/css'>" + 
						 "</head>";
				
	try
	{
		if ((Integer) session.getAttribute("role") == 2) //admin
		{
	
			out.println(headContent);
		
			String body = getBody(buttons[2], buttons[3], links[2], links[3]);

			out.println(body);	
			
		}
		else if((Integer) session.getAttribute("role") == 1) //customer
		{
			out.println(headContent);
		
			String body = getBody(buttons[4], buttons[3], links[4], links[3]);

			out.println(body);	
		}
	}

	catch (Exception e)
	{
		out.println(headContent);
	
		String body = getBody(buttons[0], buttons[1], links[0], links[1]);

		out.println(body);	
	}
%>

</html>
