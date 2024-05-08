package com.amazon.DAL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import com.amazon.models.Address;
import com.amazon.models.Order;
import com.amazon.models.OrderProduct;
import com.amazon.models.Product;
import com.amazon.models.ProductCategory;
import com.amazon.models.User;
import com.amazon.utility.HashGenerator;

public class ProductsDAO {
	private Connection connection;

	public ProductsDAO() {
		ResourceBundle resourceBundle = ResourceBundle.getBundle("db");
		String driver = resourceBundle.getString("driver");
		String url = resourceBundle.getString("url");
		String uname = resourceBundle.getString("userName");
		String pass = resourceBundle.getString("password");
		try {
			Class.forName(driver);
			connection = DriverManager.getConnection(url, uname, pass);
			System.out.println("Connected to PostgreSQL database!");
		} catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public List<Product> getProductsByCategory(int pageNo, int categoryId) {

		List<Product> products = new ArrayList<>();
		try {
			String query = "SELECT * FROM Product WHERE ProductCategory_ID = ? LIMIT ? OFFSET ? ";
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, categoryId);
			preparedStatement.setInt(2, 12);
			preparedStatement.setInt(3, (pageNo - 1) * 12);
			ResultSet rs = preparedStatement.executeQuery();
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

	public List<Product> getProducts(int pageNo) {

		List<Product> products = new ArrayList<>();
		try {
			String query = "SELECT * FROM Product LIMIT ? OFFSET ? ";
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, 12);
			preparedStatement.setInt(2, (pageNo - 1) * 12);
			ResultSet rs = preparedStatement.executeQuery();
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

	public List<Product> getProducts(List<Integer> pids) {
		List<Product> products = new ArrayList<>();
		if (pids.size() > 0) {
			try {
				String placeholders = String.join(", ", Collections.nCopies(pids.size(), "?"));

				String query = "SELECT * FROM Product WHERE Product_ID IN (" + placeholders + ")";

				PreparedStatement preparedStatement = connection.prepareStatement(query);

				for (int i = 0; i < pids.size(); i++) {
					preparedStatement.setInt(i + 1, pids.get(i));
				}

				ResultSet rs = preparedStatement.executeQuery();
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

		}
		return products;
	}

	public int getNoOfProducts() {
		try {

			String query = "SELECT count(*) FROM Product ";

			PreparedStatement preparedStatement = connection.prepareStatement(query);

			ResultSet rs = preparedStatement.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}

	public int getNoOfProductsByCategory(int categoryId) {
		try {

			String query = "SELECT count(*) FROM Product WHERE ProductCategory_ID = ?";

			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, categoryId);

			ResultSet rs = preparedStatement.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}

	public List<ProductCategory> getAllCategories() {
		List<ProductCategory> categories = new ArrayList<>();

		String query = "SELECT ProductCategory_ID, ProductCategory_name FROM Product_Category";
		try (PreparedStatement stmt = connection.prepareStatement(query)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int categoryId = rs.getInt("ProductCategory_ID");
				String categoryName = rs.getString("ProductCategory_name");
				ProductCategory category = new ProductCategory(categoryId, categoryName);
				categories.add(category);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return categories;
	}

	public boolean isValidUser(String uname, String password) {
		String givenHash = new HashGenerator().generateHash(password);
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		try {
			String query = "SELECT password_hash FROM User_Credentials WHERE user_name = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, uname);
			rs = preparedStatement.executeQuery();

			if (rs.next()) {
				String dbHash = rs.getString("password_hash");
				if (dbHash.equals(givenHash)) {
					return true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (preparedStatement != null) {
					preparedStatement.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return false;
	}

	public boolean createUser(User user) {

		try {
			String queryString = "insert into User_Credentials (user_name,email,password_hash) values(?,?,?)";
			PreparedStatement preparedStatement = connection.prepareStatement(queryString);
			preparedStatement.setString(1, user.getUserName());
			preparedStatement.setString(2, user.getEmail());
			preparedStatement.setString(3, new HashGenerator().generateHash(user.getPassword()));
			int rows = preparedStatement.executeUpdate();
			return rows == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	public boolean addressFilled(String username) {
		boolean addressExists = false;
		try {
			String sql = "SELECT COUNT(*) AS count FROM Address_info WHERE user_name = ?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, username);
			ResultSet resultSet = statement.executeQuery();
			if (resultSet.next()) {
				int count = resultSet.getInt("count");
				System.out.println(count + " " + username);
				addressExists = (count > 0);
			}
			System.out.println(addressExists);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return addressExists;
	}

	public boolean insertAddress(Address address) {
		String query = "INSERT INTO Address_info (user_name, customer_name, mobile, email, location, address) VALUES (?, ?, ?, ?, ?, ?)";

		try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			preparedStatement.setString(1, address.getUserName());
			preparedStatement.setString(2, address.getCustomerName());
			preparedStatement.setString(3, address.getMobile());
			preparedStatement.setString(4, address.getEmail());
			preparedStatement.setString(5, address.getLocation());
			preparedStatement.setString(6, address.getAddress());

			int rowsAffected = preparedStatement.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public Order createOrder(String userName, List<Product> products, Map<Integer, Integer> cartMap) {

		Order order = new Order();
		try {
			connection.setAutoCommit(false);
			String insertOrderSQL = "INSERT INTO Orders (user_name, order_date, order_total) VALUES (?, NOW(), ?)";
			PreparedStatement pstmtOrder = connection.prepareStatement(insertOrderSQL,
					PreparedStatement.RETURN_GENERATED_KEYS);
			double total = calculateOrderTotal(products, cartMap);
			pstmtOrder.setString(1, userName);
			pstmtOrder.setDouble(2, total);
			order.setUserName(userName);
			order.setOrderDate(LocalDate.now());
			order.setOrderTotal(total);
			pstmtOrder.executeUpdate();

			ResultSet rs = pstmtOrder.getGeneratedKeys();
			int orderId = -1;
			if (rs.next()) {
				orderId = rs.getInt(1); // Assuming order_ID is the first column in the generated keys result set
			}
			order.setOrderId(orderId);
			List<OrderProduct> orderProducts = new ArrayList<>();
			String insertOrderProductSQL = "INSERT INTO Order_Product (order_ID, product_id, quantity, price) VALUES (?, ?, ?, ?)";
			PreparedStatement pstmtOrderProduct = connection.prepareStatement(insertOrderProductSQL);
			for (Product product : products) {
				pstmtOrderProduct.setInt(1, orderId);
				pstmtOrderProduct.setInt(2, product.getProductId());
				pstmtOrderProduct.setInt(3, cartMap.get(product.getProductId()));
				pstmtOrderProduct.setDouble(4, product.getPrice());
				orderProducts.add(new OrderProduct(orderId, product.getProductId(), cartMap.get(product.getProductId()),
						cartMap.get(product.getProductId()) * product.getPrice()));
				pstmtOrderProduct.addBatch();
			}

			pstmtOrderProduct.executeBatch();
			order.setOrderProducts(orderProducts);
			connection.commit();
		} catch (Exception e) {
			order = null;
			try {
				connection.rollback();
			} catch (SQLException e1) {

				e1.printStackTrace();
			}
			e.printStackTrace();
		}

		return order;
	}

	public Address getAddressByUserId(String userName) {
		Address address = null;
		String query = "SELECT * FROM Address_info WHERE user_name = ?";

		try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			preparedStatement.setString(1, userName);
			ResultSet resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				address = new Address();

				address.setUserName(resultSet.getString("user_name"));
				address.setCustomerName(resultSet.getString("customer_name"));
				address.setMobile(resultSet.getString("mobile"));
				address.setEmail(resultSet.getString("email"));
				address.setLocation(resultSet.getString("location"));
				address.setAddress(resultSet.getString("address"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return address;
	}

	private double calculateOrderTotal(List<Product> products, Map<Integer, Integer> cartMap) {
		double total = 0;
		for (Product product : products)
			total += product.getPrice() * cartMap.get(product.getProductId());
		return total;
	}

}
