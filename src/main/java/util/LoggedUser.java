package util;

public class LoggedUser {
	private String userId="";
	private String login="";
	private String access="";
	
	public LoggedUser(String userId, String login, String access){
		this.userId=userId;
		this.login=login;
		this.access=access;
	}
	
	public void setUserId(String userId){
		this.userId=userId;
	}
	
	public void setLogin(String login){
		this.login=login;
	}
	
	public void setAccess(String access){
		this.access=access;
	}
	public String getUserId(){
		return userId;
	}
	public String getLogin(){
		return login;
	}
	public String getAccess(){
		return access;
	}
	
	public boolean equals(Object obj)
	  {
		  Object o=new Object();
		  o.hashCode();
		  if(obj == this) return true;
		  if(obj == null) return false;
		  if(!(getClass() == obj.getClass()))return false;
		  else {
			  LoggedUser tmp=(LoggedUser)obj;
			  if (tmp.getUserId()==this.userId)return true;
			  else return false;
		  }
	  }
	  
	public int hashCode(){
		return userId.hashCode();
	}

}
