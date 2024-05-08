package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import models.Address;
import models.Products;
import models.User;

public class MainDao {
	static DbConnection con = new DbConnection();

	public boolean logindetails(String username, String password) throws Exception {
		Connection cn = con.getConnection();
		String str = "select * from i197_users where username=? and password=?";
		PreparedStatement ps = cn.prepareStatement(str);
		ps.setString(1, username);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			return true;
		} else {
			return false;
		}
	}

	public ResultSet getCategories() throws Exception {
		Connection cn = con.getConnection();
		String str = "Select * from i197_product_category";
		PreparedStatement ps = cn.prepareStatement(str);
		ResultSet rs = ps.executeQuery();
		return rs;
	}

	public ArrayList<Products> getProductsprice(String selcat, String price) throws Exception {
		ArrayList<Products> al = null;
		Connection cn = con.getConnection();
		String str = null;
		if (selcat.equals("All")) {
			str = "select * from i197_product ";
			if (!price.equals("All")) {
				str += "where true " + addstring(price);
			}
		} else {
			str = "select * from i197_product where productcategory_id in (\r\n"
					+ "	select i197_productcategory_id from i197_product_category where i197_productcategory_name=?) ";

		}
		PreparedStatement pp;
		if (!selcat.equals("All")) {
			if (!price.equals("All") && !price.equals("All")) {

				str += addstring(price);
			}
			pp = cn.prepareStatement(str);
			pp.setString(1, selcat);
		} else {
			pp = cn.prepareStatement(str);
		}
		ResultSet rs = pp.executeQuery();
		al = new ArrayList<>();
		while (rs.next()) {
			Products p = new Products();
			p.setProduct_id(rs.getInt("product_id"));
			p.setProduct_name(rs.getString("product_name"));
			p.setPrice(rs.getDouble("price"));
			p.setImgurl(rs.getString("imageurl"));
			al.add(p);
		}
		return al;
	}

	private String addstring(String price) {
		String str = "";
		int pr = Integer.parseInt(price);
		if (pr == 0) {
			str += "and price>=0 and price<=500";
		} else if (pr == 500) {
			str += "and price>=500 and price<=1000";
		} else if (pr == 1000) {
			str += "and price>=1000 and price<=10000";
		} else {
			str += "and price>=10000 and price<=100000";
		}

		return str;
	}

	public void addUser(User user) {
		try (Connection cn = con.getConnection();) {
			String query = "INSERT INTO i197_users (username, password) VALUES (?, ?)";
			PreparedStatement pstmt = cn.prepareStatement(query);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.executeUpdate();
			System.out.println("User added ");
		} catch (Exception e) {
			e.printStackTrace();
			// Handle database insertion error
			throw new RuntimeException("Failed to add user to the database", e);
		}
	}

	public boolean checkservice(int pin_code) throws Exception {
		Connection cn = con.getConnection();
		String str = "select * from i197_servicable where srrg_pinto=?";
		PreparedStatement ps = cn.prepareStatement(str);
		ps.setInt(1, pin_code);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			return true;
		} else {
			return false;
		}
	}

	public Map<String, Double> calculatingtotalprice(List<Products> cart, int pincode) throws Exception {
		double totalPrice = calTotal(cart);
		System.out.println(totalPrice);
		double gstcal = calgst(cart, pincode, totalPrice);
		Map<String, Double> result = new HashMap<>();
		result.put("totalPrice", totalPrice);
		result.put("gstCal", gstcal);
		result.put("totalpayable", totalPrice + gstcal);
		return result;
	}

	private static double calgst(List<Products> cart, int pincode, double totalPrice) throws Exception {
		Double shippingcharge = shipcharge(pincode);
		double totalgstwithship = 0;
		double pgst = 0;
		for (Products product : cart) {
			double price = product.getPrice();
			double gst = getGst(product.getProduct_id());
			double percentage = (price / totalPrice) * shippingcharge;
			double gstship = (gst / 100) * percentage;
			double total = percentage + gstship;
			totalgstwithship += total;
			pgst += gst;

		}
		return totalgstwithship;
	}

	private static Double shipcharge(int pincode) throws Exception {
		Connection cn = con.getConnection();
		double amount = 0;
		String str = "select orvl_shippingamount from i185_ordervalue where orvl_to=?";
		PreparedStatement ps = cn.prepareStatement(str);
		ps.setInt(1, pincode);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			amount = (double) rs.getDouble("orvl_shippingamount");
		}
		return amount;
	}

	private static double getGst(int product_id) throws Exception {
		Connection cn = con.getConnection();
		double gst = 0;
		String str = "select gst from i197_hsn_code as h join i197_product as p on h.hsncode=p.hsn_code where product_id=?";
		PreparedStatement ps = cn.prepareStatement(str);
		ps.setInt(1, product_id);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			gst = (double) rs.getDouble("gst");
		}
		return gst;
	}

	public static double calTotal(List<Products> cart) {
		double totalPrice = 0.0;

		for (Products product : cart) {
			totalPrice += product.getPrice() * product.getQuantity();
		}
		return totalPrice;

	}

	public ArrayList<Address> getAddress(String usr) throws Exception {
		ArrayList<Address> al = null;
		Connection cn = con.getConnection();
		String str = "select * from i185_Address_info where user_name=?";
		PreparedStatement ps = cn.prepareStatement(str);
		ps.setString(1, usr);
		ResultSet rs = ps.executeQuery();
		al = new ArrayList<>();
		while (rs.next()) {
			Address a = new Address();
			a.setCustomerName(rs.getString("customer_name"));
			a.setMobile(rs.getString("mobile"));
			a.setEmail(rs.getString("email"));
			a.setLocation(rs.getString("location"));
			a.setAddress(rs.getString("address"));
			al.add(a);
		}
		return al;
	}
}
