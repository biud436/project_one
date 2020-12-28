package service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import vo.ProductVO;

public class DetailInputService {

	public boolean inputDetail(HttpServletRequest req, String title, int price, int amount) {

		List<ProductVO> list = null;
		boolean success = false;
		ItemService itemService = new ItemService();
		
		String id = req.getParameter("id");
		
		list = itemService.getDAO().getDetail(title, price);
		
		req.setAttribute("list", list);
		req.setAttribute("id", id);
		
		System.out.println(list);
		
		success = itemService.getDAO().insertDetail(id, list);
		
		return success;
	}
	
}
