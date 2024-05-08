<%@ page language="java" import="com.amazon.models.Product,java.util.List,java.util.ArrayList" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login Form</title>
<style>
body {
	font-family: Arial, sans-serif;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

form {
	max-width: 400px;
	margin: 20px auto;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
	position: relative; /* Added position relative */
}

label, input, button, .register-link {
	display: block;
	margin-bottom: 10px;
}

input[type="text"], input[type="password"] {
	width: calc(100% - 20px);
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

button {
	padding: 10px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button:hover {
	background-color: #0056b3;
}

.error-message {
	color: red;
	margin-top: 10px;
}

.register-link {
	position: absolute;
	top: 200px; /* Adjust top position as needed */
	right: 20px; /* Adjust right position as needed */
	font-size: 14px;
}
</style>
</head>
<body>
	<h2>Login</h2>
	<form id="loginForm">
		<label for="loginUsername">UserId:</label>
		<input type="text" id="loginUsername" required><br>
		<label for="loginPassword">Password:</label>
		<input type="password" id="loginPassword" required><br>
		<button type="submit">Login</button>

		<div class="register-link">
			<a href="Register.jsp">Register</a>
		</div>
	</form>

	<div id="loginError" style="color: red;"></div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#loginForm').on('submit', function(event) {
				event.preventDefault();
				validateLogin();
			});

			function validateLogin() {
				var username = $('#loginUsername').val();
				var password = $('#loginPassword').val();
				var errorDiv = $('#loginError');
				errorDiv.html('');

				// Perform client-side validations
				if (!username || !password) {
					errorDiv.html('Username and password are required.');
					return false;
				}

				// Send AJAX request to validate credentials
				$.ajax({
					url: '/flipkart/validateLogin', 
					method: 'POST',
					data: { username: username, password: password },
					success: function(response) {
						if (response.valid) {
							window.location.href = response.url;
						} else {
							errorDiv.html('Invalid username or password.');
						}
					},
					error: function(xhr, status, error) {
						alert(error);
						errorDiv.html('Error occurred while processing the request.');
					}
				});
			}
		});
	</script>
</body>
</html>
