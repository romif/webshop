package util;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Iterator;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import servlet.MainServlet;
import util.sql.SqlManager;

import com.google.common.base.CharMatcher;


public class Tarifikator {
	

	private Tarifikator() {
		// TODO Auto-generated constructor stub
	}

	private static int getSumma(int weight, long declared) {
		HttpURLConnection connection=null;
		try {
			String urlParameters = "who=fiz&type=declared&weight="+weight+"&declared="+declared;
			String request = "http://tarifikator.belpost.by/forms/internal/small.php";
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

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream ());
			wr.writeBytes(urlParameters);
			wr.flush();
			wr.close();
			
			Document doc = Jsoup.parse(connection.getInputStream(), null, request);
			Elements elements = doc.select(".context h1");
			
			for (Element element:elements){
				if(element.html().contains("Сумма")){
					try {
						int summa=Integer.parseInt(CharMatcher.DIGIT.retainFrom(element.html()));
						return summa;
					} catch (NumberFormatException ex){
						return -1;
					} 
				}
			}
			connection.disconnect();
			return -1;
			
		}catch (MalformedURLException e) {
			e.printStackTrace();
			return -1;
		} catch (IOException e) {
			e.printStackTrace();
			return -1;
		}finally {
			if (connection!=null)connection.disconnect();
		}
	}
	
	public static float getTarif(User user){
		Set<Phone>set=user.getItems().keySet();
		if (set.isEmpty())return -1;
		Iterator<Phone> it=set.iterator();
		int weight=0;
		long price=0;
		while (it.hasNext()){
			Phone phone=it.next();
			if (phone.get("textProperty15")!=null){
				int weight_temp=0;
				try {
					weight_temp+=3*Integer.parseInt(CharMatcher.DIGIT.retainFrom(phone.get("textProperty15")));
				}catch (NumberFormatException ex){
					weight_temp+=3*200;
				}
				weight_temp=weight_temp*user.getItems().get(phone);
				weight+=weight_temp;
			}
			else weight+=3*200*user.getItems().get(phone);
			
			if (phone.getPriceBY()!=-1){
				price+=phone.getPriceBY()*user.getItems().get(phone);
			}
			else price+=1000000*user.getItems().get(phone);
	    }
		System.out.println(weight);
		System.out.println(price);
		return getSumma(weight,price)/MainServlet.Currencies.get("USD");	
	}
	
	
	
	
	public static void main(String[] args) throws IOException{
		/*User user=SqlManager.GetUser("admin", "qqqq");
		user.addItem("474");user.addItem("474");
		user.addItem("477");*/

		System.out.println(Tarifikator.getSumma(600,16819800));
	}

}
