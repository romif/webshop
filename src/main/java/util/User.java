package util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import util.sql.SqlManager;

public class User {
	private String login="";
	private String access="";
	private String name="";
	private String surName="";
	private String patronymic="";
	private String tel="";
	private String e_mail="";
	private Map<Phone,Integer> items=new HashMap<Phone,Integer>();
	
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
	
	public Map<Phone,Integer> getItems(){
		return items;
	}
	
	public boolean updateItem(int phoneId, int number){
		Iterator<Phone> it=this.items.keySet().iterator();
		while (it.hasNext()){
			Phone phone=it.next();
			if (phone.getId()==phoneId){
				if (number==0)this.items.remove(phone);
				else this.items.put(phone, number);
				return true;
			}
		}
		return false;
		
	}
	
	public int getItemsPrice(){
		int price=0;
		Iterator<Entry<Phone, Integer>> it=items.entrySet().iterator();
		while (it.hasNext()){
			Entry<Phone, Integer> entry=it.next(); 
			price+=entry.getKey().getPriceUSD()*entry.getValue();
		}
		return price;
	}
	
	public int getItemsCount(){
		int count=0;
		Iterator<Entry<Phone, Integer>> it=items.entrySet().iterator();
		while (it.hasNext()){
			count+=it.next().getValue();
		}
		return count;
	}
	
	public boolean addItem(String phoneId){
		try {
			Phone phone=null;
			int id=Integer.parseInt(phoneId);
			if ((phone=SqlManager.GetPhone(id))!=null){
				if (items.containsKey(phone)) {
					items.put(phone, items.get(phone)+1);
				}
				else items.put(phone, 1);
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
	
	public static void main(String[] args){
		User user=new User();
		user.addItem("474");user.addItem("474");
		System.out.print(user.getItems());
		
		
	}
	
	

}
