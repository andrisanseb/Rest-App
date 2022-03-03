<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="my.restful.services.Destination" %>
<%@ page import="my.restful.services.DestinationUpdate" %>
<%@ page import="my.restful.services.TransportationOption" %>
<%@ page import="my.restful.services.SomeSelects" %>
<%@ page import="my.restful.services.AuthentificationInterface" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="./styles.css" rel="stylesheet" type="text/css">
<title>Make a booking</title>
<style>

table {
	margin-top:-50px;
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 60%;
  margin-left: auto;
  margin-right: auto;
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
		if(request.getParameter("btn") != null){
			
			int t_id = Integer.parseInt(request.getParameter("t_id"));
			int total_tickets = Integer.parseInt(request.getParameter("total_tickets"));
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/Booking/MakeBooking/"+t_id+"/"+total_tickets);
			ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			
			if (myresponse.getStatus() != 200){
				throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
			}
			
			String output = myresponse.getEntity(String.class);
			out.println(output);
			
			%><script type="text/javascript">
			window.location = window.location.href.split("?")[0];
			</script> <%
		}
	
		if(request.getParameter("home-btn") != null){
			String redirectURL = "./StartPage.jsp";	
		    response.sendRedirect(redirectURL);
		}
	%>

<table>
	<h2>Transportation Offers</h2>
	<br>
	  <tr>
	  	<th>Offer number</th>
	  	<th>Destination</th>
	    <th>Travel method</th>
	    <th>Price (1 person)</th>
	     <th>Trip duration</th>
	    <th>Month Available</th>
	  </tr>
		<% ArrayList<TransportationOption> opts = new SomeSelects().getAllOffers();
		for (int i=0; i<opts.size();i++){ %>
			<% TransportationOption opt = opts.get(i);%>
			  <tr>
			  	<td><%=opt.getT_id() %></td>
			    <td><%=opt.getD_name() %></td>
			    <td><%=opt.getWay()%></td>
			    <td><%=opt.getPrice()%></td>
			    <td><%=opt.getDuration()%></td>
			    <td><%=opt.getMonth()%></td>
			  </tr>
			<% } %>
	</table>
	<br><br>
	<form style="text-align:center;">
		<h4>Booking Form</h4><br>
		offer number: <br><input type="text" name="t_id" value="">
		<br><br>
		number of persons: <br><input type="text" name="total_tickets" value="">
		<br><br>
		paypal code: <br><input type="text" name="paypal" value="">
		<br><br>
		<input type="submit" name="btn" value="Make Booking">
		<br><br><br>
		<input type="submit" name="home-btn" value="HomePage">
	</form>

</body>
</html>