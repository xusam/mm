package momogril.model;

import java.sql.Date;

import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  

import javax.persistence.Id;  

@Entity
public class Approval {
	private long id;
	private String uid;
	private String mid;
	private Date createtimeDate;
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public Date getCreatetimeDate() {
		return createtimeDate;
	}
	public void setCreatetimeDate(Date createtimeDate) {
		this.createtimeDate = createtimeDate;
	}

}
