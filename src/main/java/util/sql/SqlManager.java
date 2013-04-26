package util.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import servlet.MainServlet;
import util.MD5;
import util.Phone;
import util.User;

public final class SqlManager {
	
	private final static String driver="org.gjt.mm.mysql.Driver";
	private final static String url = String.format("jdbc:mysql://%s:%s/",
			System.getenv("OPENSHIFT_MYSQL_DB_HOST"),
			System.getenv("OPENSHIFT_MYSQL_DB_PORT"));
	private final static String userName=System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
	private final static String password=System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
	private final static String DBName=System.getenv("OPENSHIFT_GEAR_NAME")+
			"?useUnicode=true&characterEncoding=UTF-8";

	
	private SqlManager(){};
	
	public static boolean AddNewUser(String login, String pass) throws SQLException, ClassNotFoundException{
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		boolean bool=false;
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT * FROM users_pass "
					+"WHERE user_name='"+login+"'");
			if (!rs.next()){
				st.executeUpdate("INSERT INTO users_pass (user_name, password, access) " +
					"VALUES ('"+login+"', '"+MD5.getInstance().getMD5(pass)+"', 'user')");
				bool=true;	
				rs = st.executeQuery("SELECT userid FROM users_pass "+
					"WHERE user_name='"+login+"'");
				rs.next();
				int userid=rs.getInt("userid");
				User user=new User();
				String sql="INSERT INTO users_info (userid, name, surname, patronymic, tel, e_mail) " +
						"VALUES ("+userid+", '"+user.getName()+"', '"+user.getSurName()+"', '"+user.getPatronymic()+"'," +
						" '"+user.getTel()+"','"+user.getE_mail()+"')";
				st.executeUpdate(sql);
			}
		} 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return bool;
	}
	
	public static boolean UpdateUser(User user){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs= null; 
		ResultSet rs1 = null; 
		boolean bool=false;
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT userid FROM users_pass "
					+"WHERE user_name='"+user.getLogin()+"'");
			if (rs.next()){
				int userid=rs.getInt("userid");
				rs1=st.executeQuery("SELECT * FROM users_info WHERE userid="+userid);
				if (rs1.next()){
					String sql="UPDATE users_info " +
							"SET name='"+user.getName()+"', surname='"+user.getSurName()+"'," +
							" patronymic='"+user.getPatronymic()+"', tel='"+user.getTel()+"', " +
							"e_mail='"+user.getE_mail()+"' WHERE userid='"+userid+"'";
					st.executeUpdate(sql);
				}
				else{
					String sql="INSERT INTO users_info (userid, name, surname, patronymic, tel, e_mail) " +
							"VALUES ("+userid+", '"+user.getName()+"', '"+user.getSurName()+"', '"+user.getPatronymic()+"'," +
							" '"+user.getTel()+"','"+user.getE_mail()+"')";
					st.executeUpdate(sql);
				}
				bool=true;
				
			}
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return bool;
	}
	
	public static User GetUser(String login, String pass){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		User user=null;
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT * FROM users_pass "
					+"WHERE user_name='"+login+"'");
			if (rs.next()){
				if (rs.getString("password").equals(MD5.getInstance().getMD5(pass))){
					user=new User();
					int userid=rs.getInt("userid");
					user.setLogin(login);
					user.setAccess(rs.getString("access"));
					rs = st.executeQuery("SELECT * FROM users_info "
							+"WHERE userid='"+userid+"'");
					if (rs.next()){
						user.setName(rs.getString("name"));
						user.setSurName(rs.getString("surname"));
						user.setPatronymic(rs.getString("patronymic"));
						user.setTel(rs.getString("tel"));
						user.setE_mail(rs.getString("e_mail"));
					}
				}
			}
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return user;
	}
	
	public static User GetUser(String user_id){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		User user=null;
		String login=MainServlet.loggedUsers.get(user_id).getLogin();
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password);  
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT users_pass.user_name, users_info.name, users_info.surname,users_info.patronymic," +
					" users_info.tel, users_info.e_mail " +
					"FROM users_info,users_pass " +
					"WHERE ((users_pass.user_name='"+login+"') AND (users_pass.userid=users_info.userid))");
			user=new User();
			user.setLogin(login);
			if (rs.next()){
				user.setName(rs.getString("name"));
				user.setSurName(rs.getString("surname"));
				user.setPatronymic(rs.getString("patronymic"));
				user.setTel(rs.getString("tel"));
				user.setE_mail(rs.getString("e_mail"));
			}
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return user;
	}	
	
	public static boolean IsUserExist(String login){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		boolean bool=false;
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT * FROM users_pass "
					+"WHERE user_name='"+login+"'");
			if (rs.next()){
				bool=true;
			}
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return bool;
	}
	
	public static boolean UpdatePass(String login, String pass){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		boolean bool=false;
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT * FROM users_pass "
					+"WHERE user_name='"+login+"'");
			if (rs.next()){
				bool=true;
				st.executeUpdate("UPDATE users_pass SET password='" + MD5.getInstance().getMD5(pass)+
						"' WHERE user_name='"+login+"'");	
			}
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return bool;
	}
	
	public static int AddPhone(Phone phone){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		int id=-1;
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			String FullDescription="";
			for (Map.Entry<String, String> entry:phone.entrySet()){
				FullDescription+=entry.getKey()+";"+entry.getValue()+";";
			}
			
			st.executeUpdate("INSERT INTO Phones (Title, Description, FirstPrice,SecondPrice,FullDescription) " +
					"VALUES ('"+phone.get("textProperty1")+"', '"+phone.get("TextArea1")+
					"', '"+Integer.parseInt(phone.get("firstPrice"))+"', '"+Integer.parseInt(phone.get("secondPrice"))+"','"+FullDescription+"')");
			rs = st.executeQuery("SELECT LAST_INSERT_ID()");
			if (rs.next())id=rs.getInt("LAST_INSERT_ID()");
			st.executeUpdate("INSERT INTO Phone_IDs (PhoneID,PhoneMan) " +
					"VALUES ("+id+",'"+phone.get("textProperty0")+"')");
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		catch (NumberFormatException ex){
			System.out.println(ex.toString());
		}
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return id;
	}
	
	public static List<Phone> GetPhones(String manufacture){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		List<Phone> phones=new ArrayList<Phone>();
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password);  
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT * FROM Phone_IDs,Phones "
					+"WHERE (Phone_IDs.PhoneMan='"+manufacture+"')AND(Phone_IDs.PhoneID=Phones.PhoneID)"); 
			while (rs.next()){
				Phone phone=new Phone();
				String[] FullDiscription=rs.getString("FullDescription").split(";");
				for (int i=0;i<FullDiscription.length-1;i+=2){
					phone.put(FullDiscription[i], FullDiscription[i+1]);
				}
				phone.setId(rs.getInt("PhoneID"));
				phones.add(phone);
			}
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return phones;
	}
	
	private ResultSet SQLQuery(String query){
		return null;
	}
	
	public static Map<Integer,String> GetTitles(String manufacture){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		Map<Integer,String> map=new HashMap<Integer,String>();
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT Phones.PhoneID,Phones.Title FROM Phone_IDs,Phones "
					+"WHERE (Phone_IDs.PhoneMan='"+manufacture+"')" +
							"AND(Phone_IDs.PhoneID=Phones.PhoneID)"); 
			while (rs.next()){
				map.put(rs.getInt("Phones.PhoneID"), rs.getString("Phones.Title"));
			}
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return map;
	}
	
	public static Phone GetPhone(int phoneId){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		Phone phone=new Phone();
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT PhoneID,FullDescription FROM Phones "
					+"WHERE PhoneID='"+phoneId+"'"); 
			if (rs.next()){
				String[] FullDiscription=rs.getString("FullDescription").split(";");
				for (int i=0;i<FullDiscription.length-1;i+=2){
					phone.put(FullDiscription[i], FullDiscription[i+1]);
				}
				phone.setId(rs.getInt("PhoneID"));
			}
		}
		catch (SQLException ex) {            
            System.out.println(ex.toString());
        } 
		catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } 
		finally {
			try{
				if (rs != null) rs.close(); 
				if (st != null) st.close(); 
				if (cn != null) cn.close(); 
			}
			catch (SQLException ex) {            
	            System.out.println(ex.toString());
	        }
		} 
		return phone; 
	}
	
	
	public static void main(String[] args){
		//System.out.print(SqlManager.UpdatePass("romif@yandex.ru", "wwww"));
		System.out.print(SqlManager.GetPhone(31));

	}

}
