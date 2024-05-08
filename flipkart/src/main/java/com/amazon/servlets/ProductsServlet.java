package com.amazon.servlets;

import java.io.IOException;
import java.util.List;

import com.amazon.DAL.ProductsDAO;
import com.amazon.models.Product;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/getProducts/*")
public class ProductsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		String url = request.getPathInfo();
		int pageNo = Integer.parseInt(url.split("/")[1]);
		int categoryId;
		try {
			categoryId = Integer.parseInt(request.getParameter("categoryId"));
		} catch (Exception e) {
			categoryId = 0;
		}
		HttpSession httpSession = request.getSession();
		ProductsDAO productsDAO = (ProductsDAO) httpSession.getAttribute("productsDAO");
		if (productsDAO == null) {
			productsDAO = new ProductsDAO();
			httpSession.setAttribute("productsDAO", productsDAO);
		}
		List<Product> products;
		if (categoryId != 0) {
			products = productsDAO.getProductsByCategory(pageNo, categoryId);

		} else {
			products = productsDAO.getProducts(pageNo);
		}
		String json = new Gson().toJson(products);
		response.getWriter().write(json);
		
	}

}
