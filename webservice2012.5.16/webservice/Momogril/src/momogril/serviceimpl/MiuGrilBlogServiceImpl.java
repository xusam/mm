package momogril.serviceimpl;


import momogril.daoimpl.MiuGrilBlogDaoImpl;
import momogril.model.MiuGrilBlog;
import momogril.service.MiuGrilBlogService;

public class MiuGrilBlogServiceImpl implements MiuGrilBlogService {

	MiuGrilBlogDaoImpl  miuGrilBlogDao=new MiuGrilBlogDaoImpl();
	
	public void SaveMiuGrilBlog(MiuGrilBlog mBlog) {
		// TODO Auto-generated method stub
		miuGrilBlogDao.SaveMiuGrilBlog(mBlog);
		
		
	}

	

}
