<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>Expenses</title>
<%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css" integrity="sha256-3sPp8BkKUE7QyPSl6VfBByBroQbKxKG7tsusY2mhbVY=" crossorigin="anonymous" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/style.css'/>"> --%>
<script src="webjars/bootstrap/5.2.3/js/bootstrap.min.js" defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>
<!-- <body style="font-family: 'Montserrat', sans-serif;background-size: cover;height: 100vh;overflow-x: hidden; background-attachment: scroll;">
 --><body>
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
		<form action = "addExpense" method="get">
			<input type="hidden" name="budgetId" value="${budgetId}" />
			<button class="btn" type="submit" style="background: #3496f9; color: #ffffff">Add a New Expense </button>
		</form>
   	</div>
</header>		
<body>
<form:hidden path="budgetId"/>
	<div class="container">
		<div class="row">
			<div class="col-2">
				<jsp:include page="vertical-navigation.jsp" />
			</div>
			<div class="col-9">
				<div class="row">
					<h1 class="text-center mt-3">${budget.name} Budget</h1>
					<h5 class="text-center">${budget.getFormattedDate(budget.startDate)} 2023 - ${budget.getFormattedDate(budget.endDate)} 2023</h5><br>		
				</div><br>
				<div class="row">
					<div class="col-7">
					<c:if test="${not empty expenses}">
					<c:forEach items="${expenses}" var="expense">		
						<div class="align-items-center justify-content-center">
			 				<div class="list-group list-group-checkable">
							    <label class="list-group-item rounded-3 py-3" for="listGroup">
							    <table>
									<tr>
										<td width=140><strong class="fw-semibold">${expense.name}</strong></td>
										<td width=100><span class="d-block small opacity-75">$${expense.formattedAmount}</span></td>
			                               <td width=140><span class="d-block small opacity-75">${expense.formattedDate}</span></td>
										<td>
										<div class="job-right">
											<form action = "${pageContext.request.contextPath}/expenses/budget-expenses/updateExpense">
												<input type="hidden" name="budgetId" value="${budget.id}" />
												<input type="hidden" name="expenseId" value="${expense.id}" />
												<button type="submit" class="btn d-block w-20 d-sm-inline-block btn-light"
													>Update</button>
											</form>
											</td>
											<td>
											<form action="deleteExpense" method="post">
											    <input type="hidden" name="expenseId" value="${expense.id}" />
											    <button type="submit" class="btn d-block w-20 d-sm-inline-block btn-light"
													>Delete</button>
											</form>
										</div>
										</td>
									</tr>
								</table>
							    </label>
							 </div><p></p>
						 </div>
					 </c:forEach>
							<div>
							 	<a href="${pageContext.request.contextPath}/expenses/budget-expenses/addExpense?budgetId=${budget.id}"
								class="btn btn-success rounded-pill px-3 margin-bottom: 5px;">Add Expense</a><p></p>
							<form action = "returnBackButton" method="get">
								<input type="hidden" name="customerId" value="${customerId}" />
								<button type = "submit" class="btn btn-dark rounded-pill px-3">Back to Budgets List</button>
							</form></div><br>
					</c:if>
					<c:if test="${empty budget.expenses}">
					   <div style="text-align: center;">
						    <br><h4>You don't have expenses yet</h4>
						</div><br>
						<div style="text-align: center;">
					 	<a href="${pageContext.request.contextPath}/expenses/budget-expenses/addExpense?budgetId=${budget.id}"
						class="btn btn-success rounded-pill px-3">Add Expense</a>
					</div>
					</c:if>
					</div>			
					<div class="col-5">
						<canvas id="myChart" style="width: 100%; height: 300px;"></canvas><br>	
						<div style="text-align: center;">
						  <p style="font-size: 22px; text-align: left;"><b>Summary:</b><br>
						    In total, <b>${budget.customer.firstName} ${budget.customer.lastName}</b> allocated <b>$${budget.getFormattedNumber(budget.amount)}</b> 
						    toward the ${budget.name} Budget, a total of <b>$${budget.getFormattedNumber(budget.spentSum)}</b> was spent. 
						    The customer is <b style="color: ${budget.spentSum > budget.amount ? 'red' : 'green'};">${budget.spentSum > budget.amount ? 'over' : 'under'}</b>
						     the budget amount by <b style="color: ${budget.spentSum > budget.amount ? 'red' : 'green'};">$${budget.getFormattedNumber(budget.remainingSum)}.</b>
						  </p>
						</div>	
					</div>
					
			<c:set var="xValues" value=""/>
			<c:set var="yValues" value=""/>
			<c:forEach items="${expenses}" var="expense">
				<c:set var="xValues" value="${xValues}${expense.amount}, "/>
				<c:set var="yValues" value="${yValues}'${expense.name}', "/>
		 	</c:forEach>
		 	
		 	<c:set var="xValues" value="${xValues}${budget.remainingSum}"/>
			<c:if test="${budget.remainingSum > 0}">   
			    <c:set var="yValues" value="${yValues}'Remaining Sum', "/>
			</c:if>
			<c:if test="${budget.remainingSum < 0}">
				<c:set var="yValues" value="${yValues}'Overspend', "/>
			</c:if>
		
			<script>
				var xValues = [${xValues}];
				var yValues = [${yValues}];
				var barColors = [
					"#ff9896",
		            "#66c2a5",
		        	"#00aba9",
		        	"#aec7e8",
		            "#2b5797",
		            "#e8c3b9",
		            "#b91d47",
		            "#d7a8b8",
		        	"#ffbb78",
		            "#ff9896",
		            "#c5b0d5",
		            "#dbdb8d",
		            "#8c6d31",
		            "#9edae5",
		            "#393b79",
		            "#637939",
		            "#a6cee3",
		            "#fdae6b",
		            "#7f7f7f",
		            "#ff7f0e",
		            "#9467bd",
		            "#8c564b",
		            "#e377c2",
		            "#7f7f7f",
		            "#bcbd22",
		            "#17becf",
				];
				
				if (${budget.remainingSum > 0}) {
					barColors[xValues.length - 1] = "#1e7145";
				}
				if (${budget.remainingSum < 0}) {
					barColors[xValues.length - 1] = "#ff0000";
				}
				
				new Chart("myChart", {
				  type: "doughnut",
				  data: {
				    labels: yValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: xValues
				    }]
				  },
				  /* options: {
				    title: {
				      display: true,
				      text: "Budget"
				    }
				  } */
				});
			</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

