<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <link rel="stylesheet" type="text/css" href="home.css">
   <style>
   #itemlist{
  
      padding:30px;
   }
     .product{
        border: 1px solid #ccc;
        margin-bottom: 10px;
        margin-left:40px;
        margin-right: 40px;
        padding:10px;
        display:flex;
        flex-direction:row;
       justify-content: space-between;
        
     }
     .imagediv{
        height:200px;
        width:550px;
        display:flex;
        flex-direction:row;
     }
     .imagediv img{
         height:100%;
         width:200px;
         padding-right:10px;
     }
     .product p{
         font-size:20px;        
        }
     .qpdiv{
     
     display:flex;
    
     }
     .pdiv{ 
     
      padding-top:70px;
     }
    .quantity {
    
    display: flex;
    align-items: center;
    }
    .quantity input{
      width:20px;
    }
    .quantity button {
       margin: 0 5px;
       padding: 10px;
       border-radius:100px;
       border:none;
       background-color:#007bff;
       font-size: 16px;
       cursor: pointer;
       
    }
   </style>
</head>

<body>
   <div class="cartdiv">
      <h1>Shooping Cart</h1>
   </div>
   <div id="itemlist" ></div>
   <div class="cartdiv">
       <button class="cart-button" id="checkout" >Checkout</button>
   </div>
   <script>
   $(document).ready(function() {
	   $.ajax({
 		  url:"CartAdding",
 		  type:"GET",
 		  dataType:"json",
 		  success:function(data){
 			  console.log(data);
 			  addingdatalist(data);
 		  },
 		  error: function(xhr, status, error) {
               console.error("Error fetching data:", error);
               alert("Error fetching data. Please try again.");
           }
 	  });
	   
	   function itemcomponent(product){
		 
		   var productDiv=$('<div>').addClass('product');
		   
		   //adding image
		   var imagediv=$('<div>').addClass('imagediv');
		   var image=$('<img>').attr('src', product.imgurl);
		   imagediv.append(image);
		   
		   var title=$('<p>').text('Product name: ' + product.product_name);
		   imagediv.append(title);
		   
		   var qpdiv=$('<div>').addClass('qpdiv');
		   var pdiv=$('<div>').addClass('pdiv');
		   var price=$('<p>').addClass('price').text(product.price);
		   pdiv.append(price);
		   qpdiv.append(pdiv);
		   
		   var quantityDiv = $('<div>').addClass('quantity');
		   var minusButton = $('<button>').text('-');
		   var quantityInput = $('<input>').attr('type', 'text').val(product.quantity);
		   var plusButton = $('<button>').text('+');
		   quantityDiv.append(minusButton, quantityInput, plusButton);
		   qpdiv.append(quantityDiv);
		  
		   
		   minusButton.click(function(){
			   var currentval=parseInt(quantityInput.val());
			   quantityInput.val(currentval-1);
			   updatingsession(product.product_id,currentval-1);
			   if(parseInt(quantityInput.val())==0){
				   updatingsession(product.product_id,0);
				   productDiv.remove();
				   
			   }
		   })
		   plusButton.click(function(){
			   var currentval=parseInt(quantityInput.val());
			   quantityInput.val(currentval+1);
			   updatingsession(product.product_id,currentval+1);
		   }) 
		   productDiv.append(imagediv);
		   productDiv.append(qpdiv);
		   return productDiv
		   
		   
	   }
	   
	   function addingdatalist(data){
		   var listdiv=$("#itemlist");
		   listdiv.empty();
		   
		   data.forEach(function(product){
			   var productcomponent=itemcomponent(product);
			   listdiv.append(productcomponent);
		   })
	   }
	   
	   function updatingsession(pid,pmode){
		   $.ajax({
			   url:'UpdateCart',
			   type:'POST',
			   data:{'p_id':pid,'p_mode':pmode},
			   success:function(data){
				   console.log(data);
			   },
			   error:function(xhr,status,error){
				   console.log("error");
			   }
		   });
	   }
	   $("#checkout").click(function(){
		   window.location.href="checkout.jsp";
	   })
      })
   
   </script>
</body>
</html>