package my.restful.services;

public class TransportationOption {
	int t_id;
	int d_id;
	String way;
	Double price;
	Double duration;
	String month;
	String d_name;
	
	public TransportationOption() {
		this.t_id= t_id;
		this.d_id= d_id;
		this.way = way;
		this.price=price;
		this.duration=duration;
		this.month=month;
		this.d_name=d_name;
		
	}
	
	public int getT_id() {
		return t_id;
	}

	public void setT_id(int t_id) {
		this.t_id = t_id;
	}

	public int getD_id() {
		return d_id;
	}

	public void setD_id(int d_id) {
		this.d_id = d_id;
	}

	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getDuration() {
		return duration;
	}

	public void setDuration(Double duration) {
		this.duration = duration;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getD_name() {
		return d_name;
	}

	public void setD_name(String d_name) {
		this.d_name = d_name;
	}

}
