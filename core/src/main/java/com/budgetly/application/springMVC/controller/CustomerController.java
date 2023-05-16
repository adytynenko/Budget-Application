package com.budgetly.application.springMVC.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.budgetly.application.Service.CustomerService;
import com.budgetly.application.entities.Customer;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class CustomerController {

	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public boolean emailExists(String email) {
		Customer existingCustomer = customerService.getByEmail(email);
		return existingCustomer != null;
	}

	@RequestMapping("/customer/register")
	public String signup(Model model) {
		Customer customer = new Customer();
		model.addAttribute("customer", customer);
		return "signup";
	}
	
	@PostMapping("/customer/processNewCustomer")
	public String processNewCustomer(@ModelAttribute("customer") Customer customer, Model model) {
	    String email = customer.getEmail();
	    if (emailExists(email)) {
	    	model.addAttribute("error", true);
	        return "signup";
	    } 
	    else {
	        String password = customer.getPassword();
	        String hashedPassword = passwordEncoder.encode(password);
	        customer.setPassword(hashedPassword);
	        customerService.saveCustomer(customer);
	        return "redirect:/customer/" + customer.getId();
	    }
	}

	@GetMapping("customer/updateCustomer/{customerId}")
	public String updateCustomer(Model model, @PathVariable("customerId") int customerId) {
		Customer customer = customerService.getCustomer(customerId);
		model.addAttribute("customer", customer);
		return "add-customer";
	}
	

	@PostMapping("/customer/authenticate-login")
	public String authenticateByEmail(Model model, HttpServletRequest request, HttpServletResponse response,
	        @RequestParam(value = "email", required = false) String email,
	        @RequestParam(value = "password", required = false) String password) {
	    Customer existingCustomer = customerService.getByEmail(email, password);
	    if (existingCustomer == null || !passwordEncoder.matches(password, existingCustomer.getPassword())) {
	        model.addAttribute("authError", true); // Set authError attribute to true
	        return "login";
	    } 
	    else {
	        HttpSession session = request.getSession(true);
	        session.setAttribute("customerId", existingCustomer.getId());
	        model.addAttribute("firstName", existingCustomer.getFirstName());
	        return "redirect:/customer/" + existingCustomer.getId();
	    }
	}

	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response) {
	    session.invalidate();
	    Cookie customerIdCookie = new Cookie("customerId", "");
	    customerIdCookie.setMaxAge(0);
	    response.addCookie(customerIdCookie);
	    return "redirect:/login";
	}




}
