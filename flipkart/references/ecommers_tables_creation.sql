CREATE TABLE HSN_Code (
    hsncode VARCHAR(255) PRIMARY KEY,
    gst DECIMAL
);

CREATE TABLE Orders (
    order_ID SERIAL PRIMARY KEY,
    user_name VARCHAR(255),
    order_date DATE,
    order_total DECIMAL
);

CREATE TABLE Order_Product (
    order_ID INT REFERENCES Orders(order_ID),
    product_id INT REFERENCES Product(Product_ID),
    quantity INT,
    price DECIMAL
);

CREATE TABLE Product_Category (
    ProductCategory_ID INT PRIMARY KEY,
    ProductCategory_name VARCHAR(255)
);


CREATE TABLE User_Credentials (
    user_name VARCHAR(255) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash CHAR(64) NOT NULL
);

CREATE TABLE Address_info (
    user_name VARCHAR(255) PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    mobile VARCHAR(15) NOT NULL,
    email VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    address VARCHAR(255),
    FOREIGN KEY (user_name) REFERENCES User_Credentials(user_name),
    FOREIGN KEY (email) REFERENCES User_Credentials(email)
);


CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    ProductCategory_ID INT REFERENCES Product_Category(ProductCategory_ID),
    Product_Name VARCHAR(255),
    price DECIMAL,
    HSN_Code VARCHAR(255) REFERENCES HSN_Code(hsncode),
    imageurl VARCHAR(255)
);




DROP TABLE order_product;
DROP TABLE address_info;
DROP TABLE product;
DROP TABLE user_credentials;
DROP TABLE product_category;
DROP TABLE orders;
DROP TABLE hsn_code;