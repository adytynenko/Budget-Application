package com.budgetly.application.springMVC.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.budgetly.application.Service.BudgetService;
import com.budgetly.application.Service.CustomerService;
import com.budgetly.application.Service.ExpenseService;
import com.budgetly.application.entities.Budget;
import com.budgetly.application.entities.Customer;

@Controller
public class DashboardController {
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private BudgetService budgetService;
	
	@Autowired
	private ExpenseService expenseService;
	
	@RequestMapping("/customer/{customerId}")
	public String dashboard(Model model, @PathVariable("customerId") int customerId) {
	    Customer customer = customerService.getCustomer(customerId);
	    model.addAttribute("customer", customer);
	    model.addAttribute("firstName", customer.getFirstName());
	    
	    List<Budget> budgetsOverAmount = budgetService.queryBudgetsOverAmount(customerId);
	    customer.setBudgets(budgetsOverAmount);
	    String totalOverspentSum = customer.getTotalRemainingSum();
	    model.addAttribute("budgetsOverAmount", budgetsOverAmount);
	    model.addAttribute("totalOverspentSum", totalOverspentSum);
	    
	    model.addAttribute("thisMonthsBudgets", budgetService.budgetsActiveThisMonth(customerId));
	    model.addAttribute("thisWeeksBudgets", budgetService.budgetsActiveThisWeek(customerId));    
	    model.addAttribute("thisMonthsExpenses", expenseService.totalExpensesForTheMonth(customerId));
	    model.addAttribute("thisWeeksExpenses", expenseService.totalExpensesForTheWeek(customerId));
	    model.addAttribute("mostRecentExpenses", expenseService.mostRecentTransactions(customerId));
	    model.addAttribute("calculatedExpenses", expenseService.calculateMostRecentTransactions(customerId));
	    return "customer-dashboard";
	}

}
