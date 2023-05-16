package com.budgetly.application.springMVC.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.budgetly.application.Service.BudgetService;
import com.budgetly.application.Service.CustomerService;
import com.budgetly.application.Service.ExpenseService;
import com.budgetly.application.entities.Budget;
import com.budgetly.application.entities.Customer;


@Controller
public class BudgetController {
	
	@Autowired
	private CustomerService customerService;
	@Autowired
	private BudgetService budgetService;
	@Autowired
	private ExpenseService expenseService;
	
	// Route retrieves all of a users budgets passes to jsp
	@GetMapping(path = "/budgets/user-budgets/{customerId}")
	public String getUserBudgetsJsp(@PathVariable int customerId, ModelMap model) {
		
		Customer customer = customerService.getCustomer(customerId);
		// Get User Budgets
		List<Budget> budgets = budgetService.retrieveUserBudgets(customerId);
		
		// Add budgets to model for jsp interaction
		model.addAttribute("customer", customer);
		model.addAttribute("customerId", customer.getId());
		model.addAttribute("budgets", budgets);		
		model.addAttribute("numb", budgets.size());
		
		return "budgets";
	}
	
	// Sort all budgets by name
	@GetMapping(path = "/budgets/user-budgets/sortBudgetsByName/{customerId}")
	public String sortBudgetsByName(@PathVariable int customerId, @RequestParam("keyword") String keyword, ModelMap model){

		Customer customer = customerService.getCustomer(customerId);
		List<Budget> budgets = new ArrayList<>();
		
		if (keyword == null || keyword.trim().isEmpty()) {
			budgets = budgetService.retrieveAllByName(customerId);
		} else {
			budgets = budgetService.getBudgetsByKeywordSortByName(customerId, keyword);
		}
		
		//Collections.sort(budgets, Comparator.comparing(Budget::getName)); <-- easier way
		customer.setBudgets(budgets);
		
		// Add budgets to model for jsp interaction
		model.addAttribute("customer", customer);
		model.addAttribute("customerId", customer.getId());
		model.addAttribute("budgets", budgets);		
		model.addAttribute("numb", budgets.size());
		
		return "budgets";
	}
	
	
	// Sort all budgets by date ASC
	@GetMapping(path = "/budgets/user-budgets/sortBudgetsByDate/{customerId}")
	public String sortBudgetsByDate(@PathVariable int customerId, @RequestParam("keyword") String keyword, ModelMap model){

		Customer customer = customerService.getCustomer(customerId);
		List<Budget> budgets = new ArrayList<>();
		
		if (keyword == null || keyword.trim().isEmpty()) {
			budgets = budgetService.retrieveAllByDate(customerId);
		} else {
			budgets = budgetService.getBudgetsByKeywordSortByDate(customerId, keyword);
		}
		//Collections.sort(budgets, Comparator.comparing(Budget::getStartDate)); <-- easier way
		customer.setBudgets(budgets);
		
		// Add budgets to model for jsp interaction
		model.addAttribute("customer", customer);
		model.addAttribute("customerId", customer.getId());
		model.addAttribute("budgets", budgets);		
		model.addAttribute("numb", budgets.size());
		
		return "budgets";
	}
	
	@GetMapping(path = "/budgets/user-budgets/searchByKeyword/{customerId}")
	public String searchByKeyword(@PathVariable int customerId, @RequestParam("keyword") String keyword, ModelMap model){

		Customer customer = customerService.getCustomer(customerId);
		List<Budget> budgets = new ArrayList<>();
		
		if (keyword == null || keyword.trim().isEmpty()) {
			budgets = budgetService.retrieveUserBudgets(customerId);
		} else {
			budgets = budgetService.getBudgetsByKeyword(customerId, keyword);
		}
		
		customer.setBudgets(budgets);		
		model.addAttribute("customer", customer);
		model.addAttribute("customerId", customerId);
		model.addAttribute("budgets", budgets);		
		model.addAttribute("numb", budgets.size());
		model.addAttribute("keyword", keyword);
		
		return "budgets";
	}
		
		
	//Route retrieves all of a users budgets WITH EXPENSES passes to jsp
	@GetMapping(path = "/budgets/expenses/{customerId}")
	public String getAllUserExpensesJsp(@PathVariable int customerId, ModelMap model) {
		
		// Get User Budgets
		List<Budget> budgets = budgetService.retrieveUserBudgets(customerId);
		
		// Add budgets to model for jsp interaction
		model.addAttribute("budgets", budgets);	
			
		return "expenses-report";
	}
	
