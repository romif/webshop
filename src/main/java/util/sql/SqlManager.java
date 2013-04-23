package util.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import servlet.MainServlet;
import util.MD5;
import util.Phone;
import util.User;

public final class SqlManager {
	/*private static SqlManager instance=null;
	public static SqlManager getInstance(){
		if (instance==null) instance=new SqlManager();
		return instance;
	}*/
	
	private SqlManager(){};
	
	public static boolean AddNewUser(String login, String pass) throws SQLException, ClassNotFoundException{
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		boolean bool=false;
		try {
			Class.forName(MainServlet.DBConfig[0]); 
			cn = DriverManager.getConnection(MainServlet.DBConfig[1]+MainServlet.DBConfig[4], 
					MainServlet.DBConfig[2], MainServlet.DBConfig[3]); 
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
			Class.forName(MainServlet.DBConfig[0]); 
			cn = DriverManager.getConnection(MainServlet.DBConfig[1]+MainServlet.DBConfig[4], 
					MainServlet.DBConfig[2], MainServlet.DBConfig[3]); 
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
			Class.forName(MainServlet.DBConfig[0]); 
			cn = DriverManager.getConnection(MainServlet.DBConfig[1]+MainServlet.DBConfig[4], 
					MainServlet.DBConfig[2], MainServlet.DBConfig[3]); 
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
			Class.forName(MainServlet.DBConfig[0]); 
			cn = DriverManager.getConnection(MainServlet.DBConfig[1]+MainServlet.DBConfig[4], 
					MainServlet.DBConfig[2], MainServlet.DBConfig[3]); 
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
			Class.forName(MainServlet.DBConfig[0]); 
			cn = DriverManager.getConnection(MainServlet.DBConfig[1]+MainServlet.DBConfig[4], 
					MainServlet.DBConfig[2], MainServlet.DBConfig[3]); 
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
			Class.forName(MainServlet.DBConfig[0]); 
			cn = DriverManager.getConnection(MainServlet.DBConfig[1]+MainServlet.DBConfig[4], 
					MainServlet.DBConfig[2], MainServlet.DBConfig[3]); 
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
	
	public static boolean AddPhone(Phone phone){
		Connection cn = null;
		Statement st = null; 
		ResultSet rs = null; 
		boolean bool=false;
		try {
			Class.forName(MainServlet.DBConfig[0]); 
			cn = DriverManager.getConnection(MainServlet.DBConfig[1]+MainServlet.DBConfig[4], 
					MainServlet.DBConfig[2], MainServlet.DBConfig[3]); 
			st = cn.createStatement(); 
			String FullDescription="";
			for (Map.Entry<String, String> entry:phone.entrySet()){
				FullDescription+=entry.getKey()+";"+entry.getValue()+";";
			}
			
			/*String getTextProperties[]=phone.getTextProperties();
			for (int i=0;i<getTextProperties.length;i++)FullDescription+=getTextProperties[i]+";";
			byte[] checkboxes=phone.getCheckboxes();
			for (int i=0;i<checkboxes.length;i++)FullDescription+=checkboxes[i]+";";*/
			
			st.executeUpdate("INSERT INTO Phones (Title, Description, FirstPrice,SecondPrice,FullDescription) " +
					"VALUES ('"+phone.get("textProperty1")+"', '"+phone.get("TextArea1")+"', '"+phone.get("textProperty2")+"', '"+phone.get("textProperty3")+"','"+FullDescription+"')");
			st.executeUpdate("INSERT INTO Phone_IDs (PhoneID,PhoneMan) " +
					"VALUES (LAST_INSERT_ID(),'"+("textProperty0")+"')");
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
	
	public static List<Phone> GetPhones(String manufacture){
		Connection cn = null;
		Statement st = null; 
		Statement st1 = null; 
		ResultSet rs = null; 
		ResultSet rs1 = null; 
		List<Phone> phones=new ArrayList<Phone>();
		try {
			Class.forName(MainServlet.DBConfig[0]); 
			cn = DriverManager.getConnection(MainServlet.DBConfig[1]+MainServlet.DBConfig[4], 
					MainServlet.DBConfig[2], MainServlet.DBConfig[3]); 
			st = cn.createStatement(); 
			st1 = cn.createStatement();
			rs = st.executeQuery("SELECT PhoneID FROM Phone_IDs "
					+"WHERE PhoneMan='"+manufacture+"'");
			while (rs.next()){
				rs1=st1.executeQuery("SELECT * FROM Phones "
						+"WHERE PhoneID='"+rs.getInt("PhoneID")+"'");
				Phone phone=new Phone();
				String[] FullDiscription;
				if (rs1.next()) {
					FullDiscription=rs1.getString("FullDescription").split(";");
					String[] textProperties=new String[36];
					String[] checkboxes_temp=new String[67];
					byte[] checkboxes=new byte[67];
					System.arraycopy(FullDiscription, 0, textProperties, 0, 36);
					System.arraycopy(FullDiscription, 36, checkboxes_temp, 0, 67);
					for (int i=0;i<checkboxes_temp.length;i++)
						checkboxes[i]=Byte.parseByte(checkboxes_temp[i]);
					phone.setCheckboxes(checkboxes);
					phone.setTextProperties(textProperties);
					phone.setDescription(rs1.getString("Description"));
					phones.add(phone);
				}
			}
			
			/*String FullDiscription="";
			String getTextProperties[]=phone.getTextProperties();
			for (int i=0;i<getTextProperties.length;i++)FullDiscription+=getTextProperties[i]+";";
			byte[] checkboxes=phone.getCheckboxes();
			for (int i=0;i<checkboxes.length;i++)FullDiscription+=checkboxes[i]+";";
			st.executeUpdate("INSERT INTO Phones (Title, Description, FirstPrice,SecondPrice,FullDiscription) " +
					"VALUES ('"+phone.getTextProperties()[1]+"', '"+phone.getDescription()+"', '"+phone.getTextProperties()[2]+"', '"+phone.getTextProperties()[3]+"','"+FullDiscription+"')");
			st.executeUpdate("INSERT INTO Phone_IDs (PhoneID,PhoneMan) " +
					"VALUES (LAST_INSERT_ID(),'"+phone.getTextProperties()[0]+"')");*/
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
				if (rs1 != null) rs1.close(); 
				if (st != null) st.close(); 
				if (st1 != null) st1.close(); 
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
		System.out.print(Math.ceil((double)1/2));

	}

}
