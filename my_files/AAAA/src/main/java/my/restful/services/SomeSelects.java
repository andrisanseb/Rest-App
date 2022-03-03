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


@Path("/Selects")
public class SomeSelects {
	//JDBC driver name and database URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/dikt?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	//DB credentials
	static final String USER = "root";
	static final String PASS = "18121973";
	
	
	
	@GET
	@Path("/CheapestOptions")
	@Produces(MediaType.TEXT_PLAIN)
	public String cheapestOptions() 
	{
		Connection conn = null;		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps0 = conn.prepareStatement("SELECT destinations.d_name, way, price, month FROM transportation INNER JOIN destinations ON transportation.d_id = destinations.d_id ORDER BY price LIMIT 5 ");
			ResultSet rs = ps0.executeQuery();
			
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		conn = null;	
		return "Here you go";
	}
	
	
	public ArrayList<TransportationOption> getAllTrOptions(){	//used for cheapest
		Connection conn = null;	
		ArrayList<TransportationOption> opts = new ArrayList<TransportationOption>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps = conn.prepareStatement("SELECT t_id, transportation.d_id, way, price, duration, month FROM transportation ORDER BY price");	
			ResultSet rs = ps.executeQuery();
			int how_many = 1;
			while(rs.next()) {
				if(how_many<11) {	//TOP 10 einai san na exw LIMIT 10
					TransportationOption opt = new TransportationOption();
					opt.setT_id(rs.getInt("t_id"));
					opt.setD_id(rs.getInt("d_id"));
					opt.setWay(rs.getString("way"));
					opt.setPrice(rs.getDouble("price"));
					opt.setDuration(rs.getDouble("duration"));
					opt.setMonth(rs.getString("month"));
					PreparedStatement ps2 = conn.prepareStatement("SELECT d_name FROM destinations WHERE d_id="+rs.getInt("d_id"));	
					ResultSet rs2 = ps2.executeQuery();
					rs2.next();
					opt.setD_name(rs2.getString("d_name"));
					opts.add(opt);
					how_many++;
				}
			}
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return opts;
	}
	
	public ArrayList<TransportationOption> getAllOffers(){	//used for make a booking
		Connection conn = null;	
		ArrayList<TransportationOption> opts = new ArrayList<TransportationOption>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps = conn.prepareStatement("SELECT t_id, transportation.d_id, way, price, duration, month FROM transportation ORDER BY t_id");	
			ResultSet rs = ps.executeQuery();
			int how_many = 1;
			while(rs.next()) {
					TransportationOption opt = new TransportationOption();
					opt.setT_id(rs.getInt("t_id"));
					opt.setD_id(rs.getInt("d_id"));
					opt.setWay(rs.getString("way"));
					opt.setPrice(rs.getDouble("price"));
					opt.setDuration(rs.getDouble("duration"));
					opt.setMonth(rs.getString("month"));
					PreparedStatement ps2 = conn.prepareStatement("SELECT d_name FROM destinations WHERE d_id="+rs.getInt("d_id"));	
					ResultSet rs2 = ps2.executeQuery();
					rs2.next();
					opt.setD_name(rs2.getString("d_name"));
					opts.add(opt);
			}
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return opts;
	}
	
	
	
}
