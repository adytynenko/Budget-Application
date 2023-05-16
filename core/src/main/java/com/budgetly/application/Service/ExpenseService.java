package com.budgetly.application.Service;

import java.util.List;

import com.budgetly.application.entities.Budget;
import com.budgetly.application.entities.Expense;

public interface ExpenseService {
	
	public List<Expense> getExpenses(int budgetId);
	
	public Expense getExpenseById(int expenseId);
	
	public Expense deleteExpense(int expenseId);
	
	public Expense saveExpense(Expense expense);
	
	public Double totalExpensesForTheMonth(int customerId);
	
	public Double totalExpensesForTheWeek(int customerId);
	
	public List<Expense> mostRecentTransactions(int customerId);
	
	public Double calculateMostRecentTransactions(int customerId);
	


}
