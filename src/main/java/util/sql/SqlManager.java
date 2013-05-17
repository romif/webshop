package util.sql;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



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
		int manufId;
		int id=-1;
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT ManufId FROM Manuf_IDs WHERE (Manuf='"+phone.getManufactor()+"')");
			if (rs.next()){
				manufId=rs.getInt("ManufId");
			}
			else {
				rs = st.executeQuery("SELECT LAST_INSERT_ID()");
				st.executeUpdate("INSERT INTO Manuf_IDs (Manuf) VALUES ('"+phone.getManufactor()+"')");
				manufId=rs.getInt("LAST_INSERT_ID()");
			}
			String WRITE_PHONE_SQL ="INSERT INTO Phones (ManufId, Title, Description, Price,SecondPrice, Map) " +
									"VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = cn.prepareStatement(WRITE_PHONE_SQL);
			pstmt.setInt(1, manufId);
			pstmt.setString(2, phone.getTitle());
			pstmt.setString(3, phone.getDescription());
			pstmt.setInt(4, phone.getPriceUSD());
			pstmt.setInt(5, phone.getPriceUSD());
		    pstmt.setObject(6, phone);
		    pstmt.executeUpdate();
		    pstmt.close();
		    rs = st.executeQuery("SELECT LAST_INSERT_ID()");
		    if (rs.next()){
		    	id=rs.getInt("LAST_INSERT_ID()");
		    }
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
			cn.setAutoCommit(false);
			String READ_OBJECT_SQL = 
					"SELECT Phones.PhoneID, Phones.Title, Phones.Description, Phones.Price,Phones.SecondPrice " +
					"FROM Phones, Manuf_IDs " +
					"WHERE ((Manuf_IDs.Manuf=?) AND (Manuf_IDs.ManufId=Phones.ManufId))";
			PreparedStatement pstmt = cn.prepareStatement(READ_OBJECT_SQL);
			pstmt.setString(1, manufacture);
			rs = pstmt.executeQuery();
			while (rs.next()){
				/*Blob blob = (Blob)rs.getBlob("Map");
				ObjectInputStream in= new ObjectInputStream(blob.getBinaryStream());
				Phone phone=(Phone)in.readObject();*/
				Phone phone=new Phone();
				phone.put("Title",rs.getString("Title"));
				phone.put("Description",rs.getString("Description"));
				phone.put("Price",rs.getString("Price"));
				phone.put("secondPrice",rs.getString("secondPrice"));
				phone.setId(rs.getInt("PhoneID"));
				phones.add(phone);
			}
		} catch (SQLException ex) {            
            System.out.println(ex.toString());
        } catch (ClassNotFoundException ex) {            
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
	
	
	public static Map<Integer,String> GetTitles(int ManufId){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		Map<Integer,String> map=new HashMap<Integer,String>();
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT PhoneID,Title FROM Phones "
								+"WHERE (ManufId='"+ManufId+"')"); 
			while (rs.next()){
				map.put(rs.getInt("PhoneID"), rs.getString("Title"));
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
			
			cn.setAutoCommit(false);
			String READ_OBJECT_SQL = "SELECT Map FROM Phones WHERE PhoneID=?";
			PreparedStatement pstmt = cn.prepareStatement(READ_OBJECT_SQL);
			pstmt.setInt(1, phoneId);
			rs = pstmt.executeQuery();
			if (rs.next()){
				Blob blob = (Blob)rs.getBlob("Map");
				ObjectInputStream in= new ObjectInputStream(blob.getBinaryStream());
				phone=(Phone)in.readObject();
				phone.put("Price",phone.get("firstPrice"));
			}
			else return null;
		}catch (SQLException ex) {            
            System.out.println(ex.toString());
        }catch (ClassNotFoundException ex) {            
            System.out.println(ex.toString());
        } catch (IOException e) {
			e.printStackTrace();
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
	
	public static void UpdatePhone(Phone phone){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			String FullDescription="";
			for (Map.Entry<String, String> entry:phone.entrySet()){
				FullDescription+=entry.getKey()+";"+entry.getValue()+";";
			}
			
			st.executeUpdate("UPDATE Phones " +
					"SET Title='"+phone.getTitle()+"', " +
						"Description='"+phone.getDescription()+"', " +
						"Price='"+phone.getPriceUSD()+"', " +
						"SecondPrice='"+phone.getPriceUSD()+"', " +
						"FullDescription='"+FullDescription+"' "+
						"WHERE PhoneID='"+phone.getId()+"'");
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
	}
	
	public static boolean DeletePhone(int phoneId){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		boolean bool=false;
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			st.executeUpdate("DELETE FROM Phones "
					+"WHERE PhoneID='"+phoneId+"'"); 
			st.executeUpdate("DELETE FROM Phone_IDs "
					+"WHERE PhoneID='"+phoneId+"'"); 
			bool=true;
			
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
	
	
	public static Map<Integer,String> GetPhonesManuf(){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		Map <Integer,String> map=new HashMap<Integer,String>();
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			st = cn.createStatement(); 
			rs = st.executeQuery("SELECT * FROM Manuf_IDs");
			while (rs.next()){
				map.put(rs.getInt("ManufId"),rs.getString("Manuf"));
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
	
	
	public static List<Phone> SearchPhones(String search,String price_before, String price_after){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		List<Phone> phones=new ArrayList<Phone>();
		int beforePrice,afterPrice;
		try {
			beforePrice=Integer.parseInt(price_before);
		} catch (NumberFormatException ex){
			beforePrice=0;
		}
		try {
			afterPrice=Integer.parseInt(price_after);
		} catch (NumberFormatException ex){
			afterPrice=Integer.MAX_VALUE;
		}
		try {
			Class.forName(driver); 
			cn = DriverManager.getConnection(url+DBName,userName, password); 
			cn.setAutoCommit(false);
			String READ_OBJECT_SQL = 
					"SELECT PhoneID, Title, Description, Price,SecondPrice " +
					"FROM Phones " +
					"WHERE ((Title LIKE '%"+search+"%') OR (Description LIKE '%"+search+"%')) " +
							"AND ((Price>"+beforePrice+")AND(Price<"+afterPrice+"))";
			PreparedStatement pstmt = cn.prepareStatement(READ_OBJECT_SQL);
			/*pstmt.setString(1, search);
			pstmt.setString(2, search);*/
			rs = pstmt.executeQuery();
			while (rs.next()){
				Phone phone=new Phone();
				phone.put("Title",rs.getString("Title"));
				phone.put("Description",rs.getString("Description"));
				phone.put("Price",rs.getString("Price"));
				phone.put("secondPrice",rs.getString("secondPrice"));
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
	
	public static void main(String[] args){
		//System.out.print(SqlManager.UpdatePass("romif@yandex.ru", "wwww"));
		//System.out.print(SqlManager.SearchPhones("Каждому"));

	}

}
