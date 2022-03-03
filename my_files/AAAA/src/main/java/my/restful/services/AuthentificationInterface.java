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



@Path("Auth")
public class AuthentificationInterface {
	//JDBC driver name and database URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/dikt?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	//DB credentials
	static final String USER = "root";
	static final String PASS = "18121973";
	public static int uid = 0;
	
	@POST
	@Path("/Register/{first_name}/{last_name}/{username}/{password}/{phone}")
	@Produces(MediaType.TEXT_PLAIN)
	public String register(@PathParam("first_name") String first_name, @PathParam("last_name") String last_name, @PathParam("username") String username, @PathParam("password") String password, @PathParam("phone") String phone) {
		Connection conn = null;		
		try {
			//Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");
			//Open Connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			//set vars
			String first_name1 = first_name;
			String last_name1 = last_name;
			String username1 = username;
			String password1 = password;
			String phone1 = phone;
			
			PreparedStatement ps = conn.prepareStatement("INSERT INTO users (first_name, last_name, username, password, phone) VALUES (?, ?, ?, ?, ?)");
			//set param values
			ps.setString(1, first_name);
			ps.setString(2, last_name);
			ps.setString(3, username);
			ps.setString(4, password);
			ps.setString(5, phone);
			ps.executeUpdate();
			
			PreparedStatement ps0 = conn.prepareStatement("SELECT users_id FROM users WHERE username = '"+username+"'");
			ResultSet rs0 = ps0.executeQuery();
			rs0.next();
			uid = rs0.getInt("users_id");
			ps.close();
			ps0.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return "Registration Complete";
	}
	
	
	
	@GET
	@Path("/Login/{username}/{password}")
	@Produces("text/plain")
	public String login(@PathParam("username") String username, @PathParam("password") String password){
		Connection conn = null;	
		String username1 = "x";
		String password1 = "x";
		int flag = 0;
		try {
			//Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");
			//Open Connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			//set vars
			//exec query
			PreparedStatement ps = conn.prepareStatement("SELECT username, password  FROM users WHERE username= ?");
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				username1 = rs.getString("username");
				password1 = rs.getString("password");
			}
			
			PreparedStatement ps0 = conn.prepareStatement("SELECT users_id FROM users WHERE username = '"+username+"'");
			ResultSet rs0 = ps0.executeQuery();
			rs0.next();
			uid = rs0.getInt("users_id");
			System.out.println(uid);
			ps.close();
			ps0.close();
			if(password1.contentEquals(password)){
				flag = 1;
			}
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		if(flag==1) {
			return "Login Successful";
		} else {
			return "Username or password not valid. Please try again.";
		}
	}
	
	public boolean isAdmin(int id) {
		Connection conn = null;	
		boolean isAdmin = false;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps = conn.prepareStatement("SELECT is_admin FROM users WHERE users_id = "+id);	
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				if(rs.getString("is_admin").equals("yes")){
					isAdmin=true;
				}
			}
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return isAdmin;
	}

}




