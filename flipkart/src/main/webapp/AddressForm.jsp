<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Address</title>
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 90%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .form-container {
        margin-top: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 20px;
    }

    .form-container label {
        font-weight: bold;
    }

    .form-container input[type="text"],
    .form-container input[type="email"],
    .form-container input[type="tel"] {
        width: 100%;
        padding: 8px;
        margin: 8px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .form-container input[type="submit"] {
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
        border-radius: 5px;
    }

    .form-container input[type="submit"]:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>Add Address</h1>
        <div class="form-container">
            <form action="/flipkart/addAddress" method="post">
                <label for="customerName">Customer Name:</label><br>
                <input type="text" id="customerName" name="customerName" required><br>

                <label for="mobile">Mobile:</label><br>
                <input type="tel" id="mobile" name="mobile" required><br>

                <label for="email">Email:</label><br>
                <input type="email" id="email" name="email" required><br>

                <label for="location">Location:</label><br>
                <input type="text" id="location" name="location" required><br>

                <label for="address">Address:</label><br>
                <input type="text" id="address" name="address" required><br>

                <input type="submit" value="Add Address">
            </form>
        </div>
    </div>
</body>
</html>
