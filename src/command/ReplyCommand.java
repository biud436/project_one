package command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.ActionResult;

public class ReplyCommand extends Command {
		
	class Parameters {
		public String authorID;
		public int parentArticleID;
		public String contents;
		public String methods;
		public int depth;
		public int parentID;
		public int pos;
	}
	
	private Parameters param = new Parameters();
	
	public ReplyCommand()  {
		super();
	}
	
	public ActionResult execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		result.start(request, response);
		
		HttpSession session = request.getSession();
		
		param.authorID = (String)session.getAttribute("id");
		param.parentArticleID = Integer.parseInt(request.getParameter("postNumber"));;
		param.contents = request.getParameter("contents");
		param.methods = request.getParameter("method");
		param.depth = Integer.parseInt(request.getParameter("depth"));
		param.parentID = Integer.parseInt(request.getParameter("parentID"));
		param.pos = Integer.parseInt(request.getParameter("pos"));
				
		switch( param.methods ) {
		case "write":
			write(request, response);
			break;
		case "delete":
			delete(request, response);
			break;
		case "update":
			update(request, response);
			break;
		case "writeChild":
			writeChild(request, response);
		}
		
		if(param.authorID == null) {
			request.setAttribute("_status", "error");
			request.setAttribute("errorMessage", "댓글을 작성하려면 우선 로그인을 하셔야 합니다.");
			request.setAttribute("url", "/pages/board-default.jsp");
			
			result.forward("/pages/error.jsp");
			return result;
		}
		
		String redirect = response.encodeRedirectURL(request.getContextPath() 
				+ "/pages/board-post.jsp?postNumber=" 
				+ param.parentArticleID);
		
		result.sendRedirect(redirect);
		
		return result;
	}
	
	public void write(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		getDAO().writeComment(
					param.parentArticleID, 
					param.authorID, 
					param.contents
				);
	}	
	
	public void writeChild(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}	
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int parentArticleID = param.parentArticleID;
		
		String commentOrderRAW = request.getParameter("commentOrder");
		
		if(commentOrderRAW == null) {
			commentOrderRAW = "0";
		}
		
		int commentOrder = Integer.parseInt(commentOrderRAW);
		boolean isValid = getDAO().checkValidByAuthorIDForComment(parentArticleID, commentOrder, param.authorID);
		
		if(isValid) {
			getDAO().deleteCertainComment(parentArticleID, commentOrder);			
		}
	}
	
	public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
}
