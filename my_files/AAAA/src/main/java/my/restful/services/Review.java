package my.restful.services;

public class Review {
	
	int r_id;
	int d_id;
	int users_id;
	int stars;
	String rreview;
	String d_name;
	
	public Review() {
		this.r_id = r_id;
		this.d_id = d_id;
		this.users_id = users_id;
		this.stars= stars;
		this.rreview = rreview;
		this.d_name = d_name;
	}
	public int getR_id() {
		return r_id;
	}
	public void setR_id(int r_id) {
		this.r_id = r_id;
	}
	public int getD_id() {
		return d_id;
	}
	public void setD_id(int d_id) {
		this.d_id = d_id;
	}
	public int getUsers_id() {
		return users_id;
	}
	public void setUsers_id(int users_id) {
		this.users_id = users_id;
	}
	public int getStars() {
		return stars;
	}
	public void setStars(int stars) {
		this.stars = stars;
	}
	public String getRreview() {
		return rreview;
	}
	public void setRreview(String rreview) {
		this.rreview = rreview;
	}
	
	public String getD_name() {
		return d_name;
	}
	public void setD_name(String d_name) {
		this.d_name = d_name;
	}
	
	
	
	

}
