package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Iterator;

import java.util.Map.Entry;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONArray;

import util.GoogleMail;
import util.MD5;
import util.Phone;
import util.User;
import util.sql.SqlManager;


public class RequestDecoder {
	private static RequestDecoder instance=null;
	
	public static RequestDecoder getInstance(){
		if (instance==null) instance=new RequestDecoder();
		return instance;
	}
	
	public String getPage(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String page="/jsp/Index.jsp";
		if (request.getParameter("mode")!=null){
			if (request.getParameter("mode").equals("reg"))page="/jsp/Registration.jsp";
			else if (request.getParameter("mode").equals("restore")){
				page="/jsp/Restore.jsp";
				if (request.getParameter("email")!=null){					
					String login=request.getParameter("email");
					int rand=new Random().nextInt(1000);
					String code=MD5.getInstance().getMD5(Integer.toString(rand));
					synchronized (this) {
						if (MainServlet.restoreCodes.containsValue(login))
							for (String key:MainServlet.restoreCodes.keySet()){
								if (MainServlet.restoreCodes.get(key).equals(login)){
									MainServlet.restoreCodes.remove(key);
									break;
								}
							}
						MainServlet.restoreCodes.put(code, login);
					}
					String message="Для восстановления пароля перейдите по следующей ссылке: " +
							"\n http://tomcat7-romif.rhcloud.com/index?mode=restore&code="+code;
					
					System.out.println("begin "+request.getSession().getId());
					response.setContentType("text/html;charset=utf-8");
					PrintWriter out = response.getWriter();
					if (SqlManager.IsUserExist(login)){
						try {
							GoogleMail.Send("romif.romif", "rjyjdfkj", login, "Восстановление пароля", message);
						} catch (MessagingException e) {
							e.printStackTrace();
						}
						out.print(1);
					}else out.print(0);
					out.flush();
					out.close();
					System.out.println("end "+request.getSession().getId());
					return null;	
				}
				
				if (request.getParameter("code")!=null){
					String code=request.getParameter("code");
					synchronized (this) {
						if (MainServlet.restoreCodes.containsKey(code)){
							String login=MainServlet.restoreCodes.get(code);
							MainServlet.restoreCodes.remove(code);
							request.setAttribute("login", login);
							return "/jsp/NewPass.jsp";
						}else return "/jsp/Index.jsp";
					}	
				}
			}
			else if (request.getParameter("mode").equals("newPass")){
				if ((request.getParameter("email")!=null)&&(request.getParameter("password")!=null)){
					response.setContentType("text/html;charset=utf-8");
					PrintWriter out = response.getWriter();
					JSONArray array=new JSONArray();
					if (SqlManager.UpdatePass(request.getParameter("email"), request.getParameter("password")))
						array.add("succes");
					else array.add("fail");
					out.print(array);
					out.flush();
					out.close();
					return null;	
				}else page="/jsp/Index.jsp";
			}
			else if (request.getParameter("mode").equals("delivery"))page="/jsp/Delivery.jsp";
			else if (request.getParameter("mode").equals("userinfo")){
				if ((request.getParameter("action")!=null)&&(request.getParameter("action").equals("update"))){
					User loggedUser=MainServlet.loggedUsers.get(request.getSession().getId());
					loggedUser.setName(request.getParameter("attr_name_3279"));
					loggedUser.setSurName(request.getParameter("attr_surname_3278"));
					loggedUser.setPatronymic(request.getParameter("attr_patronym_3280"));
					loggedUser.setTel(request.getParameter("attr_phone_925"));
					loggedUser.setE_mail(request.getParameter("attr_email_930"));
					SqlManager.UpdateUser(loggedUser);
				}
				if (MainServlet.loggedUsers.containsKey(request.getSession().getId())){
					page="/jsp/Userinfo.jsp";
				}else page="/jsp/Index.jsp";
				
			}
			else if (request.getParameter("mode").equals("login")){
				String login=request.getParameter("email");
				String pass=request.getParameter("password");
				User loggedUser=SqlManager.GetUser(login, pass);
				if (loggedUser!=null){
					if (MainServlet.loggedUsers.containsValue(loggedUser)){
						Iterator<Entry<String,User>> set=MainServlet.loggedUsers.entrySet().iterator();
						while (set.hasNext()){
							Entry<String,User> entry=set.next();
							if (entry.getValue().equals(loggedUser)){
								set.remove();
							}
						}
					}
					MainServlet.loggedUsers.put(request.getSession().getId(),loggedUser);
					page="/jsp/templates/loginPlace_logged.jsp";				
				}else{
					page="/jsp/templates/loginPlace_error.jsp";
				}	
			}
			else if (request.getParameter("mode").equals("exit")){
				MainServlet.loggedUsers.remove(request.getSession().getId());
				page="/jsp/Index.jsp";
			}
			else if (request.getParameter("mode").equals("edit")){
				if (request.getParameter("Button1")!=null){
					ServletFileUpload.isMultipartContent(request);
					
					Phone phone=new Phone();
					phone.setDescription(request.getParameter("TextArea1"));
					phone.setTextProperties(request.getParameterValues("textProperty"));
					Enumeration<String> en=request.getParameterNames();
					String st;
					byte[] b=new byte[67];
					while (en.hasMoreElements()){
						if ((st=en.nextElement()).contains("Checkbox")){
							b[Integer.parseInt(st.replace("Checkbox", ""))-1]=1;
						}
					}
					phone.setCheckboxes(b);
					SqlManager.AddPhone(phone);
					
					

					page="/jsp/Index.jsp";
				}
				else page="/jsp/Edit.jsp";
			}
			else if (request.getParameter("mode").equals("Apple")){
				System.out.println( request.getServletContext().getResource("/snoop.jsp"));

				page="/jsp/Apple.jsp";
			}
		}
		if (request.getParameter("model")!=null){
			String login=request.getParameter("reg_email");
			String pass=request.getParameter("reg_password");
			if ((login!=null)&&(pass!=null)){
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				JSONArray array=new JSONArray();
				try {
					if (SqlManager.AddNewUser(login,pass))array.add("succes");
					else array.add("fail");
				} catch (ClassNotFoundException e) {
					array.add(e.toString());
				} catch (SQLException e) {
					array.add(e.toString());
				}
				out.print(array);
				out.flush();
				out.close();
			}
			return null;
		}
		
		return page;
		
	}


	
}
