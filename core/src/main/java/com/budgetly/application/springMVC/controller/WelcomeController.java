package com.budgetly.application.springMVC.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.budgetly.application.Service.CustomerService;
import com.budgetly.application.entities.Customer;

@Controller
public class WelcomeController {
	
	@Autowired
	private CustomerService customerService;
	
	@GetMapping("/")
	public String login() {
		return "login";
	}
	
	@GetMapping("/login")
	public String welcome() {
		return "login";
	}
	
	@GetMapping("/signup")
	public String signup() {
		return "signup";
	}
	
	@GetMapping("/vertical-navigation")
	public String navigation(Model model) {
		List<Customer> customers = customerService.getCustomers();
		model.addAttribute("customers", customers);
		return "vertical-navigation";
	}
	
}
