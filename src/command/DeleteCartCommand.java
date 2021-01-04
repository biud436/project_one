package command;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import action.ActionResult;
import vo.OrderVO;

public class DeleteCartCommand extends Command {

	@Override
	public ActionResult execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		result.start(request, response);
		
		HttpSession session = request.getSession();
		
		// String to int 변환
		String[] ids = request.getParameterValues("idList");
		
		List<Integer> list = Arrays.asList(ids)
					.stream()
					.mapToInt(Integer::parseInt)
					.boxed()
					.collect(Collectors.toList());
		
		System.out.println(list);
		
		List<OrderVO> cartList = (List<OrderVO>)session.getAttribute("cartList");
		
		if(cartList != null && !cartList.isEmpty()) {
			
			Iterator<OrderVO> iter = cartList.iterator();
			
			while(iter.hasNext()) {
				OrderVO cart = iter.next();
				
				int index = cartList.indexOf(cart);
				
				if(list.contains(index)) {
					iter.remove();
					System.out.println("장바구니에서 " + cart + "를 제거했습니다.");
				}
			}

		}
		
		session.setAttribute("cartList", cartList);
		
		JSONObject status = new JSONObject();
		status.put("status", "success");
		
		response.setContentType("application/json; charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		out.println(status.toJSONString());		
		return null;
	}
	
}
