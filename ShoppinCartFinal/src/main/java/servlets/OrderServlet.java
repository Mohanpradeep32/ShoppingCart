package servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import Dao.MainDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Products;

public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		List<Products> cart = (List<Products>) session.getAttribute("cart");
		String usr = (String) session.getAttribute("username");

		int pincode = Integer.parseInt(request.getParameter("pin_code"));
		System.out.println("pincode is" + pincode);
		MainDao n = new MainDao();
		try {
			Map<String, Double> hm = n.calculatingtotalprice(cart, pincode);
			// Convert hm to JSON
			Gson gson = new Gson();
			String json = gson.toJson(hm);

			// Set response content type
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");

			// Write JSON string to response
			response.getWriter().write(json);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
