package com.amazon.models;

public class Product {
	private int productId;
	private int productCategoryId;
	private String productName;
	private double price;
	private String hsnCode;
	private String imageUrl;

	public Product(int productId, int productCategoryId, String productName, double price, String hsnCode,
			String imageUrl) {
		this.productId = productId;
		this.productCategoryId = productCategoryId;
		this.productName = productName;
		this.price = price;
		this.hsnCode = hsnCode;
		this.imageUrl = imageUrl;
	}

	// Getters and setters for each field

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getProductCategoryId() {
		return productCategoryId;
	}

	public void setProductCategoryId(int productCategoryId) {
		this.productCategoryId = productCategoryId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getHsnCode() {
		return hsnCode;
	}

	public void setHsnCode(String hsnCode) {
		this.hsnCode = hsnCode;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}
