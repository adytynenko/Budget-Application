package com.budgetly.application.entities;


import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="budgets")
public class Budget {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "budget_id")
	private int id;
	
	@Column(name= "budget_amount")
	private double amount;
	
	@Column(name= "budget_name")
	private String name;
	
	@Column(name= "start_date")
	private Date startDate;
	
	@Column(name = "end_date")
	private Date endDate;
	
	@ManyToOne
	@JoinColumn(name = "customer_id")
	private Customer customer;
	
	
	// Default constructor
	public Budget() {
		
	}
	
	public Budget(int id, double amount, String name, Date startDate, Date endDate, Customer customer,
			List<Expense> expenses) {
		this.id = id;
		this.amount = amount;
		this.name = name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.customer = customer;
		this.expenses = expenses;
	}

	//one-to-many connection with Expenses table
	@OneToMany(mappedBy = "budget", fetch = FetchType.EAGER, orphanRemoval = true)
	@JsonIgnore
	private List<Expense> expenses;
	
	@JsonManagedReference
	public List<Expense> getExpenses() {
		return expenses;
	}

	public void setExpenses(List<Expense> expenses) {
		this.expenses = expenses;
	}
	
	@JsonBackReference
	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Override
	public String toString() {
		return "Budget [id=" + id + ", amount=" + amount + ", name=" + name + ", startDate=" + startDate + ", endDate="
				+ endDate + "]";
	}
	
	//for UI only
	public char getLetter() {
		char letter = this.name.charAt(0);
		return letter;
	}
	
	public String getFormattedDate(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM");
	    String formattedDate = dateFormat.format(date);

			return formattedDate;
		}
	
	public double getSpentSum() {
		double spentSum = 0;	
		List<Expense> expenses = this.getExpenses();
		for (Expense expense : expenses) {
			spentSum += expense.getAmount();
		} return spentSum;
	}
	
	public double getRemainingSum() {
		double remainingSum = this.getAmount() - this.getSpentSum();
		return remainingSum;
	}

	private static DecimalFormat df = new DecimalFormat("0.00");
		public String getFormattedNumber(double number) {
		String formattedNumber = df.format(number);;
		return formattedNumber;
	}
	
	public long getNumberOfDays() {
		long diffInMillies = Math.abs(endDate.getTime() - startDate.getTime());
	    long NumberOfDays = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
		return NumberOfDays;
	}
	
}
