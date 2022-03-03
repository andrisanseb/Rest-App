<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="my.restful.services.Destination" %>
<%@ page import="my.restful.services.DestinationUpdate" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="./styles.css" rel="stylesheet" type="text/css">
<title>Add Review Page</title>
</head>
<body>

	<%
		if(request.getParameter("btn") != null){
			
			String d_name = request.getParameter("d_name").toString();
			String review = request.getParameter("review").toString();
			d_name = d_name.replaceAll("\\s", "+");	//in case of whitespace
			
			int stars = Integer.parseInt(request.getParameter("stars"));
			if (review.equals("")){
				review = "null";	//sto db tha perastei adeio string
			}else{
				review = review.replaceAll("\\s", "+");	//in case of whitespace
			}
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/Reviews/AddReview/"+d_name+"/"+stars+"/"+review);
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

	<form>
		<h2>Review a destination</h2>
		<br><br>
		<label for="d_name">Destination:<br></label>
		<select name="d_name" id="d_name">
		<% ArrayList<Destination> ddd = new DestinationUpdate().getAllDest();
		for (int i=0; i<ddd.size();i++){ %>
				<% Destination d = ddd.get(i);%>
					Destination: <option value="<%=d.getD_name() %>"><%=d.getD_name() %></option>
			<% } %>
			</select>
		<br><br>	
		<label for="stars">Stars:<br></label>
		<select name="stars" id="stars">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
		</select>
		<br><br>	
		<label for="review">Describe your experience(Optional):</label>
		<br><br>
			<textarea id="review" name="review" rows="4" cols="40"></textarea>
		<br><br>	
		<input type="submit" name="btn" value="Add Review">
		<br><br>
	</form>
	
		<form>
		<br><br><br>
			<input type="submit" name="booking-btn" value="Go to Make a Booking Page">
			<br><br>
			<input type="submit" name="home-btn" value="Home Page">
		</form>
	
</body>
</html>