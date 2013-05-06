package util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
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
			Connection connection= Jsoup.connect("http://tomcat7-romif.rhcloud.com/index?phoneID=45");
			connection.timeout(10000);
			doc = connection.get();
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
			Connection connection=Jsoup.connect("http://tomcat7-romif.rhcloud.com/index?topmobail=");
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
				st=st.replaceAll(" ", "%20");
				img.add(st);
				
				desc.add(((Element) element.childNode(3)).text());
				title.add(element.childNode(1).childNode(0).attr("title"));
				href.add(element.childNode(1).childNode(0).attr("href"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		for (int i=0;i<0;i++){
			Phone phone=new Phone();
			phone.put("Manufactor", title.get(i).split(" ")[0]);
			phone.put("Title", title.get(i));
			phone.put("Description", desc.get(i));
			phone.put("firstPrice", firstPrice.get(i));
			phone.put("secondPrice", secondPrice.get(i));
			try {
				Connection connection= Jsoup.connect(href.get(i));
				connection.timeout(10000);
				doc = connection.get();
				
				Elements elements = doc.select(".descBig [valign=top] tr");
				
				Iterator<Element> it=elements.iterator();
				while (it.hasNext()) {
					Element element=it.next();
					String st="";
					
					Elements elements1 =element.getElementsContainingOwnText(name1.get(1));
					if (!elements1.isEmpty())System.out.println(elements1);
					/*if (node.childNodeSize()==5){
						System.out.println(node.childNode(1).childNodeSize());
						if (node.childNode(1).childNodeSize()>1){
							System.out.println(node.childNode(1));
							System.out.println(node.childNode(1).childNode(1));
							System.out.println(node.childNode(1).childNode(2));
						}
						else System.out.println(node.childNode(1).childNode(0));
						break;
					}
						//System.out.println(((Element) node.childNode(1).childNode(2)).text());
						//st=((Element) node.childNode(1).childNode(1)).text();
					
					/*
					if (node.childNode(1).childNodeSize()==1)
						st=((Element) node.childNode(1).childNode(0)).text();
					else if (node.childNode(1).childNodeSize()==3)
						st=((Element) node.childNode(1).childNode(2)).html();*/

					/*if (map.containsKey(st)) {
						name2.add(st);
						if (node.childNode(3).childNodeSize()>1){
							if ( node.childNode(3).childNode(0).attr("alt").equals("Да"))
								phone.put(map.get(st), "on");
						}
						else phone.put(map.get(st), ((Element) node.childNode(3)).text());
						//System.out.println(((Element) node.childNode(3)).text());
					}*/
				}
				
				/*int id=SqlManager.AddPhone(phone);
				String uploadStorage=System.getenv("OPENSHIFT_DATA_DIR")+File.separator+"pictures"+File.separator;
				InputStream in = new BufferedInputStream(new URL(img.get(i)).openStream());
				OutputStream out=new BufferedOutputStream(new FileOutputStream(new File(uploadStorage+id+".jpg")));
				int j;
				while ((j=in.read())!=-1)out.write(j);
				in.close();
				out.close();
				System.out.println(i+1+". Added phone "+title.get(i));*/
				
				System.out.println(phone);
				
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			//phones.add(phone);
			
		
		}
		
		
		
		
		for (int i=0;i<10;i++){
			Phone phone=new Phone();
			phone.put("Manufactor", title.get(i).split(" ")[0]);
			phone.put("Title", title.get(i));
			phone.put("Description", desc.get(i));
			phone.put("firstPrice", firstPrice.get(i));
			phone.put("secondPrice", secondPrice.get(i));
			try {
				Connection connection= Jsoup.connect(href.get(i));
				connection.timeout(10000);
				doc = connection.get();
				Elements elements = doc.select(".descBig [valign=top]");
				Iterator<Element> it=elements.iterator();
				while (it.hasNext()) {
					Element element=it.next();
					if (element.childNodeSize()==3){
						for (int j=0;j<name1.size() ;j++){
							Elements elements1 =element.getElementsContainingText(name1.get(j));
							Iterator<Element> it1=elements1.iterator();
							while (it1.hasNext()) {
								Element element1=it1.next();
								if (element1.childNodeSize()==5){
									if (element1.childNode(3).childNodeSize()>1){
										if ( element1.childNode(3).childNode(0).attr("alt").equals("Да"))
											phone.put(attr.get(j), "on");
									}
									else phone.put(attr.get(j), ((Element) element1.childNode(3)).text());
								}
							}
						}	
					}	
				}
				
				int id=SqlManager.AddPhone(phone);
				String uploadStorage=System.getenv("OPENSHIFT_DATA_DIR")+File.separator+"pictures"+File.separator;
				InputStream in = new BufferedInputStream(new URL(img.get(i)).openStream());
				OutputStream out=new BufferedOutputStream(new FileOutputStream(new File(uploadStorage+id+".jpg")));
				int j;
				while ((j=in.read())!=-1)out.write(j);
				in.close();
				out.close();
				System.out.println(i+1+". Added phone "+title.get(i));
				System.out.println(phone);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		

		

		System.out.println(name1);
		//System.out.println(phones);

	}

}
