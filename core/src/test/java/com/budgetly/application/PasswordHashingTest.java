package com.budgetly.application;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;

import com.budgetly.application.Service.CustomerService;
import com.budgetly.application.entities.Customer;

@RunWith(SpringRunner.class)
@SpringBootTest
public class PasswordHashingTest {

    @Autowired
    private CustomerService customerService;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Test
    public void testPasswordHashing() {
    	/* Test 1
    	 * customer1 is created, password is hashed & then compared to the current password to make sure it is not already in use
    	 * Falsely assert the new password doesn't match the previous password -> this passes as there is no password currently
    	 * Save the customer1 object with the hashed password to DB
    	 * Create a new variable of Customer class called 'retrievedCustomer' and assign the customer1 object to this variable 
    	 * Assert that the raw password 'password' matches retrievedCustomer's password in the DB -> this passes as the encoded 'password' matches 
    	 * the hashed password for this value in the DB and this object's ID */
    	
        // Create a new customer
        Customer customer1 = new Customer();
        customer1.setFirstName("customer1");
        customer1.setPassword("password");

        // Hash the password
        String hashedPassword = passwordEncoder.encode(customer1.getPassword());

        // Assert that the hashed password is not equal to the original password
        assertFalse(hashedPassword.equals(customer1.getPassword()));

        // Set the hashed password on the customer object
        customer1.setPassword(hashedPassword);

        // Save the customer using the customer service
        customerService.saveCustomer(customer1);

        // Retrieve the customer using the customer service
        Customer retrievedCustomer = customerService.getCustomer(customer1.getId());

        // Verify that the passwords match using the password encoder
        assertTrue(passwordEncoder.matches("password", retrievedCustomer.getPassword()));
   
        /* Test 2
         * customer2 is created but this time the password is not hashed, it will get stored as 'differentPassword' 
         * Falsely assert that customer2 passwordEncoder matches the retrievedCustomer2 object that is created
         * This is true because 'differentPassword' gets encoded with passwordEncoder in the matches() method 
         * so differentPassword does not match the hash value of this because the retrievedCustomer2 has 'differentPassword'
         * not a hashed password for this value */
        
        // Create a new customer object with a different password
        Customer customer2 = new Customer();
        customer2.setFirstName("customer2");
        customer2.setPassword("differentPassword");

        // Save the second customer using the customer service
        customerService.saveCustomer(customer2);

        // Retrieve the second customer using the customer service
        Customer retrievedCustomer2 = customerService.getCustomer(customer2.getId());

        // Verify that the passwords do not match using the password encoder
        assertFalse(passwordEncoder.matches(customer2.getPassword(), retrievedCustomer2.getPassword()));
        
    	/* Test 3
    	 * customer3 is created, password is hashed & then compared to the current password to make sure it is not already in use
    	 * Falsely assert the new password doesn't match the previous password -> this passes as there is no password currently
    	 * Save the customer3 object with the hashed password to DB
    	 * Create a new variable of Customer class called 'retrievedCustomer3' and assign the customer3 object to this variable 
    	 * Assert that the raw password 'abcdefghijklmnopqrstuvwxyz' matches retrievedCustomer's password in the DB -> this passes as the encoded 'abcdefghijklmnopqrstuvwxyz' matches 
    	 * the hashed password for this value in the DB and this object's ID */
        
        // New customer with a different password 
        Customer customer3 = new Customer();
        customer3.setFirstName("customer3");
        customer3.setPassword("abcdefghijklmnopqrstuvwxyz");
        
        // Hash password
        String hashedPassword3 = passwordEncoder.encode(customer3.getPassword());
        
        // Assert that the hashed pass is not equal to the original password
        assertFalse(hashedPassword3.equals(customer3.getPassword()));
        
        // Set hashed password to customer 3
        customer3.setPassword(hashedPassword3);
        
        // Save customer
        customerService.saveCustomer(customer3);
        
        Customer retrievedCustomer3 = customerService.getCustomer(customer3.getId());
        
        assertTrue(passwordEncoder.matches("abcdefghijklmnopqrstuvwxyz", retrievedCustomer3.getPassword()));
        
    }
}
