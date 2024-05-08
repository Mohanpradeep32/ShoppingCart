package com.amazon.utility;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashGenerator {
	public String generateHash(String password) {
		try {
			// Create a MessageDigest instance for SHA-256
			MessageDigest digest = MessageDigest.getInstance("SHA-256");

			// Compute the hash value for the input string
			byte[] hashBytes = digest.digest(password.getBytes());

			// Convert the byte array to a hexadecimal string representation
			StringBuilder hexString = new StringBuilder();
			for (byte hashByte : hashBytes) {
				String hex = Integer.toHexString(0xff & hashByte);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}

			String hashedString = hexString.toString();

			return hashedString;
		} catch (NoSuchAlgorithmException e) {
			System.err.println("SHA-256 algorithm not found.");
		}
		return null;
	}

}
