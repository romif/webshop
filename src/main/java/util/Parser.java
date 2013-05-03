package util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import util.sql.SqlManager;
import util.Phone;


public class Parser {
	

	public Parser() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		List<String> href=new ArrayList<String>();
		List<String> desc=new ArrayList<String>();
		List<String> title=new ArrayList<String>();
		List<String> attr=new ArrayList<String>();
		List<String> name1=new ArrayList<String>();
		List<String> name2=new ArrayList<String>();
		List<String> firstPrice=new ArrayList<String>();
		List<String> secondPrice=new ArrayList<String>();
		List<String> img=new ArrayList<String>();
		
		Map<String,String>map=new HashMap<String,String>();
		List<Phone>phones=new ArrayList<Phone>();
		//Map<String,String>mapAttr=new HashMap<String,String>();
		
		Document doc=null;
		try {
			doc = Jsoup.connect("/index?phoneID=45").get();
			Elements elements = doc.select(".descBig tbody");
			Iterator<Node> it=elements.last().childNodes().iterator();
			while (it.hasNext()) {
				Node node=it.next();
				if (node.childNodeSize()==5){
					attr.add(((Element) node.childNode(3)).id());
					name1.add(((Element) node.childNode(1).childNode(1)).html());
					map.put(((Element) node.childNode(1).childNode(1)).html(),((Element) node.childNode(3)).id());
				}
				
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		try {
			Connection connection=Jsoup.connect("/index?topmobail=");
			connection.timeout(10000);
			doc = connection.get();
			Elements elements = doc.select("#centerColumn .itemBlockCont");
			Iterator<Element> it=elements.iterator();
			while (it.hasNext()) {
				Node element=it.next();
				/*href.add("http://catalog.onliner.by/"+element.childNode(0).attr("href"));
				img.add(element.childNode(0).childNode(0).attr("src"));*/
				
				
				String st;
				st=((Element) element.childNode(5).childNode(0).childNode(0).childNode(0).childNode(1).childNode(1)).text();
				st=st.substring(0, st.indexOf('$')-1);
				firstPrice.add(st);
				
				st=((Element) element.childNode(5).childNode(0).childNode(0).childNode(0).childNode(1).childNode(3)).text();
				st=st.substring(0, st.indexOf('р')-1);
				st=st.replaceAll(" ", "");
				secondPrice.add(st);
				
				st=element.childNode(1).childNode(0).childNode(0).attr("src");
				st=st.replaceAll("./TopmoBail_files", "http://topmobail.shop.by/pics/items");
				img.add(st);
				
				desc.add(((Element) element.childNode(3)).text());
				title.add(element.childNode(1).childNode(0).attr("title"));
				href.add(element.childNode(1).childNode(0).attr("href"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		for (int i=0;i<1;i++){
			Phone phone=new Phone();
			phone.put("Manufactor", title.get(i).split(" ")[0]);
			phone.put("Title", title.get(i));
			phone.put("Description", desc.get(i));
			phone.put("firstPrice", firstPrice.get(i));
			phone.put("secondPrice", secondPrice.get(i));
			
			
		try {
			doc = Jsoup.connect(href.get(i)).get();
			Elements elements = doc.select(".pline2");
			Iterator<Element> it=elements.iterator();
			while (it.hasNext()) {
				Node node=it.next();
				//System.out.println(node.childNode(1).childNodeSize());
				String st="";
				if (node.childNode(1).childNodeSize()==1)
					st=((Element) node.childNode(1).childNode(0)).text();
				else if (node.childNode(1).childNodeSize()==3)
					st=((Element) node.childNode(1).childNode(2)).html();
				if (map.containsKey(st)) {
					name2.add(st);
					if (node.childNode(3).childNodeSize()>1){
						if ( node.childNode(3).childNode(0).attr("alt").equals("Да"))
							phone.put(map.get(st), "on");
					}
					else phone.put(map.get(st), ((Element) node.childNode(3)).html());
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		phones.add(phone);
		}
		
		//SqlManager.AddPhone(phones.get(0));
		

		System.out.println(img);
		System.out.println(phones);

	}

}
