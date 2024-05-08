package com.amazon.DAL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.amazon.models.Product;

public class DAO {
	private Connection con;
	private static DAO instance;

	public DAO() {
		try {
			Class.forName("org.postgresql.Driver");
			// con = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training",
			// "plf_training_admin", "pff123");
			con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/hemanth", "postgres", "Niha@8251");
			System.out.println("Connected to PostgreSQL database!");
		} catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static DAO getInstance() {
		if (instance == null) {
			instance = new DAO();
		}
		return instance;
	}

	public List<Product> getProductList() {
		List<Product> products = new ArrayList<>();
		try {
			String sql = "SELECT * FROM Product";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int productId = rs.getInt("Product_ID");
				int productCategoryId = rs.getInt("ProductCategory_ID");
				String productName = rs.getString("Product_Name");
				double price = rs.getDouble("price");
				String hsnCode = rs.getString("HSN_Code");
				String imageUrl = rs.getString("imageurl");
				Product product = new Product(productId, productCategoryId, productName, price, hsnCode, imageUrl);
				products.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return products;
	}
}