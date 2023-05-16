<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description"
	content="Budgetly is a robust budgeting application allowing you create, update, and 
      delete budgets and expenses." />
<title>Add a New Budget</title>
</head>
<body style="font-family: 'Montserrat', sans-serif;">
<body>
<header class="d-flex justify-content-between align-items-center p-2" style="border-bottom: 3px solid #3496f9;max-width: 1500px; margin: 0 auto;">
   	<!-- Logo -->
   	<div class="d-flex align-items-center">
   		<img src="http://localhost:8080/static/img/logoblue.png" 
   		alt="budget application logo" width="55px" height="55px" />
   		<span class="d-flex flex-column" style="color: #3496f9;font-weight: 600;font-size: 1.1rem">Budgetly 
   		<span style="font-weight: 400;font-size: 0.8rem;line-height: 1.1;">Budget Tracker</span></span>
   	</div>
</header>
<body>
	<div class="container">
		<div class="row">
			<div class="col-2">
				<jsp:include page="vertical-navigation.jsp" />
			</div>
			<div class="col-2"></div>
			<div class="col-7"><br>
				<div class="row">
					<div class="col-md-7 col-lg-8">
					<h4 class="mb-3">Budget Information</h4>
					<form method="post" action="updateProcessBudget" class="needs-validation">
						<div class="row g-3">			          
						  <div class="col-12">
						    <label for="name" class="form-label">Name</label>
						    <div>
						      <input
					          	type="text"
					            class="form-control"
					            id="name"
					            aria-describedby="budgetName"
					            name="name"
					            value="${name}"
					            required
					          	/>
						    </div>
						  </div>
						  <div class="col-12">
			              <label for="amount" class="form-label">Amount</label>
			              <div>
			              	<input
				          	type="number"
				            class="form-control"
				            id="amount"
				            placeholder="1234.00"
				            aria-describedby="budgetAmount"
				            name="amount"
				            value="${amount}"
				            required>
			              </div>
			            </div>
			            
			            <div class="col-12">
			              <label for="expenseDate" class="form-label">Start Date</label>
			              <div>
			              	 <input
					            type="date" 
					            class="form-control" 
					            id="startDate" 
					            aria-describedby="budgetStartDate"
					            value="${startDate}"
					            name="startDate"
					            required="required" 
					            path="startDate"
					          />
			              </div>
			            </div>
			           <div class="col-12">
			              <label for="expenseDate" class="form-label">End Date</label>
			              <div>
			              	 <input
					          	type="date"
					            class="form-control"
					            id="endDate"
					            aria-describedby="budgetEndDate"
					            name="endDate"
					            value="${endDate}"
					            required="required" 
					            path="endDate"
					          />
			              </div>
			            </div>
					<hr class="my-3">
						<input type="hidden" name="customerId" value="${customerId}" />
						<input type="hidden" name="budgetId" value="${budget.id}" />
						<button type = "submit" class="btn btn-success rounded-pill px-3" >Submit</button></form>
						<a href="${pageContext.request.contextPath}/budgets/user-budgets/${customerId}"
						class="btn btn-dark rounded-pill px-3">Cancel</a>
						<%-- <form action = "returnBackButton" method="get">
							<input type="hidden" name="customerId" value="${customerId}" />
							<button type = "submit" class="btn btn-dark rounded-pill px-3">Cancel</button>
						</form> --%><br>
						</div>
    				</div>
				</div>
			</div>
		</div>
	
</body>
</html>