	//Add New Budget from BUDGETS VIEW PAGE
	@RequestMapping(path = "/budgets/create-budget/{customerId}")
	public String addBudget(Model model, @PathVariable("customerId") int customerId) {
		
		// redirect to budgets jsp
		return "create-budget";			
	}
		
	
	@RequestMapping("/budgets/create-budget/processBudget")
	public String processBudget(Model model, String name, String endDate, String startDate, double amount, 
			@RequestParam("customerId") int customerId, 
			RedirectAttributes redirectAttributes) throws ParseException {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");		
		Budget budget = new Budget();
	
		Customer customer = customerService.getCustomer(customerId);
		budget.setCustomer(customer);
		System.out.println(customer.getId());
		budget.setName(name);
		System.out.println(name);
		budget.setAmount(amount);
		System.out.println(amount);
		budget.setEndDate(dateFormat.parse(endDate));
		System.out.println(budget.getEndDate());
		budget.setStartDate(dateFormat.parse(startDate));
		System.out.println(budget.getStartDate());
		budgetService.saveBudget(budget);
		
		redirectAttributes.addAttribute("customerId", customerId);
		
		return "redirect:/budgets/user-budgets/{customerId}";
	}
	
	//UPDATE
	@RequestMapping(path = "/budgets/user-budgets/updateBudget/{customerId}")
	public String updateBudget(Model model, @PathVariable("customerId") int customerId, @RequestParam("budgetId") int budgetId) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Budget budget = budgetService.retrieveUserBudgetById(budgetId);
		String name = budget.getName();
		String endDate = dateFormat.format(budget.getEndDate());
		String startDate = dateFormat.format(budget.getStartDate());
		double amount = budget.getAmount();;
	
		model.addAttribute("budget", budget);
		model.addAttribute("budgetId", budgetId);
		model.addAttribute("name", name);
		model.addAttribute("endDate", endDate);
		model.addAttribute("startDate", startDate);
		model.addAttribute("amount", amount);
				
		// redirect to budgets jsp
		return "update-budget";			
		}
	
	@RequestMapping("/budgets/user-budgets/updateBudget/updateProcessBudget")
	public String updateProcessBudget(Model model, String name, String endDate, String startDate, double amount,
		@RequestParam("customerId") int customerId, @RequestParam("budgetId") int budgetId,
		RedirectAttributes redirectAttributes) throws ParseException {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");		
			
		Budget budget = budgetService.retrieveUserBudgetById(budgetId);
		Customer customer = customerService.getCustomer(customerId);
		budget.setCustomer(customer);
		
		budget.setName(name);
		System.out.println(name);
		budget.setAmount(amount);
		System.out.println(amount);
		budget.setEndDate(dateFormat.parse(endDate));
		System.out.println(budget.getEndDate());
		budget.setStartDate(dateFormat.parse(startDate));
		System.out.println(budget.getStartDate());
		budgetService.saveBudget(budget);
		
		redirectAttributes.addAttribute("customerId", customerId);
		
		return "redirect:/budgets/user-budgets/{customerId}";
	}
	
	
	//delete budget
	@PostMapping(path = "/budgets/user-budgets/deleteBudget")
	public String deleteBudget(@RequestParam("budgetId") int id, RedirectAttributes redirectAttributes) {
		int customerId = budgetService.retrieveUserBudgetById(id).getCustomer().getId();
		budgetService.deleteBudget(id);
		redirectAttributes.addAttribute("customerId", customerId);
		return "redirect:/budgets/user-budgets/{customerId}";
	}
	
	//delete expense from the page "expenses-report"
	@PostMapping(path = "/budgets/expenses/deleteExpense")
	public String deleteExpense(@RequestParam("expenseId") int id, RedirectAttributes redirectAttributes) {
		int customerId = expenseService.getExpenseById(id).getBudget().getCustomer().getId();
		expenseService.deleteExpense(id);
		redirectAttributes.addAttribute("customerId", customerId);
		return "redirect:/budgets/expenses/{customerId}";
	}
}
