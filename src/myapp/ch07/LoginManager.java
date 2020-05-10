package myapp.ch07;

public class LoginManager {
	public boolean authenticate(UserBean user) {
		if(user.getUserid().equals("alice") && user.getPasswd().equals("1234")) {
			user.setEmail("alice@myserver.com");
			return true;
		} else {
			user.setError("Invaild id/password");
			return false;
		}
	}
}
