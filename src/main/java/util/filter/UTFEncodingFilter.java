package util.filter;

import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 * Servlet Filter implementation class Filter
 */
@WebFilter("/UTFEncodingFilter")
public class UTFEncodingFilter implements javax.servlet.Filter {

    /**
     * Default constructor. 
     */
    public UTFEncodingFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see UTFEncodingFilter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see UTFEncodingFilter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
	        FilterChain chain) throws IOException, ServletException {
	    // System.out.println("request: " + request.getCharacterEncoding());
	    // System.out.println("response: " + response.getCharacterEncoding());
	    //request.setCharacterEncoding("UTF-8");
	    //response.setCharacterEncoding("UTF-8");
	    chain.doFilter(request, response);
	}

	/**
	 * @see UTFEncodingFilter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
