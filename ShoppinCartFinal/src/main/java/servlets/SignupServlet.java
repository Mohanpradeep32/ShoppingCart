package servlets;

import java.io.IOException;

import Dao.MainDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MainDao m = new MainDao();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieve signup form parameters
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// Create a new user object
		User newUser = new User();
		newUser.setUsername(username);
		newUser.setPassword(password);

		try {
			// Add the new user to the database
			m.addUser(newUser);

			// Redirect to login page after successful signup
			response.sendRedirect("login.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			// Handle signup error appropriately
			response.sendRedirect("signup.jsp?error=signup_error");
		}
	}
}
