package com.budgetly.application.entities;

import java.text.DecimalFormat;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="customers")
public class Customer {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="customer_id")
	private int id;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="email")
	private String email;
	
	@Column(name="password")
	private String password;
	
	public Customer() {
	}
	
	public Customer(String firstName, String lastName, String email, String password) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
	}
	
	@Override
	public String toString() {
		return "Customer [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", password=" + password + "]";
	}

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getFirstName() {
		return firstName;
	}


	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}
	
	//one-to-many connection with Budgets table
	@OneToMany(mappedBy = "customer", fetch = FetchType.EAGER, orphanRemoval = false)
	@JsonIgnore
	private List<Budget> budgets;
	
	@JsonManagedReference
	public List<Budget> getBudgets() {
		return budgets;
	}
	
	public void setBudgets(List<Budget> budgets) {
		this.budgets = budgets;
	}
	
	//for UI only
	private static DecimalFormat df = new DecimalFormat("0.00");
	
	public String getTotalSpentSum() {
		double totalSpentSum = 0;	
		List<Budget> budgets = this.getBudgets();
		for (Budget budget : budgets) {
			totalSpentSum += budget.getSpentSum();
		} return df.format(totalSpentSum);
	}

	public String getTotalRemainingSum() {
		double totalRemainingSum = 0;	
		List<Budget> budgets = this.getBudgets();
		for (Budget budget : budgets) {
			totalRemainingSum += (budget.getAmount()-budget.getSpentSum());
		} return df.format(totalRemainingSum);
	}
}
