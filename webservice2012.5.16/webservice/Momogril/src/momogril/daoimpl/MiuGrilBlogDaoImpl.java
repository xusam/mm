package momogril.daoimpl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import momogril.dao.MiuGrilBlogDao;
import momogril.model.MiuGrilBlog;
import momogril.util.HibernateUtil;

public class MiuGrilBlogDaoImpl implements MiuGrilBlogDao{

	public void SaveMiuGrilBlog(MiuGrilBlog mBlog) {
		// TODO Auto-generated method stub
		SessionFactory sf=HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		session.beginTransaction();
		session.save(mBlog);
        session.getTransaction().commit();
	}
	
	

}
