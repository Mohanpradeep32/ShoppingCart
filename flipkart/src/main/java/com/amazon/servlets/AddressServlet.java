package com.amazon.servlets;

import java.io.IOException;

import com.amazon.DAL.ProductsDAO;
import com.amazon.models.Address;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addAddress")
public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String customerName = request.getParameter("customerName");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String location = request.getParameter("location");
		String address = request.getParameter("address");
		HttpSession httpSession = request.getSession();
		ProductsDAO productsDAO = (ProductsDAO) httpSession.getAttribute("productsDAO");
		if (productsDAO == null) {
			productsDAO = new ProductsDAO();
			httpSession.setAttribute("productsDAO", productsDAO);
		}
		String userName = (String) httpSession.getAttribute("USERNAME");
		productsDAO.insertAddress(new Address(0, userName, customerName, mobile, email, location, address));

		request.getRequestDispatcher("/checkout").forward(request, response);
	}
}
