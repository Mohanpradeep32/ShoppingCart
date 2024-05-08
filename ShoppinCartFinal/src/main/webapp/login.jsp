<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="login.css">
<style>
  body {
    background-color: #f8f9fa; /* Light gray background */
  }
  .container {
    margin-top: 100px; /* Adjust top margin for spacing */
  }
  .card {
    border: none; /* Remove border from card */
    border-radius: 15px; /* Add border-radius for rounded corners */
    box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.1); /* Add subtle shadow */
  }
  .card-header {
    background-color: #007bff; /* Blue header background */
    color: #fff; /* White header text */
    border-radius: 15px 15px 0 0; /* Rounded corners for top */
  }
  .card-body {
    padding: 30px; /* Add padding for content */
  }
  .btn-primary {
    background-color: #007bff; /* Blue button background */
    border-color: #007bff; /* Blue button border */
    border-radius: 5px; /* Add border-radius for rounded corners */
  }
  .btn-primary:hover {
    background-color: #0056b3; /* Darker blue on hover */
    border-color: #0056b3; /* Darker blue border on hover */
  }
</style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card">
        <div class="card-header text-center">
          <h2>Welcome to Shopping Cart</h2>
        </div>
        <div class="card-body">
          <form action="LoginServlet" method="post">
            <div class="form-group">
              <label for="username">Enter the username:</label>
              <input type="text" name="username" id="username" class="form-control">
            </div>
            <div class="form-group">
              <label for="password">Enter the password:</label>
              <input type="password" name="password" id="password" class="form-control">
            </div>
            <button type="submit" class="btn btn-primary btn-block">Submit</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
