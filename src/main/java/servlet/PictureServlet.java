package servlet;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet(name = "picture",urlPatterns = {"/picture/*"})
public class PictureServlet extends HttpServlet {
 
  int BUFFER_LENGTH = 4;
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
  }
 
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  if (request.getParameter("pic")!=null){
		  String uploadStorage=System.getenv("OPENSHIFT_DATA_DIR")+File.separator+"pictures";
		  String filePath = uploadStorage + File.separator+request.getParameter("pic")+".jpg";
		  File picture = new File(filePath); 
		  InputStream is =new BufferedInputStream(new FileInputStream(picture));
	  
	  //InputStream is=request.getServletContext().getResourceAsStream("/pics/logo.gif");
	  OutputStream os=response.getOutputStream();
	  int i;
	  while ((i=is.read())!=-1)os.write(i);
	  is.close();
	  os.close();
	  }
  }
 
 
}
