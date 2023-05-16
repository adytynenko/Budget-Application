package com.budgetly.application.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.budgetly.application.entities.Budget;
import com.budgetly.application.entities.Customer;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

@Repository
public class CustomerDAOimpl implements CustomerDAO {
	
	@PersistenceContext
    private EntityManager entityManager;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Override
	public List<Customer> getCustomers() {
		TypedQuery<Customer> query = entityManager.createQuery("SELECT * FROM Customer ", Customer.class);		
		return query.getResultList();
	}

	@Override
	public void saveCustomer(Customer customer) {
		entityManager.persist(customer);
	}
	
	@Override
    public Customer getCustomer(int id) {
        return entityManager.find(Customer.class, id);
    }

	@Override
	public Customer getByEmail(String email, String password) {
	    String select = "SELECT c FROM Customer c WHERE c.email = :email";
	    TypedQuery<Customer> query = entityManager.createQuery(select, Customer.class);
	    query.setParameter("email", email);
	    List<Customer> customers = query.getResultList();
	    if (customers.isEmpty()) {
	        return null;
	    }
	    return customers.get(0);
	}
	
	@Override
	public Customer getByEmail(String email) {
	    String select = "SELECT c FROM Customer c WHERE c.email = :email";
	    TypedQuery<Customer> query = entityManager.createQuery(select, Customer.class);
	    query.setParameter("email", email);
	    List<Customer> customers = query.getResultList();
	    if (customers.isEmpty()) {
	        return null;
	    }
	    return customers.get(0);
	}
	
}
