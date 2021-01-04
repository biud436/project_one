package command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import action.ActionResult;
import dao.ContentDAO;
import vo.ProductVO;

public class FindShopByIdCommand extends Command {
	@SuppressWarnings("unchecked")
	@Override
	public ActionResult execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		result.start(request, response);
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		ContentDAO contentDAO = ContentDAO.getInstance();
		ProductVO vo = contentDAO.findShopDataAsID(id);
		
		JSONObject root = new JSONObject();
		
		root.put("pageType", "item" );
		root.put("genderType", "M" );
		root.put("shopType", "S" );
		root.put("offset", new JSONObject());		
		root.put("imageUrl", "https://drive.google.com/uc?export=view&id=");
		
		JSONArray contentData = new JSONArray();
		JSONObject imageData = new JSONObject();
		
		root.put("contentData", contentData);
		root.put("imageData", imageData);

		JSONObject newContentData = new JSONObject();
		
		newContentData.put("category", vo.getShoptype());
		newContentData.put("title", vo.getTitle());
		newContentData.put("price", vo.getPrice());
		newContentData.put("shop", vo.getShopname());
		newContentData.put("url", vo.getContenturl());
		newContentData.put("link", vo.getLink());
		newContentData.put("id", vo.getId());
		
		contentData.add(newContentData);
		
		response.setContentType("application/json; charset=utf-8");
		response.setCharacterEncoding("UTF-8");
				
		PrintWriter out = response.getWriter();
		out.println(root.toJSONString());
		
		return null;
	}

}
