package momogril.model;


import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  
import java.util.Date;
import javax.persistence.Id;  

@Entity
public class User {
	private long uid;
	private String wid;
	private String screen_name;
	private String profile_image_url;
	private String avatar_large;
	private Date createtime;
	private long photo_count ;
	private long followers_count  ;
	private long friends_count  ;
	private long favourites_count   ;
	private int level   ;
	private long score_count   ;
	private String location   ;
	private int ismiugril ;
	private String since_id;
	
	@Id
	@GeneratedValue
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public String getWid() {
		return wid;
	}
	public void setWid(String wid) {
		this.wid = wid;
	}
	public String getScreen_name() {
		return screen_name;
	}
	public void setScreen_name(String screenName) {
		screen_name = screenName;
	}
	public String getProfile_image_url() {
		return profile_image_url;
	}
	public void setProfile_image_url(String profileImageUrl) {
		profile_image_url = profileImageUrl;
	}
	public String getAvatar_large() {
		return avatar_large;
	}
	public void setAvatar_large(String avatarLarge) {
		avatar_large = avatarLarge;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date date) {
		this.createtime = date;
	}
	public long getPhoto_count() {
		return photo_count;
	}
	public void setPhoto_count(long photoCount) {
		photo_count = photoCount;
	}
	public long getFollowers_count() {
		return followers_count;
	}
	public void setFollowers_count(long followersCount) {
		followers_count = followersCount;
	}
	public long getFriends_count() {
		return friends_count;
	}
	public void setFriends_count(long friendsCount) {
		friends_count = friendsCount;
	}
	public long getFavourites_count() {
		return favourites_count;
	}
	public void setFavourites_count(long favouritesCount) {
		favourites_count = favouritesCount;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public long getScore_count() {
		return score_count;
	}
	public void setScore_count(long scoreCount) {
		score_count = scoreCount;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getIsmiugril() {
		return ismiugril;
	}
	public void setIsmiugril(int ismiugril) {
		this.ismiugril = ismiugril;
	}
	public String getSince_id() {
		return since_id;
	}
	public void setSince_id(String sinceId) {
		since_id = sinceId;
	}
	
	

	

}
