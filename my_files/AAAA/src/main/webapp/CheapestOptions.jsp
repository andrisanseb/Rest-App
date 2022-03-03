<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="my.restful.services.SomeSelects" %>
<%@ page import="my.restful.services.TransportationOption" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="./styles.css" rel="stylesheet" type="text/css">
<title>Cheapest Travelling Options</title>
<style>

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
</head>
<body>


	<%		
	
		if(request.getParameter("home-btn") != null){
			String redirectURL = "./StartPage.jsp";	
		    response.sendRedirect(redirectURL);
		}
		
		if(request.getParameter("booking-btn") != null){
			String redirectURL = "./MakeBooking.jsp";
		    response.sendRedirect(redirectURL);
		}
	
	%>




	
	<table>
	<h2>Trips for cheap!</h2>
	<br><br>
	  <tr>
	  	<th>Rank</th>
	    <th>Destination</th>
	    <th>Via</th>
	    <th>Price</th>
	    <th>Month</th>
	  </tr>
		<% ArrayList<TransportationOption> opts = new SomeSelects().getAllTrOptions();
		for (int i=0; i<opts.size();i++){ %>
			<% TransportationOption opt = opts.get(i);%>
			  <tr>
			  	<td><%=i+1%></td>
			    <td><%=opt.getD_name() %></td>
			    <td><%=opt.getWay()%></td>
			    <td><%=opt.getPrice()%></td>
			    <td><%=opt.getMonth()%></td>
			  </tr>
			<% } %>
	</table>
	<br><br>
	<br><br>
	<form>
		<input type="submit" name="booking-btn" value="Make a Booking">
		<br><br>
		<input type="submit" name="home-btn" value="Home Page">
	</form>
	
	

</body>
</html>