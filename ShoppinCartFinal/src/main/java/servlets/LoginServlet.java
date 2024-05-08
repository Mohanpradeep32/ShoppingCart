package servlets;

import java.io.IOException;

import Dao.MainDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MainDao m = new MainDao();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			if (m.logindetails(username, password)) {
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				response.sendRedirect("home.jsp");
			} else {
				System.out.println("User Not found");
				response.sendRedirect("login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("login.jsp");
		}
	}

}
