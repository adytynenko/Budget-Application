package com.budgetly.application.Service;

import java.util.List;

import com.budgetly.application.entities.Customer;

public interface CustomerService {
	
	public List<Customer> getCustomers();
	
	public Customer getCustomer(int id);
	
	public Customer getByEmail(String email, String password);
	
	public Customer getByEmail(String email);
	
	public void saveCustomer(Customer customer);

}
