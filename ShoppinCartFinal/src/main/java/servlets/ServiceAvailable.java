package servlets;

import java.io.IOException;

import Dao.MainDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ServiceAvailable extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MainDao m = new MainDao();
		int pin_code = Integer.parseInt(request.getParameter("pin_code"));
		try {
			response.setContentType("text/plain");
			if (m.checkservice(pin_code)) {

				response.getWriter().write("true");
			} else {
				response.getWriter().write("false");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
