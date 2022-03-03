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
<title>Start Page</title>
</head>
<body>
	<%
		if(request.getParameter("cheapest-btn") != null){
			String redirectURL = "./CheapestOptions.jsp";
		    response.sendRedirect(redirectURL);
		}
		if(request.getParameter("booking-btn") != null){
			String redirectURL = "./MakeBooking.jsp";
		    response.sendRedirect(redirectURL);
		}
		if(request.getParameter("fav-btn") != null){
			String redirectURL = "./Favorites.jsp";
		    response.sendRedirect(redirectURL);
		}
		if(request.getParameter("rev-btn") != null){
			String redirectURL = "./AddReview.jsp";
		    response.sendRedirect(redirectURL);
		}
		if(request.getParameter("out-btn") != null){
			AuthentificationInterface.uid = 0;	//cancel current user
			String redirectURL = "./LoginPage.jsp";	
		    response.sendRedirect(redirectURL);
		}
	
	
	%>

	<h1>Travel Agency Athens</h1>
	<p>Plan your next dream vacation in Greece</p>
	<br><br>
	<form>
	Travelling on a budget? We got you! <br>
		<input type="submit" name="cheapest-btn" value="Cheapest Options">
		<br><br>
		<input type="submit" name="booking-btn" value="Buy tickets">
		<br><br>
		Your dream destinations. <br>
		<input type="submit" name="fav-btn" value="Favorites">
		<br><br>
		Your opinion matters. <br>
		<input type="submit" name="rev-btn" value="Review Destination">
		<br><br>
		<input type="submit" name="out-btn" value="Log Out">
		<br><br>
	</form>
	

</body>
</html>