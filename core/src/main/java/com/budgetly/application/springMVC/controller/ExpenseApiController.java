package com.budgetly.application.springMVC.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.budgetly.application.Service.ExpenseService;
import com.budgetly.application.entities.Expense;


@RestController
public class ExpenseApiController {
	
	@Autowired
	private ExpenseService service;
	
	
	// Get Budget Expenses
	@GetMapping(path = "/api/expenses/budget-expenses/{budgetId}")
	public List<Expense> getBudgetExpenses(@PathVariable int budgetId) {
		return service.getExpenses(budgetId);
	}
	
	// Get Budget Expense
	@GetMapping(path = "/api/expenses/budget-expense/{budgetId}")
	public Expense getBudgetExpense(@PathVariable int budgetId) {
		return service.getExpenseById(budgetId);
	}
	
	// Add expense
	@PostMapping(path = "/api/expenses/add-expense")
	public Expense addExpense(@RequestBody Expense expense) {
		return service.saveExpense(expense);
	}
	
	// Delete Expense
	@DeleteMapping(path = "/api/expenses/delete-expense/{expId}")
	public Expense deleteBudgetExpense(@PathVariable int expId) {
		return service.deleteExpense(expId);
	}
	
}
