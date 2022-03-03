<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="my.restful.services.Review" %>
<%@ page import="my.restful.services.ReviewsServices" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="./styles.css" rel="stylesheet" type="text/css">
<title>Admin-Delete Review</title>
<style>
	*{
		margin-top:90px;
	}
	select{
		width:70%;
	}
</style>
</head>
<body>
	<%
		if(request.getParameter("btn") != null){
			int r_id = Integer.parseInt(request.getParameter("r_id"));
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/Reviews/DeleteReview/"+r_id);
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

	%>



	<form>
		<h2>Select Review you want to delete</h2>
		<br><br>
		<label for="r_id">Reviews:<br></label>
		<select name="r_id" id="r_id">
		<% ArrayList<Review> revs = new ReviewsServices().getAllReviews();
		for (int i=0; i<revs.size();i++){ %>
				<% Review rev = revs.get(i);%>
			Review: <option value="<%=rev.getR_id() %>">Stars: <%=rev.getStars()%>   by user: <%=rev.getUsers_id()%>   for destination:<%=rev.getD_name()%></option>
			<% } %>
			</select>
		<br><br>	
	<input type="submit" name="btn" value="Delete Review">
	</form>
</body>
</html>