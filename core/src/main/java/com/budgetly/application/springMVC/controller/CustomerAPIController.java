package com.budgetly.application.springMVC.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.budgetly.application.Service.CustomerService;
import com.budgetly.application.entities.Customer;

@RestController
public class CustomerAPIController {
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	// API REQUESTS

	// Retrieve a Customer
	@GetMapping("/api/customer/{customerId}")
	@ResponseBody
	public Customer getCustomerById(@PathVariable("customerId") int customerId) {
		return customerService.getCustomer(customerId);
	}

	// Create a Customer
	@PostMapping("/api/customer")
	@ResponseBody
	public Customer addCustomer(@RequestBody Customer customer) {
		String password = customer.getPassword();
		String hashedPassword = passwordEncoder.encode(password);
		customer.setPassword(hashedPassword);
		customerService.saveCustomer(customer);
		return customer;
	}
	
	// Edit an Existing Customer
	@PutMapping("/api/customer/{customerId}")
	@ResponseBody
	public Customer updateCustomer(@PathVariable int customerId, @RequestBody Customer updatedCustomer) {
	    Customer existingCustomer = customerService.getCustomer(customerId);

	    if (existingCustomer == null) {
	        throw new Error ("Customer not found with id " + customerId);
	    }

	    existingCustomer.setFirstName(updatedCustomer.getFirstName());
	    existingCustomer.setLastName(updatedCustomer.getLastName());
	    existingCustomer.setEmail(updatedCustomer.getEmail());
	    existingCustomer.setPassword(updatedCustomer.getPassword());

	    customerService.saveCustomer(existingCustomer);
	    return existingCustomer;
	}
}
