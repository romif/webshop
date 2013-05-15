package util;

import java.util.Comparator;
import java.util.HashMap;

public class Phone extends HashMap<String,String>{

	public Phone() {
	}
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

	public enum PhoneComparator implements Comparator<Phone> {
	    PRICE_SORT {
	        public int compare(Phone phone1, Phone phone2) {
	            return Integer.valueOf(phone1.getFirstPrice()).compareTo(phone2.getFirstPrice());
	        }},
	    NAME_SORT {
	        public int compare(Phone phone1, Phone phone2) {
	            return phone1.getTitle().compareTo(phone2.getTitle());
	        }};

	    public static Comparator<Phone> descending(final Comparator<Phone> other) {
	        return new Comparator<Phone>() {
	            public int compare(Phone phone1, Phone phone2) {
	                return -1 * other.compare(phone1, phone2);
	            }
	        };
	    }

	    public static Comparator<Phone> getComparator(final PhoneComparator... multipleOptions) {
	        return new Comparator<Phone>() {
	            public int compare(Phone phone1, Phone phone2) {
	                for (PhoneComparator option : multipleOptions) {
	                    int result = option.compare(phone1, phone2);
	                    if (result != 0) {
	                        return result;
	                    }
	                }
	                return 0;
	            }
	        };
	    }
	}

}
