package com.amazon.models;

public class Address {
    private int addressId;
    private String userName;
    private String customerName;
    private String mobile;
    private String email;
    private String location;
    private String address;

    // Constructors
    public Address() {
    }

    public Address(int addressId, String userName, String customerName, String mobile, String email,
                   String location, String address) {
        this.addressId = addressId;
        this.userName = userName;
        this.customerName = customerName;
        this.mobile = mobile;
        this.email = email;
        this.location = location;
        this.address = address;
    }

    // Getters and Setters
    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // toString method for debugging or logging
    @Override
    public String toString() {
        return "Address{" +
                "addressId=" + addressId +
                ", userName='" + userName + '\'' +
                ", customerName='" + customerName + '\'' +
                ", mobile='" + mobile + '\'' +
                ", email='" + email + '\'' +
                ", location='" + location + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
