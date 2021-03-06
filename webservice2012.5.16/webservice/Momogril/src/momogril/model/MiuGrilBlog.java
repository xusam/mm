package momogril.model;

import java.util.Date;
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
@Entity
public class MiuGrilBlog {
	
	private long mgid;
	private String mid;
	private String bmiddle_pic;
	private String original_pic ;
	private long praise_count ;
	private long shake_count ;
	private long coment_count ;
	private int is_hot  ;
	private int is_recommend  ;
	private Date createtime;
	
	@Id
	@GeneratedValue
	public long getMgid() {
		return mgid;
	}
	public void setMgid(long mgid) {
		this.mgid = mgid;
	}
	
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getBmiddle_pic() {
		return bmiddle_pic;
	}
	public void setBmiddle_pic(String bmiddlePic) {
		bmiddle_pic = bmiddlePic;
	}
	public String getOriginal_pic() {
		return original_pic;
	}
	public void setOriginal_pic(String originalPic) {
		original_pic = originalPic;
	}
	public long getPraise_count() {
		return praise_count;
	}
	public void setPraise_count(long praiseCount) {
		praise_count = praiseCount;
	}
	public long getShake_count() {
		return shake_count;
	}
	public void setShake_count(long shakeCount) {
		shake_count = shakeCount;
	}
	public long getComent_count() {
		return coment_count;
	}
	public void setComent_count(long comentCount) {
		coment_count = comentCount;
	}
	public int getIs_hot() {
		return is_hot;
	}
	public void setIs_hot(int isHot) {
		is_hot = isHot;
	}
	public int getIs_recommend() {
		return is_recommend;
	}
	public void setIs_recommend(int isRecommend) {
		is_recommend = isRecommend;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	
	

}
