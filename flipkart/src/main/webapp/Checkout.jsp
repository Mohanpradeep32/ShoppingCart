<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.amazon.models.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f8f8;
	margin: 0;
	padding: 0;
}



nav {
	background-color: #333;
	color: white;
	padding: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

nav a {
	color: white;
	text-decoration: none;
}

.container {
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

h1, h2, h3 {
	color: #333;
	margin-bottom: 10px;
}

.order-details {
	margin-bottom: 20px;
}

.order-details p {
	margin: 5px 0;
}

.order-details hr {
	margin: 15px 0;
	border: 1px solid #ddd;
}

ul {
	list-style-type: none;
	padding: 0;
}

li {
	margin-bottom: 15px;
}

li p {
	margin: 5px 0;
}


.address-details h2 {
    font-size: 20px;
    margin-bottom: 10px;
    color: #333;
}

.address-details p {
    margin: 5px 0;
    color: #666;
}

.address-details strong {
    font-weight: bold;
    margin-right: 5px;
    color: #333;
}
.cart-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 20px;
		float:right;
}
.heading-and-link {
	width: 68%;
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}
</style>
</head>
<body>
	<% Order order = (Order)request.getAttribute("order");
	Address address = (Address)request.getAttribute("address");
	System.out.print(order);
 List<Product> products = (List<Product>)request.getAttribute("products");
Map<Integer, Product> productMap = new HashMap<>();
for (Product product : products) {
    productMap.put(product.getProductId(), product);
}
	
%>
	<nav>
		<a href="/flipkart/home"><img alt="logo" src="./assets/images/logo.png"
			width="120px" height="41px"></a>
		<div>

			<%
			if (session.getAttribute("LOGGEDIN") != null && session.getAttribute("LOGGEDIN").equals("yes")) {
			    String username = (String) session.getAttribute("USERNAME");
			%>
			<span>Welcome, <%= username %></span>
			<%
			} else {
				%>
			<a href="Login.jsp">Login</a>
			<%
				}
			%>
			
		</div>
	</nav>
		<div class="heading-and-link">
		<h1>Checkout Page</h1>
		<div class="cart-header">
				
				<a href="home">Continue Shopping</a>
			</div>
	</div>
	<div class="container">
		<div class="order-details">
			<h2>Order Created</h2>
			<p>
				<strong>Order ID:</strong>
				<%= order.getOrderId() %></p>
			<p>
				<strong>User Name:</strong>
				<%= order.getUserName() %></p>
			<p>
				<strong>Order Date:</strong>
				<%= order.getOrderDate() %></p>
			<p>
				<strong>Order Total:</strong> Rs.
				<%= order.getOrderTotal() %></p>
			<hr>
			<h3>Order Products</h3>
			<ul>
				<% for (OrderProduct orderProduct : order.getOrderProducts()) { %>
				<li>
					<p>
						<strong>Product Name:</strong>
						<%= productMap.get(orderProduct.getProductId()).getProductName() %></p>
					<p>
						<strong>Quantity:</strong>
						<%= orderProduct.getQuantity() %></p>
					<p>
						<strong>Price:</strong> Rs.
						<%= orderProduct.getPrice() %></p>
				</li>
				<% } %>
			</ul>
			<hr>
			<div class="address-details">
        <h2>Shipping Address</h2>
        <p><strong>Customer Name:</strong> <%= address.getCustomerName() %></p>
        <p><strong>Mobile:</strong> <%= address.getMobile() %></p>
        <p><strong>Email:</strong> <%= address.getEmail() %></p>
        <p><strong>Location:</strong> <%= address.getLocation() %></p>
        <p><strong>Address:</strong> <%= address.getAddress() %></p>
    </div>
		</div>
</body>
</html>
