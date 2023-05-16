<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

<title>Budgets Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<c:url value='/style.css'/>">
</head>
<!-- <body style="font-family: 'Montserrat', sans-serif;background-image: url('http://localhost:8080/static/img/BackgroundHeader.jpg');background-size: cover;height: 100vh;overflow-x: hidden; background-attachment: scroll;">		
 -->
<body>
<header class="d-flex justify-content-between align-items-center p-2" style="border-bottom: 3px solid #3496f9;max-width: 1500px; margin: 0 auto;">
   	<div class="d-flex align-items-center">
   		<img src="http://localhost:8080/static/img/logoblue.png" 
   		alt="budget application logo" width="55px" height="55px" />
   		<span class="d-flex flex-column" style="color: #3496f9;font-weight: 600;font-size: 1.1rem">Budgetly 
   		<span style="font-weight: 400;font-size: 0.8rem;line-height: 1.1;">Budget Tracker</span></span>
   	</div>
   	<div>	
		<a href="${pageContext.request.contextPath}/budgets/create-budget/${customerId}"
		class="btn" type="submit" style="background: #3496f9; color: #ffffff">Add New Budget</a>
		<%--<form action = "addBudget" method="get">							        
	 			<input type="hidden" name="customerId" value="${customerId}" />
				<button class="btn" type="submit" style="background: #3496f9; color: #ffffff">Add New Budget</button> 
			</form> --%>
   	</div>
</header>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css" integrity="sha256-3sPp8BkKUE7QyPSl6VfBByBroQbKxKG7tsusY2mhbVY=" crossorigin="anonymous" />
<div class="container">
	<div class="row">
		<div class="col-2">
			<jsp:include page="vertical-navigation.jsp" />
		</div>
		<div class="col-9">
			<div class="row">
				<div class="col">
					<h2 class="text-center mt-3">Your Budgets</h2>
					<h6 class="text-center">Total Amount Spent : $ ${customer.getTotalSpentSum()}</h6>
					<h6 class="text-center">Total Amount Remaining : $ ${customer.getTotalRemainingSum()}</h6>					
				</div>
			</div>
			<div class="filter-result">
			<div class="row">
				<div class="col-lg-11 mx-auto">
					<div class="career-search mb-60">					
						<form action = "${pageContext.request.contextPath}/budgets/user-budgets/searchByKeyword/${customerId}" method="get" class="career-form mb-60">				
							<div class="row">
								<div class="col-md-6 col-lg-3 my-3">
									<div class="input-group position-relative">
										<input type="text" class="form-control" placeholder="Enter Your Keyword" name="keyword" value="${keyword}" >
									</div>
								</div>
						
								<div class="col-md-6 col-lg-3 my-3">
									<button type = "submit" class="btn btn-lg btn-block btn-light btn-custom">Search</button>
								</div>						
								<div class="col-md-6 col-lg-3 my-3">
							    	<%-- <a href="${pageContext.request.contextPath}/budgets/user-budgets/sortBudgetsByName/${customerId}" --%>
							    	<a href="${pageContext.request.contextPath}/budgets/user-budgets/sortBudgetsByName/${customerId}?keyword=${keyword}"
							    	class="btn btn-lg btn-block btn-light btn-custom">Sort by Name</a>	        
							    </div>
								<div class="col-md-6 col-lg-3 my-3">
									<a href="${pageContext.request.contextPath}/budgets/user-budgets/sortBudgetsByDate/${customerId}?keyword=${keyword}"
							    	class="btn btn-lg btn-block btn-light btn-custom">Sort by Date</a>
								</div>
							</div>			
						</form>
						<p class="ff-montserrat">Total Budgets : ${numb}</p>
							<p class="mb-20"></p>
							<c:if test="${not empty budgets}">
								<c:forEach items="${budgets}" var="budget">
								
								<style>
									   a {
									    text-decoration: none;
									    color: black;
									  }
									  a:hover {
									  color: black; 
									  text-decoration: none;
									</style>
													 
									<a href="${pageContext.request.contextPath}/expenses/budget-expenses/${budget.id}">
									
									<div class="job-box d-md-flex align-items-center justify-content-between mb-3">
										<div class="job-left my-4 d-md-flex align-items-center flex-wrap">
											<div class="img-holder mr-md-4 mb-md-0 mb-4 mx-auto mx-md-0 d-md-none d-lg-flex">
											${budget.letter}
											</div>
											<div class="job-content">
												<h5 class="text text-md-left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${budget.name}</h5>
												<ul class="d-md-flex flex-wrap text-capitalize ff-open-sans">
													<li class="mr-md-4">&nbsp;
														<i class="zmdi zmdi-money mr-1"></i>${budget.getFormattedNumber(budget.spentSum)} spent
													</li>
													<li class="mr-md-4"><!-- &nbsp; -->
														<i class="zmdi zmdi-money mr-1"></i>${budget.getFormattedNumber(budget.remainingSum)} remaining
													</li>
													<li class="mr-md-4">
														<i class="zmdi zmdi-time mr-1"></i>
													${budget.getFormattedDate(budget.startDate)}-${budget.getFormattedDate(budget.endDate)} (${budget.getNumberOfDays()} days)											
													</li>
												</ul>
											</div>
										</div>
										<div class="button-container">
										    <div class="job-right my-1 flex-shrink-0 my-2">
										        <a href="${pageContext.request.contextPath}/expenses/budget-expenses/addExpense?budgetId=${budget.id}"
										        class="btn d-block w-100 d-sm-inline-block btn-light">Add Expense</a>
										    </div>
										   <div class="job-right my-1 flex-shrink-0 my-2">
										        <form action = "${pageContext.request.contextPath}/budgets/user-budgets/updateBudget/${customerId}">
											        <input type="hidden" name="budgetId" value="${budget.id}" />
													<button type="submit" class="btn d-block w-100 d-sm-inline-block btn-light">Update</button>
												</form>
										    </div>
										    <div class="job-right my-1 flex-shrink-0 my-2">
										        <form action = "deleteBudget" method = "post">
												<input type="hidden" name="budgetId" value="${budget.id}" />
												<input type="submit" class="btn d-block w-100 d-sm-inline-block btn-light" value="Delete" />
												</form>
										    </div>
										</div>
									</div></a>					
								</c:forEach>
							</c:if>
							<c:if test="${empty budgets and empty keyword}">
							   <div style="text-align: center;">
								    <h1>You don't have any budgets yet</h1><br>
								    <div class="row">
										<div class="col-lg-9 mx-auto">
	 										<a href="${pageContext.request.contextPath}/budgets/create-budget/${customerId}" class="special-button">Add New Budget</a>
											<style>
											  a.special-button {
											    display: block;
											    width: 100%;
											    margin: 0 auto;
											    text-align: center;
											    background-color: #007bff;
											    color: #fff;
											    border-radius: 5px;
											    padding: 10px;
											    text-decoration: none;
											  }
											  
											  a.special-button:hover {
											    background-color: #0056b3;
											    color: #fff;
											  }
											</style>
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${empty budgets and not empty keyword}">
								<div style="text-align: center;">
							  		<h2>No budgets found for the specified keyword: "${keyword}".</h2>
							  	</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div><br><br>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"></script>
</body>
</html>