<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Register Form</title>
<style>
body {
	font-family: Arial, sans-serif;
}

h2 {
	text-align: center; /* Center the text horizontally */
	margin-bottom: 20px; /* Add some space below the heading */
}

form {
	max-width: 400px;
	margin: 20px auto;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
}

label, input, button {
	display: block;
	margin-bottom: 10px;
}

input[type="text"], input[type="email"], input[type="password"] {
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
	position: relative;
	top: 400px; 
	right: -120px; 
	font-size: 14px;
}
</style>
</head>
<body>
	<h2>Register</h2>
	<form id="registerForm">
		<label for="username">Username:</label> <input type="text"
			id="username" required><br> <label for="email">Email:</label>
		<input type="email" id="email" required><br> <label
			for="password">Password:</label> <input type="password" id="password"
			required><br> <label for="confirmPassword">Confirm
			Password:</label> <input type="password" id="confirmPassword" required><br>
		
		<button type="submit">Register</button>
		<div class="login-link">
			<a href="Login.jsp">Back to Login Page</a>
		</div>
	</form>

	<div id="registerError" style="color: red;"></div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
    $(document).ready(function() {
        $('#registerForm').on('submit', function(event) {
            event.preventDefault();
            registerUser();
        	console.log("hello");

        });

        function registerUser() {
            var username = $('#username').val();
            var email = $('#email').val();
            var password = $('#password').val();
            var confirmPassword = $('#confirmPassword').val();
            var errorDiv = $('#registerError');
            errorDiv.html('');

            // Perform client-side validations
            if (!username || !email || !password || !confirmPassword) {
                errorDiv.html('All fields are required.');
                return false;
            }

            if (password !== confirmPassword) {
                errorDiv.html('Passwords do not match.');
                return false;
            }

            $.ajax({
                url: '/flipkart/createUser', 
                method: 'POST',
                data: { username: username, email: email, password: password },
                success: function(response) {
                    if (response.success) {
                        window.location.href = '/flipkart/Login.jsp';
                    } else {
                        errorDiv.html('Registration failed. Please try again.');
                    }
                },
                error: function(xhr, status, error) {
                    errorDiv.html('Error occurred while processing the request.');
                }
            })
        }
    });
</script>

</body>
</html>
