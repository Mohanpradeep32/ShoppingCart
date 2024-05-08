package models;

public class User {
	private int id;
	private String username;
	private String password;

	// Constructor
	public User() {
		// Default constructor
	}

	// Getters and setters for id
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	// Getters and setters for username
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	// Getters and setters for password
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	// Optional: Override toString() method for debugging or logging
	@Override
	public String toString() {
		return "User{" + "id=" + id + ", username='" + username + '\'' + ", password='" + password + '\'' + '}';
	}
}
