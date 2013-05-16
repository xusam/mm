package momogril.model;

import java.sql.Date;
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  

import javax.persistence.Id;  

@Entity
public class Follow {
	private long  id;
	private String uid;
	private String followuid;
	private Date createtime;
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
	public String getFollowuid() {
		return followuid;
	}
	public void setFollowuid(String followuid) {
		this.followuid = followuid;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

}
