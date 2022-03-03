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


@Path("/Favorites")
public class ManageFavorites {
	//JDBC driver name and database URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/dikt?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	//DB credentials
	static final String USER = "root";
	static final String PASS = "18121973";
	
	@GET
	@Path("/AddFav/{d_name}")	//no need to pass users_id, already have it from login
	public String addFav(@PathParam("d_name") String d_name) {
		Connection conn = null;		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			char ch = '+';
			d_name = d_name.replace(ch, ' ');	//in case of whitespace
			PreparedStatement ps0 = conn.prepareStatement("SELECT d_id FROM destinations WHERE d_name ='"+d_name+"'");
			ResultSet rs = ps0.executeQuery();
			rs.next();
			int d_id = rs.getInt("d_id");
			PreparedStatement ps = conn.prepareStatement("INSERT INTO favorites (d_id, users_id) VALUES (?, ?)");
			//set param values
			ps.setInt(1,  d_id);
			ps.setInt(2, AuthentificationInterface.uid);
			ps.executeUpdate();
			ps0.close();
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return d_name+" added to favorites!";
	}
	
	@GET
	@Path("/RemoveFav/{d_name}")	//no need to pass users_id, already have it from login
	public String removeFav(@PathParam("d_name") String d_name) {
		Connection conn = null;		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			char ch = '+';
			d_name = d_name.replace(ch, ' ');	//in case of whitespace
			PreparedStatement ps0 = conn.prepareStatement("SELECT d_id FROM destinations WHERE d_name ='"+d_name+"'");
			ResultSet rs = ps0.executeQuery();
			rs.next();
			int d_id = rs.getInt("d_id");
			PreparedStatement ps = conn.prepareStatement("DELETE FROM favorites WHERE d_id= "+d_id+" AND users_id ="+AuthentificationInterface.uid);
			ps.executeUpdate();
			ps0.close();
			ps.close();
			conn.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return d_name+" removed from favorites!";
	}
	
	
	public ArrayList<Favorite> getFavs(){
		Connection conn = null;	
		ArrayList<Favorite> favs = new ArrayList<Favorite>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps = conn.prepareStatement("SELECT users_id, d_id FROM favorites WHERE users_id="+AuthentificationInterface.uid);	
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
					Favorite fav = new Favorite();
					fav.setUsers_id(rs.getInt("users_id"));
					fav.setD_id(rs.getInt("d_id"));
					PreparedStatement ps2 = conn.prepareStatement("SELECT d_name FROM destinations WHERE d_id="+rs.getInt("d_id"));	
					ResultSet rs2 = ps2.executeQuery();
					rs2.next();
					fav.setD_name(rs2.getString("d_name"));
					//na pairnei to global users_id apo login
					PreparedStatement ps3 = conn.prepareStatement("SELECT first_name FROM users WHERE users_id= "+AuthentificationInterface.uid);	
					ResultSet rs3 = ps3.executeQuery();
					rs3.next();
					fav.setFirst_name(rs3.getString("first_name"));
					favs.add(fav);
					ps2.close();
					ps3.close();
			}
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return favs;
	}
	
	public boolean isAlreadyFav(int d_id) {
		Connection conn = null;	
		boolean already = false;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps = conn.prepareStatement("SELECT d_id FROM favorites WHERE users_id = "+AuthentificationInterface.uid+" AND d_id="+d_id);	
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				int foundInDB = rs.getInt("d_id");
				if(foundInDB == d_id) {
					already = true;
				}
			}
			//System.out.println(already);
			ps.close();
			conn.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return already;
	}
}
