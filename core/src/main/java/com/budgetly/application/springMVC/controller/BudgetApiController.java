package com.budgetly.application.springMVC.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.budgetly.application.Service.BudgetService;
import com.budgetly.application.entities.Budget;

@RestController
public class BudgetApiController {
	
	@Autowired
	private BudgetService service;
	
	// Route retrieves all of a users budgets
	@GetMapping(path = "/api/budgets/user-budgets/{customerId}")
	public List<Budget> getUserBudgets(@PathVariable int customerId) {
		return service.retrieveUserBudgets(customerId);
	}
	
	// Route retrieves a users budget by id
	@GetMapping(path = "/api/budgets/user-budget/{budgetId}")
	public Budget getUserBudget(@PathVariable int budgetId) {
	
		Budget savedBudget = service.retrieveUserBudgetById(budgetId);
		
		if (savedBudget == null) {
			throw new NotFoundException("Error saving budget...");
		}
		
		return savedBudget;
		
	}
	
	// Save Budget
	@PostMapping(path = "/api/budgets/create-budget")
	public Budget saveUserBudget(@RequestBody Budget budget) {
		return service.saveBudget(budget);
	}
	
	// Delete budget by id
	@DeleteMapping(path = "/api/budgets/delete-budget/{budgetId}")
	public Budget deleteUserBudget(@PathVariable int budgetId) {
		
		Budget savedBudget = service.deleteBudget(budgetId);
		
		if (savedBudget == null) {
			throw new NotFoundException("Budget not found...");
		}
		
		return savedBudget;
	}
}
