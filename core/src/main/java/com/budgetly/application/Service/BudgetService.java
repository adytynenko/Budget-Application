package com.budgetly.application.Service;

import java.util.List;

import com.budgetly.application.entities.Budget;

public interface BudgetService {
	
	public List<Budget> retrieveUserBudgets(int customerId);
	
	public List<Budget> retrieveAllByName(int customerId);
	
	public List<Budget> retrieveAllByDate(int customerId);
	
	public Budget retrieveUserBudgetById(int budgetId);
	
	public Budget deleteBudget(int budgetId);
	
	public Budget saveBudget(Budget budget);
	
	public List<Budget> queryBudgetsOverAmount(int customerId);
	
	public List<Budget> budgetsActiveThisMonth(int customerId);
	
	public List<Budget> budgetsActiveThisWeek(int customerId);

	public List<Budget> getBudgetsByKeyword(int customerId, String keyword);
	
	public List<Budget> getBudgetsByKeywordSortByName(int customerId, String keyword);
	
	public List<Budget> getBudgetsByKeywordSortByDate(int customerId, String keyword);

}
