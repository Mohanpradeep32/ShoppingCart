<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="home.css">
    <style>
        body {
            padding: 20px;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa; /* Set a suitable background color */
        }
        .headerdiv {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .hdivoptions {
            display: flex;
            gap: 10px;
        }
        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .product {
            border: 1px  #ccc;
            margin-bottom: 20px;
            padding: 10px;
            width: 300px; /* Adjust based on desired spacing */
            box-sizing: border-box;
            text-align: center;
            background-color: #ffffff;
        }
        .product-image {
            width: 100%;
            height: 200px;
            overflow: hidden;
        }
        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: contain; /* Ensure images are fully visible within the container */
        }
        .product-info {
            margin-top: 10px;
            font-size: 14px;
        }
        .add-to-cart {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .register-button {
            background-color: #28a745;
            color: #ffffff;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-right: 10px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="headerdiv">
        <div>
            <button class="register-button" onclick="location.href='signup.jsp'">Register</button>
            <p>Shopping Cart</p>
        </div>
        <div class="hdivoptions">
            <select id="CategoryList">
                <option value="All" selected>All Categories</option>
            </select>
            <select id="pricelist">
                <option value="All" selected>Price</option>
                <option value="0">Below 500</option>
                <option value="500">500-1000</option>
                <option value="1000">1000-10000</option>
                <option value="10000">Above 10000</option>
            </select>
            <button class="login-button" id="OpenLogin">Login</button>
            <button class="cart-button" id="OpenCart"><i class="fas fa-shopping-cart"></i></button>
        </div>
    </div>
    <h1>Welcome to my Shopping Cart</h1>
    <div class="product-container" id="productcard"></div>
  
    <script>
        $(document).ready(function() {
            $.ajax({
                url: "CategoryServlet",
                type: "GET",
                dataType: "json",
                success: function(data) {
                    var catlist = $("#CategoryList");
                    $.each(data, function(index, category) {
                        catlist.append($("<option>").text(category));
                    });
                    populatingProducts("All", "All");
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching data:", error);
                    alert("Error fetching data. Please try again.");
                }
            });
          
            $("#CategoryList, #pricelist").change(function() {
                var selectedCategory = $("#CategoryList").val();
                var selectedPrice = $("#pricelist").val();
                populatingProducts(selectedCategory, selectedPrice);
            });
          
            function populatingProducts(selectedCategory, selectedPrice) {
                $.ajax({
                    url: "ProductServletData",
                    type: "POST",
                    data: { category: selectedCategory, price: selectedPrice },
                    success: function(data) {
                        displayingProducts(data);
                    },
                    error: function(xhr, status, error) {
                        console.error(status, error);
                    }
                });
            }
          
            function createProductCard(product) {
                var productDiv = $('<div>').addClass('product');
                var imageDiv = $('<div>').addClass('product-image');
                var image = $('<img>').attr('src', product.imgurl);
                var productName = $('<p>').text('Product Name: ' + product.product_name);
                var productPrice = $('<p>').text('Price: $' + product.price);
                var addToCartBtn = $('<button>').addClass('add-to-cart').text('Add to Cart');

                addToCartBtn.click(function() {
                    var pincode = window.prompt("Please enter your pincode:", "");
                    
                    transportProduct(product, pincode);
                    $.ajax({
                        url: "picodeServlet",
                        type: "POST",
                        data: { pincode :pincode },
                        success: function(data) {
                           
                        },
                        error: function(xhr, status, error) {
                            console.error(status, error);
                        }
                    });
                });

                imageDiv.append(image);
                productDiv.append(imageDiv, productName, productPrice, addToCartBtn);
                return productDiv;
            }
          
            function displayingProducts(data) {
                var productContainer = $('#productcard');
                productContainer.empty();

                data.forEach(function(product) {
                    var productCard = createProductCard(product);
                    productContainer.append(productCard);
                });
            }
          
            function transportProduct(product, pincode) {
                console.log(pincode);
                $.ajax({
                    url: 'ServiceAvailable',
                    type: 'POST',
                    data: { pin_code: pincode },
                    success: function(data) {
                        if (data === "true") {
                            alert("Product is available for transport.");
                            addToCart(product);
                        } else {
                            alert("Product is not available for transport.");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error(status, error);
                    }
                });
            }
          
            function addToCart(product) {
                $.ajax({
                    url: 'CartAdding',
                    type: 'POST',
                    data: { prod: product },
                    success: function(data) {
                       // alert(data);
                    },
                    error: function(xhr, status, error) {
                        console.error(status, error);
                    }
                });
            }
          
            $("#OpenCart").click(function() {
                window.location.href = 'Cart.jsp';
            });
          
            $("#OpenLogin").click(function() {
                window.location.href = 'login.jsp';
            });
        });
    </script>
</body>
</html>
