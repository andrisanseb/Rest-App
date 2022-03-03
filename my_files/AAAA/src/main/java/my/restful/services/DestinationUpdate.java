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


@Path("/DestsUpdate")
public class DestinationUpdate {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/dikt?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	static final String USER = "root";
	static final String PASS = "18121973";
	
	
	
	@GET
	@Path("/AddDest/{d_name}/{d_tel}")
	@Produces(MediaType.TEXT_PLAIN)
	public String addDest(@PathParam("d_name") String d_name, @PathParam("d_tel") String d_tel) 
	{
		Connection conn = null;		
		try {
			//Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");
			//Open Connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			//set vars
			//exec query
			if(d_tel.equals("null")) {
				d_tel = "";
			}
			char ch = '+';
			d_name = d_name.replace(ch, ' ');	//in case of whitespace
			System.out.println("Inserting data..");
			PreparedStatement ps = conn.prepareStatement("INSERT INTO destinations (d_name, d_tel) VALUES (?, ?)");
			//set param values
			ps.setString(1,  d_name);
			ps.setString(2, d_tel);
			ps.executeUpdate();
			System.out.println("Data inserted successfully...");
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = null;	
		return "Destination Added";
	}
	
	
	@GET
	@Path("/AddTr/{d_name}/{way}/{price}/{duration}/{month}")
	@Produces(MediaType.TEXT_PLAIN)
	public String addTr(@PathParam("d_name") String d_name, @PathParam("way") String way, @PathParam("price") Double price, @PathParam("duration") Double duration, @PathParam("month") String month) 
	{
		Connection conn = null;		
		try {
			//Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");
			//Open Connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			char ch = '+';
			d_name = d_name.replace(ch, ' ');	//in case of whitespace
			way = way.replace(ch, ' ');	//in case of whitespace
			PreparedStatement ps0 = conn.prepareStatement("SELECT d_id FROM destinations WHERE d_name ='"+d_name+"'");
			ResultSet rs = ps0.executeQuery();
			rs.next();
			int d_id = rs.getInt("d_id");
			PreparedStatement ps = conn.prepareStatement("INSERT INTO transportation (d_id, way, price, duration, month) VALUES (?, ?, ?, ?, ?)");
			ps.setInt(1,  d_id);
			ps.setString(2, way);
			ps.setDouble(3, price);
			ps.setDouble(4, duration);
			ps.setString(5, month);
			ps.executeUpdate();
			System.out.println("Data inserted successfully...");
			ps0.close();
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return "Added Succesfully!";
	}
	
	@GET
	@Path("/DelTr/{t_id}")
	@Produces("text/plain")
	public String deleteReview(@PathParam("t_id") int t_id) {
		Connection conn = null;		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			PreparedStatement ps = conn.prepareStatement("DELETE FROM transportation WHERE t_id ="+t_id);
			ps.executeUpdate();
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		return "Transportation offer: "+t_id+" was Deleted";
	}
	
	
	
	//method that returns all destinations from database in an arraylist
	public ArrayList<Destination> getAllDest() {
		Connection conn = null;	
		ArrayList<Destination> dests = new ArrayList<Destination>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps = conn.prepareStatement("SELECT d_id, d_name FROM destinations ORDER BY d_name");	
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Destination dest = new Destination();
				dest.setD_id(rs.getInt("d_id"));
				dest.setD_name(rs.getString("d_name"));
				dests.add(dest);
			}
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return dests;
	}
	
	
	

}
