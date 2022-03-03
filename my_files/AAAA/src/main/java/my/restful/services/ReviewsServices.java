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


@Path("/Reviews")
public class ReviewsServices {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/dikt?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	static final String USER = "root";
	static final String PASS = "18121973";
	
	
	
	@GET
	@Path("/AddReview/{d_name}/{stars}/{review}")
	public String addReview(@PathParam("d_name") String d_name, @PathParam("stars") int stars, @PathParam("review") String review) {
		
		Connection conn = null;		
		try {
			//System.out.println(AuthentificationInterface.uid);
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			char ch = '+';
			d_name = d_name.replace(ch, ' ');	//in case of whitespace
			review = review.replace(ch, ' ');	//in case of whitespace
			if(review.equals("null")) {
				review = "";
			}
			PreparedStatement ps0 = conn.prepareStatement("SELECT d_id FROM destinations WHERE d_name ='"+d_name+"'");
			ResultSet rs = ps0.executeQuery();
			rs.next();
			int d_id = rs.getInt("d_id");
			PreparedStatement ps = conn.prepareStatement("INSERT INTO reviews (d_id, users_id, stars, review) VALUES (?, ?, ?, ?)");
			//set param values
			ps.setInt(1,  d_id);
			ps.setInt(2, AuthentificationInterface.uid);
			ps.setInt(3, stars);
			ps.setString(4, review);
			ps.executeUpdate();
			System.out.println("Data inserted successfully...");
			ps0.close();
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return "Review Added";
	}
	
	@GET
	@Path("/DeleteReview/{r_id}")
	@Produces("text/plain")
	public String deleteReview(@PathParam("r_id") int r_id) {
		
		Connection conn = null;		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			PreparedStatement ps = conn.prepareStatement("DELETE FROM reviews WHERE r_id ="+r_id);
			ps.executeUpdate();
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return "Review: "+r_id+" was Deleted";
	}
	
	
	
	
	public ArrayList<Review> getAllReviews(){
		Connection conn = null;	
		ArrayList<Review> revs = new ArrayList<Review>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps = conn.prepareStatement("SELECT r_id, reviews.d_id, users_id, stars, review FROM reviews");	
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Review rev = new Review();
				rev.setR_id(rs.getInt("r_id"));
				rev.setD_id(rs.getInt("d_id"));
				rev.setUsers_id(rs.getInt("users_id"));
				rev.setStars(rs.getInt("stars"));
				rev.setRreview(rs.getString("review"));
				PreparedStatement ps2 = conn.prepareStatement("SELECT d_name FROM destinations WHERE d_id="+rs.getInt("d_id"));	
				ResultSet rs2 = ps2.executeQuery();
				rs2.next();
				rev.setD_name(rs2.getString("d_name"));
				revs.add(rev);
			}
			ps.close();
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return revs;
	}
	
	
	

}
