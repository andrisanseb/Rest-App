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
<title>Authentification Interface</title>
</head>
<body>
	<%
		if(request.getParameter("btn") != null){
			String first_name = request.getParameter("first_name").toString();
			String last_name = request.getParameter("last_name").toString();
			String username = request.getParameter("username").toString();
			String password = request.getParameter("password").toString();
			String phone = request.getParameter("phone").toString();
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/Auth/Register/"+first_name+"/"+last_name+"/"+username+"/"+password+"/"+phone);
			ClientResponse myresponse = webResource.accept("text/plain").post(ClientResponse.class);
			
			if (myresponse.getStatus() != 200){
				throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
			}
			
			String output = myresponse.getEntity(String.class);
			//den elegxw an einai admin afoy den kanei register
			String redirectURL = "./StartPage.jsp";
		    response.sendRedirect(redirectURL);
		}
	%>
	
	<form>
		<h4>Registration Form</h4>
		<br><br>
		first name: <input type="text" name="first_name" value=""><br><br>
		<br><br>
		last name: <input type="text" name="last_name" value=""><br><br>
		<br><br>
		username: <input type="text" name="username" value=""><br><br>
		<br><br>
		password: <input type="text" name="password" value=""><br><br>
		<br><br>
		phone: <input type="text" name="phone" value=""><br><br>
		<br><br>
		
		<input type="submit" name="btn" value="Register">
	</form>


</body>
</html>