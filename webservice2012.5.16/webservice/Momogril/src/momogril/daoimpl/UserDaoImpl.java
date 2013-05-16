package momogril.daoimpl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import momogril.dao.UserDao;
import momogril.model.User;
import momogril.util.HibernateUtil;

public class UserDaoImpl implements UserDao {

	public void SaveUser(User user) {
		// TODO Auto-generated method stub
		SessionFactory sf=HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		session.beginTransaction();
		session.save(user);
         session.getTransaction().commit();
		
	}

}
