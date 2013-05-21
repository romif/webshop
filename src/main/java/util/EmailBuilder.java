package util;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import servlet.MainServlet;

import com.google.common.base.CharMatcher;

public class EmailBuilder {

	private EmailBuilder() {
		// TODO Auto-generated constructor stub
	}
	
	
	public static String OrderBuilder(String sessionId){
		/*String st=
				"<table font: 100% Arial, Helvetica, sans-serif; cellspacing='0' cellpadding='0' width='100%'>" +
						"<tbody>" +
						"<tr>" +
						"<td colspan='6' height: 18px>" +
						"<table cellspacing='0' cellpadding='0' width='100%' height='18'>" +
						"<tbody><tr class='shcartHeadTable'>" +
						"<td class='shcartHeaderLeft'></td>" +
						"<td class='shcartHeaderTitle'>Товары</td>" +
						"<td class='shcartHeaderRight'></td>" +
						"</tr>" +
						"</tbody>" +
						"</table>" +
						"</td>" +
						"</tr>" +
						"<tr>" +
						"<td colspan='6'>" +
						"<div class='shcartBanners'>" +
						"<br>" +
						"</div>" +
						"</td>" +
						"</tr>" +
						"<tr>" +
						"<td class='theadName'>Наименование</td>" +
						"<td class='thead'>Цена</td>" +
						"<td class='thead'>Кол-во</td>" +
						"<td class='thead'>Сумма</td>" +
						"<td class='hiddenc'></td>" +
						"</tr>";
		
		
		/*Set<Phone>set=user.getItems().keySet();
	    Iterator<Phone> it=set.iterator();
	    String phones_s="";
	    while (it.hasNext()){
	    	Phone phone=it.next();
	    	phones_s+=
	    			"<tr>" +
	    			"<td class='itemname'>" +
	    			"<a href='/index?phoneID="+phone.getId()+">"+phone.getTitle()+"</a>" +
	    			"</td>" +
	    			"<td class='price'>" +
	    			"<div class='price_value' id='_t_price_<%=phone.getId()%>'/>" +
	    			"</td>" +
	    			"<td class='quantyval'>" +
	    			"<input type='text' class='quantity_value spinbox-active'" +
	    			"name=item_<%=phone.getId()%> value="+user.getItems().get(phone)+"/>" +
	    			"</td>" +
	    			"<td class='priceval'>" +
	    			"<div class='price_value' id='_t_summ_<%=phone.getId()%>'/>" +
	    			"</td>" +
	    			"</tr>";
	    }
	    st+=phones_s;
	    st+="</tbody>" +
				"</table>";*/
	    
	    String st="";
	    HttpURLConnection connection=null;
		try {
			String urlParameters = "";
			String request = "http://localhost:8081/index?basket=&step=3&currency_id=1000196&courier=on";
			URL url = new URL(request);
			connection = (HttpURLConnection) url.openConnection();           
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setInstanceFollowRedirects(false); 
			connection.setRequestMethod("POST"); 
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded"); 
			connection.setRequestProperty("charset", "utf-8");
			connection.setRequestProperty("Content-Length", "" + Integer.toString(urlParameters.getBytes().length));
			connection.setUseCaches (false);
			connection.setRequestProperty("Cookie", "JSESSIONID=" + sessionId);
			
			

			/*DataOutputStream wr = new DataOutputStream(connection.getOutputStream ());
			wr.writeBytes(urlParameters);
			wr.flush();
			wr.close();*/
			
			Document doc = Jsoup.parse(connection.getInputStream(), null, request);
			Elements elements = doc.select(".additionalContent");
			
			
			for (Element element:elements){
				/*if(element.html().contains("Сумма")){
					try {
						int summa=Integer.parseInt(CharMatcher.DIGIT.retainFrom(element.html()));
						
					} catch (NumberFormatException ex){
						
					} 
				}*/
				System.out.println(element);
				st+=element.toString();
			}
			connection.disconnect();
			
			
		}catch (MalformedURLException e) {
			e.printStackTrace();
			
		} catch (IOException e) {
			e.printStackTrace();
			
		}finally {
			if (connection!=null)connection.disconnect();
		}
		
		return st;
	}
	
	public static void main(String[] args){
		//System.out.print(EmailBuilder.OrderBuilder("EU1xDaJ9oTXfiFM+S5-UulSL.undefined"));

		
	}

}
