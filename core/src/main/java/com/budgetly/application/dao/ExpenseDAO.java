package com.budgetly.application.dao;

import java.util.List;

import com.budgetly.application.entities.Budget;
import com.budgetly.application.entities.Expense;


public interface ExpenseDAO {
	
	public List<Expense> retrieveAll(int budgetId);
	
	public Expense retrieveById(int expenseId);
	
	public Expense deleteById(int expenseId);
	
	public Expense saveExpense(Expense expense);
	
	public Double totalExpensesForTheMonth(int customerId);
	
	public Double totalExpensesForTheWeek(int customerId);
	
	public List<Expense> mostRecentTransactions(int customerId);
	
	public Double calculateMostRecentTransactions(int cutomerId);
	
}
