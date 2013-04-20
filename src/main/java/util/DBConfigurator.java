package util;


public class DBConfigurator {

	public DBConfigurator()  {		
	}
	
	public static String[] getConfig(){
		String [] DBConfig=new String[5];
		DBConfig[0]="org.gjt.mm.mysql.Driver";
		String host = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
		String port = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
		String url = String.format("jdbc:mysql://%s:%s/", host, port);
		DBConfig[1]=url;
		DBConfig[2]=System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
		DBConfig[3]=System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
		DBConfig[4]=System.getenv("OPENSHIFT_GEAR_NAME")+"?useUnicode=true&characterEncoding=UTF-8";
		
		
		return DBConfig;
	}

}
