package util;

import java.util.HashMap;
import java.util.Map;

import util.sql.SqlManager;

public class User {
	private String login="";
	private String access="";
	private String name="";
	private String surName="";
	private String patronymic="";
	private String tel="";
	private String e_mail="";
	private Map<Integer,Integer> items=new HashMap<Integer,Integer>();
	
	public User(){
	}
	
	/*public User(String login, String name, String surName, String patronymic, String tel, String e_mail){
		this.login=login;
		this.name=name;
		this.surName=surName;
		this.patronymic=patronymic;
		this.tel=tel;
		this.e_mail=e_mail;
	}*/
	
	public String getName(){
		return name;
	}
	
	
	public String getLogin(){
		return login;
	}
	
	public String getAccess(){
		return access;
	}
	
	public String getSurName(){
		return surName;
	}
	
	public String getPatronymic(){
		return patronymic;
	}
	
	public String getTel(){
		return tel;
	}
	
	public String getE_mail(){
		return e_mail;
	}
	
	public void setLogin(String login){
		this.login=login;
	}
	
	public void setName(String name){
		this.name=name;
	}
	
	public void setSurName(String surName){
		this.surName=surName;
	}
	
	public void setPatronymic(String patronymic){
		this.patronymic=patronymic;
	}
	
	public void setTel(String tel){
		this.tel=tel;
	}
	
	public void setE_mail(String e_mail){
		this.e_mail=e_mail;
	}
	
	public void setAccess(String access){
		this.access=access;
	}
	
	public Map<Integer,Integer> getItems(){
		return items;
	}
	
	public boolean addItem(String phoneId){
		try {
			int id=Integer.parseInt(phoneId);
			if (SqlManager.GetPhone(id)!=null){
				if (items.containsKey(phoneId)) {
					items.put(id, items.get(id)+1);
				}
				else items.put(id, 1);
				return true;
			}
			else return false;	
		}catch (NumberFormatException ex){
			ex.printStackTrace();
			return false;
		}	
	}
	
	public boolean equals(Object obj){
		if(obj == this) return true;
		  if(obj == null) return false;
		  if(!(getClass() == obj.getClass()))return false;
		  else {
			  User tmp=(User)obj;
			  if (tmp.login.equals(this.login))return true;
			  else return false;
		  }
	  }
	  
	public int hashCode(){
		return login.hashCode();
	}
	
	

}
