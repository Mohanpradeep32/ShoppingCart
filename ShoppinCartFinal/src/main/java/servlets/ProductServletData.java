package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import com.google.gson.Gson;

import Dao.MainDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Products;

public class ProductServletData extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String selecteddata = request.getParameter("category");

		String price = request.getParameter("price");
		MainDao m = new MainDao();
		try {

			ArrayList<Products> al = m.getProductsprice(selecteddata, price);
			Gson gson = new Gson();
			String json = gson.toJson(al);
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.print(json);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
