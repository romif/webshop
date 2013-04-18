package servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet(name = "logs",urlPatterns = {"/logs/*"})
public class LogServlet extends HttpServlet {
 
  int BUFFER_LENGTH = 4;
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
  }
 
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  
   
    
    

    
 
    /*response.setContentLength((int) file.length());
    response.setContentType(new MimetypesFileTypeMap().getContentType(file));*/
    
 
    //OutputStream output = response.getOutputStream();
   /* byte[] bytes = new byte[BUFFER_LENGTH];
    int read = 0;
    while (read != -1) {
      read = input.read(bytes, 0, BUFFER_LENGTH);
      if (read != -1) {
        output.write(bytes, 0, read);
        output.flush();
      }
    }*/
	File file = new File(System.getenv("OPENSHIFT_DATA_DIR") + "Logs");
    BufferedReader br=new BufferedReader(new FileReader (file));
    response.setContentType("text/html;charset=utf-8");
    PrintWriter out = response.getWriter();
    String st;
    while (!(st=br.readLine()).equals(""))out.println(st);
    out.close();
    br.close();

	  
    //input.close();
    //output.close();
  }
 
 
}
