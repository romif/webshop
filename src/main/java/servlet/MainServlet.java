package servlet;

import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jdom.JDOMException;

import util.DBConfigurator;
import util.User;




public class MainServlet extends HttpServlet implements javax.servlet.Servlet {
	public static Map<String,User> loggedUsers=new HashMap<String,User>();
	public static Map<String,String> restoreCodes=new HashMap<String,String>();
	public static String[] DBConfig=null;


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public MainServlet() {
		super();
		try {
			System.setOut(new PrintStream(new BufferedOutputStream(new FileOutputStream(
					System.getenv("OPENSHIFT_DATA_DIR") + "Logs")),true));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		
		
	}
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
	throws ServletException, IOException{
		processRequest(request, response);
		}
	
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException, IOException{
		processRequest(request, response);
		}
	
	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (DBConfig==null)
			try {
				DBConfig=DBConfigurator.getConfig(getServletContext().getRealPath("WEB-INF"));
			} catch (IOException e) {
				e.printStackTrace();
			} catch (JDOMException e) {
				e.printStackTrace();
			}
		
		
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("user_id");
		if (user_id==null){
			user_id=session.getId();
			session.setAttribute("user_id", user_id);
		}
		System.out.println(request.getSession().getId());
		
		String page = null;
		page="/jsp/Index.jsp";
		page=RequestDecoder.getInstance().getPage(request, response);
		if (page!=null){
			RequestDispatcher dispatcher =getServletContext().getRequestDispatcher(page);
			dispatcher.forward(request, response);
		}
	}

}
