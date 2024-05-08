package com.amazon.servlets;

import java.io.IOException;
import java.util.List;

import com.amazon.DAL.ProductsDAO;
import com.amazon.models.ProductCategory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession httpSession = request.getSession();
    	httpSession.setAttribute("previousUrl", request.getRequestURI());
		ProductsDAO productsDAO = (ProductsDAO) httpSession.getAttribute("productsDAO");
		if (productsDAO == null) {
			productsDAO = new ProductsDAO();
			httpSession.setAttribute("productsDAO", productsDAO);
		}
		List<ProductCategory> allCategories = productsDAO.getAllCategories();
		request.setAttribute("allCategories", allCategories);
        request.getRequestDispatcher("Home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

