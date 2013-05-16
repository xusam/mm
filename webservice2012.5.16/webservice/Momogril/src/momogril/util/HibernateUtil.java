package momogril.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class HibernateUtil {
	private static final SessionFactory sessionFactory= buildSessionFactory();

	private static SessionFactory buildSessionFactory(){
		
		try{
//			 Configuration cfg=new Configuration();
//		        SessionFactory sf=cfg.configure().buildSessionFactory(new ServiceRegistryBuilder().buildServiceRegistry());  
//			
			Configuration cfg=new Configuration();
			cfg.configure();
			ServiceRegistry sr=new ServiceRegistryBuilder().applySettings(cfg.getProperties()).buildServiceRegistry();
			
			SessionFactory sf=cfg.buildSessionFactory(sr);
			return sf;
		}catch(Throwable ex){
			
			
			throw new ExceptionInInitializerError(ex);
			
		}
		
	}
		public synchronized static SessionFactory getSessionFactory(){
			
			return sessionFactory;
		
		
		
	}
}
