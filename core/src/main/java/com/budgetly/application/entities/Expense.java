package com.budgetly.application.entities;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "expenses")
public class Expense {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "expense_id")
	private int id;
	
	@Column(name = "expense_amount")
	private double amount;
	
	@Column(name = "expense_name")
	private String name;
	
	@Column(name = "expense_date")
	private Date expenseDate;
	
	@ManyToOne(cascade = {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinColumn(name = "budget_id")
	private Budget budget;
	
	// Default Constructor
	public Expense() {
		
	}
	
	public Expense(int id, double amount, String name, Date expenseDate, Budget budget) {
		super();
		this.id = id;
		this.amount = amount;
		this.name = name;
		this.expenseDate = expenseDate;
		this.budget = budget;
	}
	
	@JsonBackReference
	public Budget getBudget() {
		return budget;
	}

	public void setBudget(Budget budget) {
		this.budget = budget;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Date getExpenseDate() {
		return expenseDate;
	}
	
	public void setExpenseDate(Date expenseDate) {
		this.expenseDate = expenseDate;
	}

	@Override
	public String toString() {
		return "Expense [id=" + id + ", amount=" + amount + ", name=" + name + ", expenseDate=" + expenseDate
				+ ", budget=" + budget + "]";
	}
	
	//for UI only
	public String getFormattedAmount() {
		DecimalFormat df = new DecimalFormat("0.00");
		String formattedAmount = df.format(this.amount);;
		return formattedAmount;
	}
	
	public String getFormattedDate() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
	    String formattedDate = dateFormat.format(this.expenseDate);
		return formattedDate;
	}
	
}

