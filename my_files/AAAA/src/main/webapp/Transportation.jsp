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
<title>Create or Delete Transportation offer</title>
<style>
input{
	width:20%;
}

option{
	width:50%;
}
</style>
</head>
<body>
	<%
		if(request.getParameter("btn") != null){
			String d_name = request.getParameter("d_name").toString();
			String way = request.getParameter("way").toString();
			d_name = d_name.replaceAll("\\s", "+");	//in case of whitespace
			way = way.replaceAll("\\s", "+");	//in case of whitespace
			Double price = Double.parseDouble(request.getParameter("price").toString());
			Double duration = Double.parseDouble(request.getParameter("duration").toString());
			String month= request.getParameter("month").toString();
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/DestsUpdate/AddTr/"+d_name+"/"+way+"/"+price+"/"+duration+"/"+month);
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
	
		if(request.getParameter("del-btn") != null){
			int t_id = Integer.parseInt(request.getParameter("t_id"));
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/AAAA/rest/DestsUpdate/DelTr/"+t_id);
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
	<h2>Add a new transportation offer</h2>
	<br><br>
		<label for="d_name">Choose a destination:<br></label>
		<select name="d_name" id="d_name">
		<% ArrayList<Destination> ddd = new DestinationUpdate().getAllDest();
		for (int i=0; i<ddd.size();i++){ %>
				<% Destination d = ddd.get(i);%>
					Destination: <option value="<%=d.getD_name() %>"><%=d.getD_name() %></option>
			<% } %>
			</select>
		<br><br>	
		<label for="way">Way of travel:<br></label>
		<select name="way" id="way">
			<option value="bus">bus</option>
			<option value="private bus">private bus</option>
			<option value="limousine">limousine</option>
			<option value="plane">plane</option>
			<option value="private jet">private jet</option>
			<option value="helicopter">helicopter</option>
			<option value="ferry boat">ferry boat</option>
			<option value="private boat">private boat</option>
		</select>
		<br><br>
		Price( double format): <br><input type="text" name="price" value=""><br><br>
		Duration( hours, double format): <br><input type="text" name="duration" value=""><br><br>
		<label for="month">Month:</label>
		<select name="month" id="month">
			<option value="January">January</option>
			<option value="February">February</option>
			<option value="March">March</option>
			<option value="April">April</option>
			<option value="May">May</option>
			<option value="June">June</option>
			<option value="July">July</option>
			<option value="August">August</option>
			<option value="September">September</option>
			<option value="October">October</option>
			<option value="November">November</option>
			<option value="December">December</option>
		</select>
		<br><br>
	<input type="submit" name="btn" value="Add Transportation Offer">
	</form>
	
	<form>
		<h2>Delete an offer</h2>
		<br><br>
		<label for="t_id"></label>
		<select name="t_id" id="t_id">
		<% ArrayList<TransportationOption> opts = new SomeSelects().getAllTrOptions();
		for (int i=0; i<opts.size();i++){ %>
				<% TransportationOption opt = opts.get(i);%>
				<option value="<%=opt.getT_id() %>">Destination:    <%=opt.getD_name()%>    via:	<%=opt.getWay()%>    cost:    <%=opt.getPrice()%>    in:    <%=opt.getMonth()%>	</option>
			<% } %>
			</select>
	<input type="submit" name="del-btn" value="Delete Offer">
	</form>
	
</body>
</html>