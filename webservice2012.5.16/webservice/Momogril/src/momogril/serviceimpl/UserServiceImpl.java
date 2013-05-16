package momogril.serviceimpl;

import com.sun.org.apache.bcel.internal.generic.NEW;

import momogril.daoimpl.UserDaoImpl;
import momogril.model.User;
import momogril.service.UserService;

public class UserServiceImpl implements UserService {

	UserDaoImpl userDaoImpl=new UserDaoImpl();
	
	public void save(User user) {
		// TODO Auto-generated method stub
		userDaoImpl.SaveUser(user);
		System.out.println("ok"); 
		
		
	}

}
