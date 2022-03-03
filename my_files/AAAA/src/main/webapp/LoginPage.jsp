<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import="my.restful.services.AuthentificationInterface" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="./styles.css" rel="stylesheet" type="text/css">
<title>Login Page</title>
</head>
<body>
	<%
		if(request.getParameter("btn") != null){
			String username = request.getParameter("username").toString();
			String password = request.getParameter("password").toString();
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/Auth/Login/"+username+"/"+password);
			ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			
			if (myresponse.getStatus() != 200){
				throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
			}
			
			String output = myresponse.getEntity(String.class);
			
			if(output.equals("Login Successful")){
				if(new AuthentificationInterface().isAdmin(AuthentificationInterface.uid)){
					System.out.println("WELCOME ADMIN!");
					String redirectURL = "./AdminHomePage.jsp";
				    response.sendRedirect(redirectURL);
					
				}else{
					String redirectURL = "./StartPage.jsp";
				    response.sendRedirect(redirectURL);
				}
		
			}
		}
		if(request.getParameter("reg-btn") != null){
			String redirectURL = "./Register.jsp";
		    response.sendRedirect(redirectURL);
		}
	%>
	
	<form>
		<h2>Login Form</h2>
		<br><br>
		username:<br> <input type="text" name="username" value=""><br><br>
		password: <br><input type="password" name="password" value=""><br><br>
		<br><br>
		<input type="submit" name="btn" value="Login">
		<br><br>
		<br><br>
		<br><br>
		no account yet? <br><input type="submit" name="reg-btn" value="Register">
	</form>


</body>
</html>