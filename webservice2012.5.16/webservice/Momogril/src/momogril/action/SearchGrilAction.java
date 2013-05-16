package momogril.action;

import java.io.IOException;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import momogril.daoimpl.MiuGrilBlogDaoImpl;
import momogril.daoimpl.UserDaoImpl;
import momogril.model.DelegateGrilMode;
import momogril.model.MiuGrilBlog;
import momogril.model.User;

import momogril.serviceimpl.MiuGrilBlogServiceImpl;
import momogril.serviceimpl.UserServiceImpl;
import momogril.util.HibernateUtil;

import org.apache.commons.httpclient.HttpException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import weibo4j.model.*;

import weibo4j.Timeline;
import weibo4j.Users;

import weibo4j.model.Paging;
import weibo4j.model.Status;
import weibo4j.model.StatusWapper;
import weibo4j.model.WeiboException;
import weibo4j.util.SiginSinaWeibo;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionSupport;

public class SearchGrilAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String screen_name; // 用户昵称
	private String wuid; // 用户ID

	private Map<String, Object> dataMap = new HashMap<String, Object>(); // 搜索返回数据
	private String listString; // Mid json
	private String save_name; // MiuGril 名称

	// 保存MiuGril用户信息

	public String doSaveMiuGril() throws HttpException, IOException,
			WeiboException {
		dataMap.clear();
		System.out.println(screen_name);
	    String	since_id = null;
	    int number=0;
		//--------------------------添加女神图片-------------------------------//
		MiuGrilBlogServiceImpl miuGrilBlogServiceImpl = new MiuGrilBlogServiceImpl();
    
		try {

			// 返回数据给后台
			Timeline timeline = new Timeline();
			timeline.client.setToken(SiginSinaWeibo.getToken("", "")
					.getAccessToken());
			for (int i = 1; i < 10000; i++) {
				Paging pag = new Paging();
				pag.setPage(i);
				pag.setCount(100);
				StatusWapper status = timeline.getUserTimelineByUid(
						screen_name, pag, 0, 1, 2, 1);
				if (status.getStatuses().size() == 0) {

					break;
				}
				
				for (Status s : status.getStatuses()) {
					if(i==1&&number==0){
						
						since_id=s.getMid();
						number++;
					}
					// 保存数据到数据库
					MiuGrilBlog mBlog = new MiuGrilBlog();
					mBlog.setMid(s.getMid());
					mBlog.setOriginal_pic(s.getOriginalPic());
					mBlog.setBmiddle_pic(s.getBmiddlePic());

					mBlog.setComent_count(0);
					mBlog.setIs_hot(0);
					mBlog.setIs_recommend(0);
					mBlog.setPraise_count(0);
					mBlog.setShake_count(0);
					mBlog.setCreatetime(s.getCreatedAt());
					miuGrilBlogServiceImpl.SaveMiuGrilBlog(mBlog);

				}

			}

			//--------------------------添加女神-------------------------------//
			Users users = new Users();
			users.client.setToken(SiginSinaWeibo.getToken("", "").getAccessToken());
			weibo4j.model.User user = users.showUserByScreenName(screen_name);
			UserServiceImpl userServiceImpl = new UserServiceImpl();

			User nUser = new User();
			nUser.setWid(user.getId());
			nUser.setAvatar_large(user.getavatarLarge());
			nUser.setProfile_image_url(user.getProfileImageUrl());
			nUser.setScreen_name(user.getScreenName());
			nUser.setLocation(user.getLocation());
			nUser.setFavourites_count(0);
			nUser.setFollowers_count(0);
			nUser.setFriends_count(0);
			nUser.setIsmiugril(1);
			nUser.setLevel(1);
			nUser.setPhoto_count(0);
			nUser.setScore_count(0);
			nUser.setSince_id(since_id);
			nUser.setCreatetime(new java.util.Date());
			userServiceImpl.save(nUser);
			
			
			
			
			
			
		} catch (WeiboException e) {

			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}

		
		
		
		
		
		
		
		
		dataMap.put("status", "success");

		return ActionSupport.SUCCESS;

	}

	// 搜索美女保存数据库
	public String SearchGril() throws HttpException, IOException {
		dataMap.clear();
		

		return ActionSupport.SUCCESS;

	}

	// 批量删除美女
	public String delegate() {

		// User u=new User();
		// u.setMid("1000");
		// SessionFactory sf=HibernateUtil.getSessionFactory();
		// Session session=sf.openSession();
		// session.beginTransaction();
		// session.save(u);
		// session.getTransaction().commit();

		// List<DelegateGrilMode> listDeleted = JSON.parseArray(listString,
		// DelegateGrilMode.class);
		// Iterator<DelegateGrilMode> it = listDeleted.iterator();
		// while (it.hasNext()) {
		// DelegateGrilMode item=it.next();
		// System.out.println("success="+item.getMid());
		// }

		return ActionSupport.SUCCESS;
	}

	public String getWuid() {
		return wuid;
	}

	public void setWuid(String wuid) {
		this.wuid = wuid;
	}

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public String getScreen_name() {
		return screen_name;
	}

	public void setScreen_name(String screenName) {
		screen_name = screenName;
	}

	public String getListString() {
		return listString;
	}

	public void setListString(String listString) {
		this.listString = listString;
	}

	public String getSave_name() {
		return save_name;
	}

	public void setSave_name(String saveName) {
		save_name = saveName;
	}

}