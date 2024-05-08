-- Populate the User_Credentials table
INSERT INTO User_Credentials (email, name, password) VALUES
('ravikumar@example.com', 'Ravi Kumar', 'hashed_password1'),
('sunitasharma@example.com', 'Sunita Sharma', 'hashed_password2'),
('amitpatel@example.com', 'Amit Patel', 'hashed_password3'),
('priyasingh@example.com', 'Priya Singh', 'hashed_password4'),
('vijayjoshi@example.com', 'Vijay Joshi', 'hashed_password5');

-- Populate the Product_Category table
INSERT INTO Product_Category (ProductCategory_ID, ProductCategory_name) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Groceries'),
(4, 'Fashion'),
(5, 'Furniture');

-- Populate the HSN_Code table
INSERT INTO HSN_Code (hsncode, gst) VALUES
('HSN1', 18.50),
('HSN2', 12.44),
('HSN3', 5.05),
('HSN4', 28.90),
('HSN5', 21.56);

-- Populate the Address_info table with random data
INSERT INTO Address_info (customer_id, customer_name, mobile, email, location, address, dateofcreation) VALUES
(1, 'Ravi Kumar', '9876543210', 'ravikumar@example.com', 'Delhi', '123 Janpath', '2024-04-25'),
(2, 'Sunita Sharma', '8765432109', 'sunitasharma@example.com', 'Mumbai', '456 Marine Drive', '2024-04-26'),
(3, 'Amit Patel', '7654321098', 'amitpatel@example.com', 'Ahmedabad', '789 Ashram Road', '2024-04-27'),
(4, 'Priya Singh', '6543210987', 'priyasingh@example.com', 'Kolkata', '012 Park Street', '2024-04-28'),
(5, 'Vijay Joshi', '5432109876', 'vijayjoshi@example.com', 'Pune', '345 MG Road', '2024-04-29');

-- Populate the Product table
INSERT INTO Product (Product_ID, ProductCategory_ID, Product_Name, price, HSN_Code, imageurl) VALUES
(1, 1, 'Apple iPhone 13', 74999, 'HSN1', 'https://th.bing.com/th?id=OPAC.GcDf%2bje4LfI1IA474C474&w=592&h=550&o=5&pid=21.1'),
(2, 1, 'Samsung Galaxy S21', 59999, 'HSN1', 'https://cdn.ruf.si/wp-content/uploads/sites/832/2021/01/005.jpg'),
(3, 1, 'Sony WH-1000XM4', 24999, 'HSN1', 'https://www.bhphotovideo.com/images/images2500x2500/sony_wh1000xm4_b_wh_1000xm4_wireless_noise_canceling_over_ear_1582549.jpg'),
(4, 2, 'Becoming by Michelle Obama', 899, 'HSN2', 'https://www.webdelico.com/wp-content/uploads/2021/03/81E1q-oBd6L-1378x2048.jpg'),
(5, 2, 'Educated by Tara Westover', 1050, 'HSN2', 'https://tse4.mm.bing.net/th/id/OIP.8vsWnadqpWhLYwmX6siA9wHaLJ?rs=1&pid=ImgDetMain'),
(6, 2, 'The Silent Patient by Alex Michaelides', 560, 'HSN2', 'https://dglibrary.org/wp-content/uploads/2020/08/91BbLCJOruL.jpg'),
(7, 3, 'Organic Bananas', 44, 'HSN3', 'https://www.thelittlebigstore.com.au/wp-content/uploads/2016/06/1068c6fcfa683b9b804a671b3d3271f5ffbd8c65.jpg'),
(8, 3, 'Almond Milk', 225, 'HSN3', 'https://tse1.mm.bing.net/th/id/OIP.n_I0pII1f-nc7RZWUj6zlAHaHa?rs=1&pid=ImgDetMain'),
(9, 3, 'Brown Rice', 150, 'HSN3', 'https://tse4.mm.bing.net/th/id/OIP.pS9WEx1RGpivVdh9SvbxQgHaHa?rs=1&pid=ImgDetMain'),
(10, 3, 'Organic Eggs', 375, 'HSN3', 'https://tse2.mm.bing.net/th/id/OIP.AV3nDbx8mhbIU4bYslMmSwHaJ4?rs=1&pid=ImgDetMain'),
(11, 4, 'Levis Jeans', 3750, 'HSN4', 'https://tse2.mm.bing.net/th/id/OIP.7RHhE2g4qpVZIbssyxxLmwHaJQ?rs=1&pid=ImgDetMain'),
(12, 4, 'Nike Sneakers', 6750, 'HSN4', 'https://tse2.mm.bing.net/th/id/OIP.e7QPsuPwZLFxByLM1rXv6wHaE8?rs=1&pid=ImgDetMain'),
(13, 4, 'Adidas T-Shirt', 1875, 'HSN4', 'https://tse1.mm.bing.net/th/id/OIP.N70ZBDKx9u8mj0W_17KefgHaJT?rs=1&pid=ImgDetMain'),
(14, 5, 'IKEA Desk', 15000, 'HSN5', 'https://tse2.mm.bing.net/th/id/OIP.28sN78CV8_RgJpJS_aXPXQHaHa?rs=1&pid=ImgDetMain'),
(15, 5, 'Ashley Furniture Sofa', 37500, 'HSN5', 'https://wakefitdev.gumlet.io/img/sofa-sets/napper/regular/lifestyle/FMSG.jpg?w=1242'),
(16, 5, 'Tempur-Pedic Mattress', 97500, 'HSN5', 'https://wakefitdev.gumlet.io/img/mattress/dreampod/new/1.jpg?w=1242'),
(17, 1, 'Dell XPS 13', 89999, 'HSN1', 'https://images-na.ssl-images-amazon.com/images/I/91WgL3IbNIL.jpg'),
(18, 1, 'Canon EOS R5', 292499, 'HSN1', 'https://sm.pcmag.com/t/pcmag_uk/review/c/canon-eos-/canon-eos-r5_p5vj.1920.jpg'),
(19, 2, 'Where the Crawdads Sing by Delia Owens', 1199, 'HSN2', 'https://tse2.mm.bing.net/th/id/OIP.ZQl0oTiRhldbjANeVUoA7wHaLq?rs=1&pid=ImgDetMain'),
(20, 3, 'Organic Chicken Breast', 750, 'HSN3', 'https://tse2.mm.bing.net/th/id/OIP.BDMeeyTlOoqeHc-e7v_vbgHaHa?rs=1&pid=ImgDetMain');

select * from user_credentials;
select * from product;
select * from address_info;
select * from hsn_code;
select * from product_category;