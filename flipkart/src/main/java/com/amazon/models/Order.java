package com.amazon.models;

import java.time.LocalDate;
import java.util.List;

public class Order {
	private int orderId;
	private String userName;
	private LocalDate orderDate;
	private double orderTotal;
	private List<OrderProduct> orderProducts;

	// Constructors
	public Order() {
	}

	public Order(int orderId, String userName, LocalDate orderDate, double orderTotal,
			List<OrderProduct> orderProducts) {
		this.orderId = orderId;
		this.userName = userName;
		this.orderDate = orderDate;
		this.orderTotal = orderTotal;
		this.orderProducts = orderProducts;
	}

	// Getters and setters
	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public LocalDate getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}

	public double getOrderTotal() {
		return orderTotal;
	}

	public void setOrderTotal(double orderTotal) {
		this.orderTotal = orderTotal;
	}

	public List<OrderProduct> getOrderProducts() {
		return orderProducts;
	}

	public void setOrderProducts(List<OrderProduct> orderProducts) {
		this.orderProducts = orderProducts;
	}

	// toString method for debugging or logging
	@Override
	public String toString() {
		return "Order{" + "orderId=" + orderId + ", userName='" + userName + '\'' + ", orderDate=" + orderDate
				+ ", orderTotal=" + orderTotal + ", orderProducts=" + orderProducts + '}';
	}
}
