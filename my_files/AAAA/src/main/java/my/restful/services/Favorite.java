package my.restful.services;

public class Favorite {
	int users_id;
	int d_id;
	String d_name;
	String first_name;
	
	public Favorite() {
		this.users_id=users_id;
		this.d_id=d_id;
		this.d_name=d_name;
		this.first_name=first_name;
	}
	
	public int getUsers_id() {
		return users_id;
	}
	public void setUsers_id(int users_id) {
		this.users_id = users_id;
	}
	public int getD_id() {
		return d_id;
	}
	public void setD_id(int d_id) {
		this.d_id = d_id;
	}
	public String getD_name() {
		return d_name;
	}
	public void setD_name(String d_name) {
		this.d_name = d_name;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	

}
