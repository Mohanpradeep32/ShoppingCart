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
import jakarta.servlet.http.HttpSession;
import models.Address;

public class AddressServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MainDao m = new MainDao();
		HttpSession session = request.getSession();
		String usr = (String) session.getAttribute("username");
		try {
			System.out.println(usr);
			ArrayList<Address> al = m.getAddress(usr);
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
