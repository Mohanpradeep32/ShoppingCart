package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Products;

public class CartAdding extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		List<Products> cart = (List<Products>) session.getAttribute("cart");
		if (cart == null) {
			cart = new ArrayList<>();
			session.setAttribute("cart", cart);
		}
		Products p = new Products();
		p.setProduct_id(Integer.parseInt(request.getParameter("prod[product_id]")));
		p.setImgurl(request.getParameter("prod[imgurl]"));
		p.setProduct_name(request.getParameter("prod[product_name]"));
		p.setPrice(Double.parseDouble(request.getParameter("prod[price]")));
		p.setQuantity(1);
		cart.add(p);

		response.setContentType("text/plain");
		response.getWriter().write("Product added to cart successfully");

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		List<Products> cart = (List<Products>) session.getAttribute("cart");

		Gson gson = new Gson();
		String data = gson.toJson(cart);
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.print(data);
	}

}
