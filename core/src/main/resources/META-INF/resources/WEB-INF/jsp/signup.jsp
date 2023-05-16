<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html xmlns:th="https://www.thymeleaf.org" lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description"
	content="Sign up. Budgetly is a robust budgeting application allowing you create, update, and 
      delete budgets and expenses." />
      <link rel="preconnect" href="https://fonts.googleapis.com" />
	  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
      <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"
    />
    <title>Sign up - Budget Application</title>
  </head>
  <body style="font-family: 'Montserrat', sans-serif;background-image: url('http://localhost:8080/static/img/BackgroundHeader.jpg');background-size: cover;height: 100vh;overflow-x: hidden; background-attachment: scroll;">

  <!-- Header -->
    <header class="d-flex justify-content-between align-items-center p-2" style="border-bottom: 3px solid #3496f9;max-width: 1500px; margin: 0 auto;">
    	<!-- Logo -->
    	<div class="d-flex align-items-center">
    		<img src="http://localhost:8080/static/img/logoblue.png" 
    		alt="budget application logo" width="55px" height="55px" />
    		<span class="d-flex flex-column" style="color: #3496f9;font-weight: 600;font-size: 1.1rem">Budgetly 
    		<span style="font-weight: 400;font-size: 0.8rem;line-height: 1.1;">Budget Tracker</span></span>
    	</div>
    	<!-- Navigation Btn -->
    	<div>
    		<a href="http://localhost:8080/login">
    			<button class="btn" type="button" style="background: #3496f9; color: #ffffff">Login</button>
    		</a>
    	</div>
    </header>


    <main style="height: 100vh;">
    	<!-- Main Page Content -->
    	<div style="max-width: 1200px; margin: 0 auto;">
    		<!-- Hero Section -->
    		<section class="w-100 grid gap-2 my-5 px-4">
    			<!-- Row -->
    			<div class="p-2 row align-items-center">
    				<!-- col-1 -->
    			<div class="py-3 col-md-6">
    				<h1 class="mb-3" style="font-weight: 500; font-size: 1.8rem; max-width: 500px;">We make the complex budget process 
    				<span style="font-weight: 600; color: #3496f9;">SIMPLE & ENGAGING</span></h1>

    				<p class="mb-5" style="font-weight: 400; font-size: 0.85rem; max-width: 480px;line-height: 1.5">An intutitive and flexible budgeting, forecasting and reporting solution with a simple interface allowing 
    				users to quickly get started creating, managing, and visualizing budgets.</p>

    				<div>
    					<ul style="margin: 0; padding-left: 12px;font-size: 0.9rem">
    						<li class="mb-2">Strategic Budgeting, Forecasting & Planning</li>
    						<li class="mb-2">Complete Report and Analysis</li>
    						<li class="mb-2">Budget Data Visualization</li>
    					</ul>
    				</div>
    			</div>

    			<!-- col-2 -->
    			<div class="col-md-6 m-auto d-flex justify-content-end">
    				<form method="post" action="http://localhost:8080/customer/processNewCustomer" class="justify-self-end" style="background-color: #153c64;padding: 1.5em 2em 3em;border-radius: 20px;width: 80%;" >
    				<p class="text-center" style="color: #ffffff; font-weight: 600;">See Budgetly in action</p>
    				<!-- Form Error -->
    				<c:if test="${error}">
								<p class="text-danger text-center m-0 p-0">Email address already exists or is invalid.</p>
							</c:if>
			        <div class="mb-3 grid">
			          <div class="row">
			          	<div class="col">
			          	<label for="firstname" class="form-label" style="color: #ffffff"
			            >First name</label>
				          <input
				            type="text"
				            class="form-control"
				            id="firstName"
				            aria-describedby="firstName"
				            name="firstName"
				            value="${firstName}"
				            required
				          />
			          	</div>

				          <div class="col">
				          	<label for="lastname" class="form-label" style="color: #ffffff"
				            >Last name</label>
					          <input
					            type="text"
					            class="form-control"
					            id="lastName"
					            aria-describedby="lastName"
					            name="lastName"
					            value="${lastName}"
					            required
					          />
				          </div>
			          </div>

			        </div>

			         <div class="mb-2">
			          <label for="userEmail" class="form-label" style="color: #ffffff">Email</label>
			          <input
			            type="email"
			            class="form-control"
			            id="userEmail"
			            name="email"
			            value="${email}"
			            required
			          />
			        </div>

			        <div class="mb-2">
			          <label for="InputPassword1" class="form-label" style="color: #ffffff">Password</label>
			          <input
			            type="password"
			            class="form-control"
			            id="InputPassword1"
			            name="password"
			            required
			          />
			        </div>
			        <button class="btn py-2 mt-4" type="submit" style="width: 100%; background: #3496f9; color: #ffffff">Submit</button>
			      </form>
    			</div>
    			</div>
    		</section>
    	   </div>

    		<!-- organizations -->
    		<section class="mt-3 pb-4" style="background: #ffffff;height: 200px">
    			<h2 class="text-center pt-4" style="color: #153c64;font-size: 1.2rem;font-weight: 600">Trusted by hundreds of organizations just like yours.</h2>
    			<!-- image -->
    			<div class="d-flex justify-content-center pt-4">
    				<img src="http://localhost:8080/static/img/gma.png" alt="organization icon" width="90%" height="65px" />
    			</div>
    		</section>

    		<!-- Benefits -->
    		<section style="background: #ffffff;height: 520px">
    			<h2 class="text-center pt-4" style="color: #3496f9;font-size: 1.2rem;font-weight: 600">Benefits</h2>
    			<h3 class="text-center pt-2" style="font-size: 1.7rem;font-weight: 400; max-width: 500px; margin: 0 auto;">Budgetly application handles complex budget demands</h3>

    			<div class="grid" style="max-width: 1200px; margin: 3.5em auto 0;">
    				<!-- Row -->
    				<div class="row gap-5">
    					<!-- Col -->
    					<div class="col d-flex flex-column justify-content-center align-items-center p-3">
    						<img src="http://localhost:8080/static/img/clock-solid.svg" alt="benfit svg" width="45px" height="45px" />
    						<h4 class="mt-4" style="font-size: 1.1rem">Boost Efficiency</h4>
    						<p class="mt-4 text-center" style="font-size: 0.9rem; max-width: 250px">
    							Automate work flows and free up you time to perform other essential activities
    						</p>
    					</div>

    					<!-- Col -->
    					<div class="col d-flex flex-column justify-content-center align-items-center p-3">
    						<img src="http://localhost:8080/static/img/calendar-days-solid.svg" alt="benfit svg" width="45px" height="45px" />
    						<h4 class="mt-4" style="font-size: 1.1rem">Stay-Up-to-date</h4>
    						<p class="mt-4 text-center" style="font-size: 0.9rem; max-width: 250px">
    							Get the accurate, real-time visibility you need to stick to and beat your budgets

    						</p>
    					</div>

    					<!-- Col -->
    					<div class="col d-flex flex-column justify-content-center align-items-center p-3">
    						<img src="http://localhost:8080/static/img/shield-solid.svg" alt="benfit svg" width="45px" height="45px" />
    						<h4 class="mt-4" style="font-size: 1.1rem">Be Compliant & Secure</h4>
    						<p class="mt-4 text-center" style="font-size: 0.9rem; max-width: 250px">
    							Ensure peace of mind knowing your data is secure and free of critical errors.
    						</p>
    					</div>
    				</div>
    			</div>
    		</section>


    		<!-- Info section -->
    		<section style="background: #3496f9;height: 450px">
    			<div style="max-width: 1200px; margin: 0 auto;">
    				<!-- row -->
    				<div class="row align-items-center">
    					<!-- col -->
    					<div class="col">
    					<img src="http://localhost:8080/static/img/flat_illustration.png" alt="piggy bank illustration" width="450px" height="450px" />
    					</div>
    					<!-- col -->
    					<div class="col text-white">
    						<h3 class="mb-4" style="font-size: 1.4rem; font-weight: 600">Features</h3>
    						<h4 class="mb-5" style="font-size: 1.7rem; max-width: 550px">Your single source of truth with a multitude of features.</h4>
    						<p style="max-width: 550px; ">Go beyond traditional budgeting using Budgetly's sophisticated features that exceed your complex needs.</p>
    						<p style="max-width: 550px;">Budgetly offers a simple way to create and manage your personal budgets. The data 
    						visualization takes it over the top. Budgetly is secure and safe to use</p>
    					</div>
    				</div>
    			</div>
    		</section>

    		<!-- Info section -->
    		<footer class="text-white" style="background: #3496f9;height: 290px;padding-top: 5.5em;">
    			<div style="max-width: 1200px; margin: 0 auto;">
    				<!-- row -->
    				<div class="row align-items-start">
    					<!-- col -->
				    	<div class="col-md-3 d-flex align-items-center">
				    		<img src="http://localhost:8080/static/img/logowhite.png" 
				    		alt="budget application logo" width="55px" height="55px" />
				    		<span class="d-flex flex-column" style="font-weight: 600;font-size: 1.1rem">Budgetly 
				    		<span style="font-weight: 400;font-size: 0.8rem;line-height: 1.1;">Budget Tracker</span></span>
				    	</div>
				    	<!-- col -->
    					<div class="col-md-3 text-white">
    						<h3 class="mb-4" style="font-size: 0.9rem; font-weight: 600">Contact</h3>
    						<a href="#" style="font-size: 0.85rem; text-decoration:none; color: inherit">hello@budgetly.tech</a>
    					</div>
    						<!-- col -->
    					<div class="col-md-3 text-white">
    						<h3 class="mb-4" style="font-size: 0.9rem; font-weight: 600">Legal</h3>
    						<a href="#" style="font-size: 0.85rem; color: inherit">Terms and Service</a>
    					</div>
    						<!-- col -->
    					<div class="col-md-3 text-white">
    						<h3 class="mb-4" style="font-size: 0.9rem; font-weight: 600">About</h3>
    						<p href="#" style="font-size: 0.85rem; text-decoration:none; color: inherit">We created budgetly because there was 
    						no good secure place to create, manage and track user budgets. Budgetly offers a secure place to handle 
    						all of your complex budget needs.</p>
    					</div>
    					<p style="font-size: 0.8rem;">2023 &copy; Budgetly. All Rights Reserved.</p>
    				</div>
    			</div>
    		</footer>
    	</main>
  </body>