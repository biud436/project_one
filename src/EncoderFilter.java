

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 * �����̳� JSP���� �������� ó���ؾ� �� �۾��� ���Ϳ��� ������ �� �ֽ��ϴ�.
 * �� Ŭ������ ��� request ����� ���� ���ڵ��� UTF-8�� �����ϴ� ������ �մϴ�.
 */
@WebFilter("/*")
public class EncoderFilter implements Filter {
	
	private ServletContext mContext;

    /**
     * Default constructor. 
     */
    public EncoderFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub

		// ���ڵ� ������ UTF-8�� �����մϴ�.
		request.setCharacterEncoding("UTF-8");

		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		mContext = fConfig.getServletContext();
	}

}
