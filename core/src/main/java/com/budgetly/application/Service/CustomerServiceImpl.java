 package com.budgetly.application.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.budgetly.application.dao.CustomerDAO;
import com.budgetly.application.entities.Customer;
import com.budgetly.application.springMVC.controller.NotFoundException;

@Service
public class CustomerServiceImpl implements CustomerService {
	
	@Autowired
	private CustomerDAO customerDAO;
	
	@Override
	@Transactional
	public List<Customer> getCustomers() {
		return customerDAO.getCustomers();
	}


	@Transactional
	public Customer getCustomer(int id) {
		
		Customer customer = customerDAO.getCustomer(id);
		if (customer == null) {
			throw new NotFoundException("customer Id not found. Id: " + id);
		}
		
		return customerDAO.getCustomer(id);
	}

	@Override
	@Transactional
	public void saveCustomer(Customer customer) {
		// TODO Auto-generated method stub
		customerDAO.saveCustomer(customer);
	}


	@Override
	@Transactional
	public Customer getByEmail(String email, String password) {
		Customer result = customerDAO.getByEmail(email, password);
		return result;
	}
	
	public Customer getByEmail(String email) {
		return customerDAO.getByEmail(email);
	}

}
