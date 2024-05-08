package com.amazon.servlets;

import java.io.IOException;

import com.amazon.DAL.ProductsDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/validateLogin")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		HttpSession httpSession = request.getSession();
		ProductsDAO productsDAO = (ProductsDAO) httpSession.getAttribute("productsDAO");
		if (productsDAO == null) {
			productsDAO = new ProductsDAO();
			httpSession.setAttribute("productsDAO", productsDAO);
		}
		boolean validCredentials = productsDAO.isValidUser(username, password);
		String previousUrl = (String) httpSession.getAttribute("previousUrl");
		if (previousUrl == null)
			previousUrl = "home";
		if (validCredentials) {
			request.getSession().setAttribute("LOGGEDIN", "yes");
			request.getSession().setAttribute("USERNAME", username);
			response.getWriter().write("{ \"valid\": true,\"url\":\"" + previousUrl + "\"}");
		} else {
			request.getSession().setAttribute("LOGGEDIN", "no");
			response.getWriter().write("{ \"valid\": false}");
		}

	}

}
