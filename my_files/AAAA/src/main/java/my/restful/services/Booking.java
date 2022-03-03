package my.restful.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
import java.util.List;
import my.restful.services.AuthentificationInterface;



@Path("/Booking")
public class Booking {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/dikt?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	static final String USER = "root";
	static final String PASS = "18121973";
	
	@GET
	@Path("/MakeBooking/{t_id}/{total_tickets}")
	@Produces(MediaType.TEXT_PLAIN)
	public String addDest(@PathParam("t_id") int t_id, @PathParam("total_tickets") int total_tickets) 
	{
		Connection conn = null;		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps = conn.prepareStatement("INSERT INTO bookings (users_id, t_id, total_tickets) VALUES (?, ?, ?)");
			//set param values
			ps.setInt(1,  AuthentificationInterface.uid);
			ps.setInt(2, t_id);
			ps.setInt(3, total_tickets);
			ps.executeUpdate();
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = null;	
		return "Booking Created!";
	}
	

}
