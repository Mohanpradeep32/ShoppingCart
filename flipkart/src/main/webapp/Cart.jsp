<%@ page language="java"
	import="com.amazon.models.*,java.util.*,java.util.ArrayList"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping Cart</title>
<style type="text/css">
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}
#empty-cart-message {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #f8f9fa;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    display: none;
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.cart-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 20px;
}

.cart-items {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.cart-item {
	display: flex;
	align-items: center;
	width: 100%;
	border: 1px solid #ddd;
	padding: 10px;
	border-radius: 5px;
}

.cart-item img {
	max-width: 100px;
	margin-right: 20px;
}

.cart-item-details {
	flex-grow: 1;
}

.cart-item-actions {
	display: flex;
	align-items: center;
}

.quantity-control {
	display: flex;
	align-items: center;
	gap: 5px;
}

.quantity-input {
	width: 40px;
	text-align: center;
}

.remove-btn {
	background-color: #FF6347;
	color: white;
	border: none;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
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
#checkoutBtn {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin-top: 10px;
    cursor: pointer;
	float:right;
}


</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<nav>
		<a href="#"><img alt="logo" src="./assets/images/logo.png"
			width="120px" height="41px"></a>
		<div>
			
			<%
			if (session.getAttribute("LOGGEDIN") != null && session.getAttribute("LOGGEDIN").equals("yes")) {
			    String username = (String) session.getAttribute("USERNAME");
			%>
			<span>User, <%= username %></span>
			<%
			} else {
				%>
			<a href="Login.jsp">Login</a>
			<%
				}
			%>
			 
		</div>
	</nav>
	<div class="container">
		<div class="cart-header">
			<h1>Shopping Cart</h1>
			<a href="home">Continue Shopping</a>
		</div>
		<div id="empty-cart-message"">
        			<img src="https://babasbestchicken.com/public/images/empty-cart.png" alt="Empty Cart Image">
        				
    			</div>
		<div class="cart-items">
			<%
			Map<Integer, Integer> cartMap = (Map<Integer, Integer>) request.getAttribute("cartMap");
			List<Product> products = (List<Product>) request.getAttribute("products");
			
			if (cartMap != null && products != null) {
				for (Product product : products) {
					int productId = product.getProductId();
					int quantity = cartMap.getOrDefault(productId, 0);
			
			%>
			<div class="cart-item" id="data-product-id-<%= productId %>">
				<img src="<%= product.getImageUrl() %>"
					alt="<%= product.getProductName() %>">
				<div class="cart-item-details">
					<h3><%= product.getProductName() %></h3>
					<p>
						Price: Rs.
						<%= product.getPrice() %></p>
				</div>
				<div class="cart-item-actions">
					<div class="quantity-control">
						<button class="quantity-btn minus"
							onclick="decrementQuantity(<%= productId %>)">-</button>
						<input type="number" class="quantity-input"
							id="quantity-<%= productId %>" value="<%= quantity %>" readonly>
						<button class="quantity-btn plus"
							onclick="incrementQuantity(<%= productId %>)">+</button>
					</div>
					<button class="remove-btn"
						onclick="removeFromCart(<%= productId %>)">Remove</button>
				</div>
			</div>
			<%
				}
			} 
			%>
		</div>
	<button id="checkoutBtn" onclick="checkout()">Checkout</button>
	</div>
	<script>
	$(document).ready(function() {
		checkCartEmpty();
	});
		function incrementQuantity(productId) {
			$.ajax({
		        url: '/flipkart/addProduct?pid=' + productId,
		        type: 'GET',
		        success: function (response) {
		            // Optionally handle success response
		        },
		        error: function (xhr, status, error) {
		            console.error('Error deleting product:', status, error);
		        }
		    });
			var quantityInput = $('#quantity-' + productId);
			var quantity = parseInt(quantityInput.val());
			quantityInput.val(quantity + 1);
			checkCartEmpty();

		}

		function decrementQuantity(productId) {

			$.ajax({
		        url: 'flipkart/removeProduct?pid=' + productId,
		        type: 'GET',
		        success: function (response) {
		            // Optionally handle success response
		        },
		        error: function (xhr, status, error) {
		            console.error('Error deleting product:', status, error);
		        }
		    });
			var quantityInput = $('#quantity-' + productId);
			var quantity = parseInt(quantityInput.val());
			if (quantity > 1) {
				quantityInput.val(quantity - 1);
			} else {
				$('#data-product-id-' + productId).remove();
			}
			checkCartEmpty();

		}

		function removeFromCart(productId) {

		    // Remove the item visually from the cart
		    $('#quantity-' + productId).val(0);
		    $('#data-product-id-' + productId).remove();

		    // Make an AJAX call to delete the product from the backend
		    $.ajax({
		        url: '/flipkart/deleteProduct?pid=' + productId,
		        type: 'GET',
		        success: function (response) {
		            // Optionally handle success response
		        },
		        error: function (xhr, status, error) {
		            console.error('Error deleting product:', status, error);
		        }
		    });
	        checkCartEmpty();
		}


		 
		function checkCartEmpty() {
	        var cartItems = $('.cart-items');
	        var emptyCartMessage = $('#empty-cart-message');
			var checkOutButton = $('#checkoutBtn');
			//alert(cartItems.children().length);
	        if (cartItems.children().length === 0) {
	            // Cart is empty, show the empty cart message
	            emptyCartMessage.show();
	            checkOutButton.hide();
	        } else {
	            // Cart has items, hide the empty cart message
	            emptyCartMessage.hide();
	            checkOutButton.show();
	        }
	    }
		function checkout() {
		    window.location.href = 'checkout'; 
		}


	   
	</script>
</body>
</html>
