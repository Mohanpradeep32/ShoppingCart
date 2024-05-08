package com.amazon.models;

public class OrderProduct {
	private int orderId;
	private int productId;
	private int quantity;
	private double price;

	public OrderProduct() {
	}

	public OrderProduct(int orderId, int productId, int quantity, double price) {
		this.orderId = orderId;
		this.productId = productId;
		this.quantity = quantity;
		this.price = price;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "OrderProduct{" + "orderId=" + orderId + ", productId=" + productId + ", quantity=" + quantity
				+ ", price=" + price + '}';
	}
}
