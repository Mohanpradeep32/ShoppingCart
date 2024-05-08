<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shipping Details</title>
<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
     .cart-button{
      background-color: #007bff;
      color: #ffffff;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }
    
 .cartdiv{
     padding-top:30px;
    text-align:center;
 }   

</style>
</head>
<body>
   <center><h1>Billing Details</h1></center>
   <div class="container mt-4">
       <div id="useraddress" class="card">
           <div class="card-body">
               <!-- Address details will be displayed here -->
           </div>
       </div>
       <hr>
       <div id="shippingdetails" class="card">
           <div class="card-body">
               <!-- Shipping details will be displayed here -->
           </div>
       </div>
   </div>
   

    
</div>
   
    <div class="cartdiv">
       <button class="cart-button" id="payment" >Proceed to payment</button>
   </div>
   <!-- Bootstrap JS -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   <script src="https://checkout.razorpay.com/v1/checkout.js"></script> 
   <script>
      var totalmoney=0;
      $(document).ready(function(){
    	  

    	  var pincode = <%= (String)session.getAttribute("pincode") %>

    	        // Send pincode to servlet via AJAX
    	        $.ajax({
    	            url: 'OrderServlet',
    	            type: 'POST',
    	            data: { pin_code: pincode },
    	            success: function(orderData) {
    	                console.log("Order data:", orderData);
    	                shippingdetails(orderData);
    	            },
    	            error: function(xhr, status, error) {
    	                console.error("Error fetching order details:", error);
    	            }
    	        });

          $.ajax({
              url: 'AddressServlet',
              type: 'POST',
              dataType: "json",
              success: function(addressData){
                  console.log("Address data:", addressData);
                  console.log(addressData[0].customerName);// Log the address data
                  displayAddress(addressData);
              },
              error: function(xhr, status, error){
                  console.error("Error fetching address details:", error);
              }
          });

          function displayAddress(data){
              var addressHTML = "<h5 class='card-title'>Address Details</h5>";
              addressHTML += "<p class='card-text'><strong>Customer Name:</strong> " + data[0].customerName + "</p>";
              addressHTML += "<p class='card-text'><strong>Email:</strong> " + data[0].email + "</p>";
              addressHTML += "<p class='card-text'><strong>Mobile:</strong> " + data[0].mobile + "</p>";
              addressHTML += "<p class='card-text'><strong>Location:</strong> " + data[0].location + "</p>";
              addressHTML += "<p class='card-text'><strong>Address:</strong> " + data[0].address + "</p>";
              addressHTML += "<p class='card-text'><strong>City:</strong> " +  data[0].location  + "</p>"; // Corrected key
              // Add more fields as needed

              $('#useraddress .card-body').html(addressHTML);
          }

          function shippingdetails(data){
              var shippingHTML = "<h5 class='card-title'>Shipping Details</h5>";
              shippingHTML += "<p class='card-text'><strong>GST:</strong> " + data.gstCal + "</p>";
              shippingHTML += "<p class='card-text'><strong>Total Price:</strong> " + data.totalPrice + "</p>";
              shippingHTML += "<p class='card-text'><strong>Total Payable:</strong> " + data.totalpayable + "</p>";
              totalmoney=parseInt(data.totalpayable);
              totalmoney=totalmoney*100;
            
              

              $('#shippingdetails .card-body').html(shippingHTML);
          } 
           
      });
      console.log(totalmoney+"hi h");
     
      
      
  
  
      document.getElementById('payment').onclick = function (e) {
    	  var options = {
    		        "key": "rzp_test_7rXSeVuvAE3mr1", // Enter the Key ID generated from the Dashboard
    		        "amount": totalmoney,
    		        "currency": "INR",
    		        "description": "Acme Corp",
    		        "image": "https://s3.amazonaws.com/rzp-mobile/images/rzp.jpg",
    		        "prefill":
    		        {
    		          "email": "mohanmachavarapu117@gmail.com",
    		          "contact": +918008191153,
    		        },
    		        config: {
    		          display: {
    		            blocks: {
    		              utib: { //name for Axis block
    		                name: "Pay using Bank of Baroda",
    		                instruments: [
    		                  {
    		                    method: "card",
    		                    issuers: ["UTIB"]
    		                  },
    		                  {
    		                    method: "netbanking",
    		                    banks: ["UTIB"]
    		                  },
    		                ]
    		              },
    		              other: { //  name for other block
    		                name: "Other Payment modes",
    		                instruments: [
    		                  {
    		                    method: "card",
    		                    issuers: ["ICIC"]
    		                  },
    		                  {
    		                    method: 'netbanking',
    		                  }
    		                ]
    		              }
    		            },
    		            hide: [
    		              {
    		              method: "upi"
    		              }
    		            ],
    		            sequence: ["block.utib", "block.other"],
    		            preferences: {
    		              show_default_blocks: false // Should Checkout show its default blocks?
    		            }
    		          }
    		        },
    		        "handler": function (response) {
    		          alert(response.razorpay_payment_id);
    		        },
    		        "modal": {
    		          "ondismiss": function () {
    		            if (confirm("Are you sure, you want to close the form?")) {
    		              txt = "You pressed OK!";
    		              console.log("Checkout form closed by the user");
    		            } else {
    		              txt = "You pressed Cancel!";	
    		              console.log("Complete the Payment")
    		            }
    		          }
    		        }
    		      };
    	  
    	   var rzp1 = new Razorpay(options);
    	
        rzp1.open();
        e.preventDefault();
      }
   </script>
</body>
</html>