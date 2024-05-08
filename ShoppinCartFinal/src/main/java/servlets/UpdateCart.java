package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Products;

public class UpdateCart extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int p_id = Integer.parseInt(request.getParameter("p_id"));
		int quantity = Integer.parseInt(request.getParameter("p_mode"));
		HttpSession session = request.getSession();
		List<Products> cart = (List<Products>) session.getAttribute("cart");

		for (Products product : cart) {
			if (product.getProduct_id() == p_id) {
				if (quantity == 0) {
					cart.remove(product);
				} else {
					product.setQuantity(quantity);

				}
				break;
			}

		}

		session.setAttribute("cart", cart);
		Gson gson = new Gson();
		String data = gson.toJson(cart);
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.print(data);
	}

}
