<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="my.restful.services.Favorite" %>
<%@ page import="my.restful.services.ManageFavorites" %>
<%@ page import="my.restful.services.Destination" %>
<%@ page import="my.restful.services.DestinationUpdate" %>
<%@ page import="my.restful.services.AuthentificationInterface" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="./styles.css" rel="stylesheet" type="text/css">
<title>Manage my favorite destinations</title>
<style>

table {
margin-left: 300px;
    margin-right: 300px;
    margin-top: 10px;
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

input{
	width:20%;
}

form{
	margin-top:-40px;
}
</style>
</head>
<body>

	<%
		if(request.getParameter("add-btn") != null){
			
			String d_name = request.getParameter("d_name").toString();
			d_name = d_name.replaceAll("\\s", "+");	//in case of whitespace
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/Favorites/AddFav/"+d_name);
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
	
		if(request.getParameter("rem-btn") != null){
			String d_nameD = request.getParameter("d_nameD").toString();
			d_nameD = d_nameD.replaceAll("\\s", "+");	//in case of whitespace
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/Favorites/RemoveFav/"+d_nameD);
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
		
		if(request.getParameter("booking-btn") != null){
			String redirectURL = "./MakeBooking.jsp";
		    response.sendRedirect(redirectURL);
		}

	%>

	<h2>My Favorites</h2>
	<table>
	  <tr>
	    <th>Destinations</th>
	  </tr>
		<% ArrayList<Favorite> favs = new ManageFavorites().getFavs();
		for (int i=0; i<favs.size();i++){ %>
			<% Favorite fav = favs.get(i);%>
			  <tr>
			    <td><%=fav.getD_name() %></td>
			  </tr>
			<% } %>
	</table>
	<br><br>
	
	
	<form>
		<h3>Add a destination to favorites</h3>
		<br>
		<label for="d_name"></label>
		<select name="d_name" id="d_name">
		<% ArrayList<Destination> ddd = new DestinationUpdate().getAllDest();
		for (int i=0; i<ddd.size();i++){ %>
				<% Destination d = ddd.get(i); %>
				<% boolean already = new ManageFavorites().isAlreadyFav(d.getD_id());%>
				<% if(!already){ %>
					<option value="<%=d.getD_name() %>"><%=d.getD_name() %></option>
			<% } }%>
			</select>
			<input type="submit" name="add-btn" value="Add to Favorites">
	</form>	
	<br><br>
	
	<form>
			<h3>Remove destination from favorites:</h3>
		<br>
		<label for="d_nameD"></label>
		<select name="d_nameD" id="d_nameD">
		<% ArrayList<Destination> dd = new DestinationUpdate().getAllDest();
		for (int i=0; i<dd.size();i++){ %>
				<% Destination d1 = dd.get(i); %>
				<% boolean already = new ManageFavorites().isAlreadyFav(d1.getD_id());%>
				<% if(already){ %>
					<option value="<%=d1.getD_name() %>"><%=d1.getD_name() %></option>
			<% } }%>
			</select>
			<input type="submit" name="rem-btn" value="Remove Favorite">
	</form>	
	<br><br>
	<br><br>
	<form>
		<input type="submit" name="booking-btn" value="Go to Make a Booking Page">
		<br><br><br>
		<input type="submit" name="home-btn" value="HomePage">
	</form>
	
	

</body>
</html>