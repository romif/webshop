package util;

import java.util.HashMap;

public class Phone extends HashMap<String,String>{

	public Phone() {
	}
	String[] textProperties;
	byte[] checkboxes;
	String description;
	
	public void setTextProperties(String[] textProperties){
		this.textProperties=textProperties;
	}
	
	public void setCheckboxes(byte[] checkboxes){
		this.checkboxes=checkboxes;
	}
	
	public void setDescription(String description){
		this.description=description;
	}
	
	public String[] getTextProperties(){
		return textProperties;
	}
	
	public byte[] getCheckboxes(){
		return checkboxes;
	}
	
	public String getDescription(){
		return description;
	}

}
