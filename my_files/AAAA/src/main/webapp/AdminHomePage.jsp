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
<title>Admin Home Page</title>
</head>
<body>
	<%
		if(request.getParameter("addDest-btn") != null){
			String redirectURL = "./AddDestination.jsp";
		    response.sendRedirect(redirectURL);
		}
		if(request.getParameter("addTr-btn") != null){
			String redirectURL = "./Transportation.jsp";
		    response.sendRedirect(redirectURL);
		}
		if(request.getParameter("delRev-btn") != null){
			String redirectURL = "./DeleteReview.jsp";
		    response.sendRedirect(redirectURL);
		}
		if(request.getParameter("out-btn") != null){
			AuthentificationInterface.uid = 0;	//cancel current user
			String redirectURL = "./LoginPage.jsp";	
		    response.sendRedirect(redirectURL);
		}
	
	
	%>


	<h2>Welcome Admin</h2>
	<form>
		<br><br>
		<input type="submit" name="addDest-btn" value="Add Destination">
		<br><br>
		<input type="submit" name="addTr-btn" value="Add Transportation Offer">
		<br><br>
		<input type="submit" name="delRev-btn" value="Delete Review">
		<br><br>
		<input type="submit" name="out-btn" value="Log-out">
	</form>
</body>
</html>