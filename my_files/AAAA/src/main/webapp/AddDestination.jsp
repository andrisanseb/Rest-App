<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="./styles.css" rel="stylesheet" type="text/css">
<title>Admin-Add Destination</title>
</head>
<body>
	<%
		if(request.getParameter("btn") != null){
			String d_name = request.getParameter("d_name").toString();
			d_name = d_name.replaceAll("\\s", "+");	//in case of whitespace
			String d_tel = request.getParameter("d_tel").toString();
			if (d_tel.equals("")){
				d_tel = "null";	//sto db tha perastei adeio string
			}
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/DestsUpdate/AddDest/"+d_name+"/"+d_tel);
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
		<h2>Add Destination Form</h2>
		<br><br>
		Name: <br><input type="text" name="d_name" value=""><br><br>
		<br><br>
		Information phone number(optional): <br><input type="text" name="d_tel" value=""><br><br>
		<br><br>
		<input type="submit" name="btn" value="Add Destination">
		<br><br>
	</form>

</body>
</html>