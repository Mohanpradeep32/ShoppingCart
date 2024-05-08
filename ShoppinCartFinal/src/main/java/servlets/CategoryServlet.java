package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import org.json.JSONArray;

import Dao.MainDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CategoryServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MainDao m = new MainDao();
		try {
			ResultSet rs = m.getCategories();
			PrintWriter out = response.getWriter();
			JSONArray j = new JSONArray();
			while (rs.next()) {
				j.put(rs.getString("i197_productcategory_name"));
			}
			out.print(j);
		} catch (Exception e) {

			e.printStackTrace();
		}

	}
}
