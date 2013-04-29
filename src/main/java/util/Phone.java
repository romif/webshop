package util;

import java.util.HashMap;

public class Phone extends HashMap<String,String>{

	public Phone() {
	}
	String[] textProperties;
	byte[] checkboxes;
	String description;
	int id=0;
	
	public void setId(int id){
		this.id=id;
	}
	
	public Integer getId(){
		if (id==0)return null;
		else return id;
	}
	
	public String getDescription(){
		return this.get("Description");
	}
	
	public String getManufactor(){
		return this.get("Manufactor");
	}
	
	public String getTitle(){
		return this.get("Title");
	}
	
	public int getFirstPrice(){
		try{
			return Integer.parseInt(this.get("firstPrice"));
		}
		catch (NumberFormatException  e){
			return -1;
		}	
	}
	
	public int getSecondPrice(){
		try{
			return Integer.parseInt(this.get("secondPrice"));
		}
		catch (NumberFormatException  e){
			return -1;
		}	
	}

}
