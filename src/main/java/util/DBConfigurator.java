package util;

import java.io.IOException;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

public class DBConfigurator {

	public DBConfigurator()  {		
	}
	
	public static String[] getConfig(String path) throws JDOMException, IOException{
		String [] DBConfig=new String[5];
		/*SAXBuilder builder = new SAXBuilder();
		Document document = builder.build(path+"/DBConfig.xml");
		Element root = document.getRootElement();
		DBConfig[0]=root.getAttribute("Driver").getValue();
		DBConfig[1]=root.getAttribute("ConnectionURL").getValue();
		DBConfig[2]=root.getAttribute("RootUser").getValue();
		DBConfig[3]=root.getAttribute("RootPassword").getValue();
		DBConfig[4]=root.getAttribute("DatabaseName").getValue();*/
		
		DBConfig[0]="org.gjt.mm.mysql.Driver";
		String host = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
		String port = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
		String url = String.format("jdbc:mysql://%s:%s/", host, port);
		DBConfig[1]=url;
		DBConfig[2]=System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
		DBConfig[3]=System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
		DBConfig[4]=System.getenv("OPENSHIFT_GEAR_NAME");
	
		
		return DBConfig;
	}

}
