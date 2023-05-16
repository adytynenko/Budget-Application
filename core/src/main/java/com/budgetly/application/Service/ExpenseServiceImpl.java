 package com.budgetly.application.Service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.budgetly.application.dao.ExpenseDAO;
import com.budgetly.application.entities.Budget;
import com.budgetly.application.entities.Expense;
import com.budgetly.application.springMVC.controller.NotFoundException;


@Service
public class ExpenseServiceImpl implements ExpenseService {
	
	@Autowired
	private ExpenseDAO expenseDAO;

	// Get expenses
	@Transactional
	public List<Expense> getExpenses(int budgetId) {
		
		List<Expense> expenses = expenseDAO.retrieveAll(budgetId);
		
		if (expenses == null) {
            return Collections.emptyList();
        }
		
		return expenses;
	}

	
	// Get single expense
	@Transactional
	public Expense getExpenseById(int expenseId) {
		Expense expense = expenseDAO.retrieveById(expenseId);
		
		if (expense == null) {
			throw new NotFoundException("Error no expense found.");
		}
		
		return expense;
	}
	
	
	// Save budget expense
	@Transactional
	public Expense saveExpense(Expense expense) {
		Expense savedExpense = expenseDAO.saveExpense(expense);
		
		if (savedExpense == null) {
			throw new Error("Empty Expense not added please add fields.");
		}
		
		return savedExpense;
	}
	
	
	// Delete budget expense
	@Transactional
	public Expense deleteExpense(int expenseId) {
		return expenseDAO.deleteById(expenseId);
	}

	@Transactional
	@Override
	public Double totalExpensesForTheMonth(int customerId) {
		// TODO Auto-generated method stub
		Double expenses = expenseDAO.totalExpensesForTheMonth(customerId);
		if (expenses == null) {
			return 0.00;
		}
		return expenseDAO.totalExpensesForTheMonth(customerId);
	}

	@Transactional
	@Override
	public Double totalExpensesForTheWeek(int customerId) {
		// TODO Auto-generated method stub
		Double expenses = expenseDAO.totalExpensesForTheWeek(customerId);
		if (expenses == null) {
			return 0.00;
		}
		return expenseDAO.totalExpensesForTheWeek(customerId);
	}

	@Transactional
	@Override
	public List<Expense> mostRecentTransactions(int customerId) {
		// TODO Auto-generated method stub
		List<Expense> expenses = expenseDAO.mostRecentTransactions(customerId);
		if(expenses == null) {
			return Collections.emptyList();
		}
		return expenseDAO.mostRecentTransactions(customerId);
	}

	@Transactional
	@Override
	public Double calculateMostRecentTransactions(int customerId) {
		// TODO Auto-generated method stub
		Double expenses = expenseDAO.calculateMostRecentTransactions(customerId);
		if (expenses == null) {
			return 0.00;
		}
		return expenseDAO.calculateMostRecentTransactions(customerId);
	}

}
