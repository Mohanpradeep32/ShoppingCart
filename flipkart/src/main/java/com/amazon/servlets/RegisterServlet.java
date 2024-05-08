package com.amazon.servlets;

import java.io.IOException;

import com.amazon.DAL.ProductsDAO;
import com.amazon.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/createUser")
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("register");
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		HttpSession httpSession = req.getSession();
		ProductsDAO productsDAO = (ProductsDAO) httpSession.getAttribute("productsDAO");
		if (productsDAO == null) {
			productsDAO = new ProductsDAO();
			httpSession.setAttribute("productsDAO", productsDAO);
		}
		String username = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		boolean result = productsDAO.createUser(new User(username, email, password));
		if (result) {
			resp.getWriter().write("{ \"success\": true}");
		} else {
			resp.getWriter().write("{ \"success\": false}");
		}

	}

}
