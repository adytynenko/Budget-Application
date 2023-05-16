<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Dashboard - ${firstName }</title>
<script src="webjars/bootstrap/5.2.3/js/bootstrap.min.js" defer></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script src="js/util.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<style>
tbody td {
	border: none !important;
}

tr {
	border: none !important;
}
</style>
</head>
<body>
	<header class="d-flex justify-content-between align-items-center p-2"
		style="border-bottom: 3px solid #3496f9; max-width: 1500px; margin: 0 auto;">
		<!-- Logo -->
		<div class="d-flex align-items-center">
			<img src="http://localhost:8080/static/img/logoblue.png"
				alt="budget application logo" width="55px" height="55px" /> <span
				class="d-flex flex-column"
				style="color: #3496f9; font-weight: 600; font-size: 1.1rem">Budgetly
				<span style="font-weight: 400; font-size: 0.8rem; line-height: 1.1;">Budget
					Tracker</span>
			</span>
		</div>
	</header>
	<div class="container">
		<div class="row">
			<div class="col-md-2">
				<jsp:include page="vertical-navigation.jsp" />
			</div>
			<div class="col-md-9">
				<div class="row">
					<h1 class="text-center mt-3">Welcome Home, ${firstName}</h1>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="card h-100">
							<h5 class="card-header" style="text-align:center">This Month's Budgets</h5>
							<div class="card-body">
							<c:if test="${empty thisMonthsBudgets}">
								<div style="text-align: center;">
									<br>
									<h3>You don't have any budgets yet</h3>
									<br>
									<a href="${pageContext.request.contextPath}/budgets/create-budget/${customerId}"
									class="btn" type="submit" style="background: #3496f9; color: #ffffff">Add New Budget</a>
								</div>
							</c:if>
							<c:if test="${not empty thisMonthsBudgets}">
								<div id="carouselExampleControls1" class="carousel slide"
									data-ride="carousel">
									<div class="carousel-inner">
										<c:forEach items="${thisMonthsBudgets}" var="budget"
											varStatus="budgetStatus">
											<c:if test="${budgetStatus.index == 0}">
												<div class="carousel-item active">
												<a href="${pageContext.request.contextPath}/expenses/budget-expenses/${budget.id}">
													<div>
														<canvas id="myChart1_${budget.id}"
															style="width: 300px; height: 300px;"></canvas>
													</div></a>
												</div>
											</c:if>
											<c:if test="${budgetStatus.index != 0}">
												<div class="carousel-item">
												<a href="${pageContext.request.contextPath}/expenses/budget-expenses/${budget.id}">
													<div>
														<canvas id="myChart1_${budget.id}"
															style="width: 300px; height: 300px;"></canvas>
													</div></a>
												</div>
											</c:if>

											<c:set var="xValues" value="" />
											<c:set var="yValues" value="" />

											<c:forEach items="${budget.expenses}" var="expense">
												<c:set var="xValues" value="${xValues}${expense.amount}, " />
												<c:set var="yValues" value="${yValues}'${expense.name}', " />
											</c:forEach>

											<c:set var="xValues" value="${xValues}${budget.remainingSum}"/>
											<c:if test="${budget.remainingSum > 0}">   
											    <c:set var="yValues" value="${yValues}'Remaining Sum', "/>
											</c:if>
											<c:if test="${budget.remainingSum < 0}">
												<c:set var="yValues" value="${yValues}'Overspend', "/>
											</c:if>
										

											<script>
							var xValues_${budget.id} = [${xValues}];
					        var yValues_${budget.id} = [${yValues}];
					        var barColors_${budget.id} = [ 
					        	"#92A8D1",
					            "#BFD8D2",
					            "#E1D5E7",
					            "#E3DAC9",
					            "#C7D3C4",
					            "#E8D7C2",
					            "#A0A0A0",
					            "#D1C1B9",
					        	"#00aba9",
					        	"#aec7e8",
					            "#2b5797",
					            "#e8c3b9",
					            "#b91d47",
					            "#d7a8b8",
					            "#7f7f7f",
					            "#ff7f0e",
					            "#9467bd",
					            "#8c564b",
					            "#e377c2",
					            "#7f7f7f",
					            "#bcbd22",
					            "#17becf",
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
					            "#ff9896",
					            "#66c2a5",
								];
					        
					     	// Set the same color for budget.remainingSum
					     	if (${budget.remainingSum > 0}) {
					     		barColors_${budget.id}[xValues_${budget.id}.length - 1] = "#1e7145";
							}
					     	if (${budget.remainingSum < 0}) {
					     		barColors_${budget.id}[xValues_${budget.id}.length - 1] = "#ff0000";
							}
						
								new Chart("myChart1_${budget.id}", {
								  type: "doughnut",
								  data: {
								    labels: yValues_${budget.id},
								    datasets: [{
								      backgroundColor: barColors_${budget.id},
						              data: xValues_${budget.id}
								    }]
								  },
								  options: {
								    title: {
								      display: true,
								      text: "${budget.name}",
								    fontSize: 18
								    },
								    legend: {
								        display: false
								      }
								  }
								});
							</script>
										</c:forEach>
									</div>
									<a class="carousel-control-prev"
										href="#carouselExampleControls1" role="button"
										data-slide="prev"> <span
										class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a> <a class="carousel-control-next"
										href="#carouselExampleControls1" role="button"
										data-slide="next"> <span
										class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="sr-only">Next</span>
									</a>
								</div></c:if>
							</div>
							<div class="card-footer">
								
									This Month's Expenses:
									<fmt:setLocale value="en-US" />
									<fmt:formatNumber value="${thisMonthsExpenses }"
										type="currency" />
								
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<h5 class="card-header" style="text-align:center">This Week's Budgets</h5>
							<div class="card-body">
							<c:if test="${empty thisWeeksBudgets}">
								<div style="text-align: center;">
									<br>
									<h3>You don't have any budgets yet</h3>
									<br>
									<a href="${pageContext.request.contextPath}/budgets/create-budget/${customerId}"
									class="btn" type="submit" style="background: #3496f9; color: #ffffff">Add New Budget</a>
								</div>
							</c:if>
							<c:if test="${not empty thisWeeksBudgets}">
								<div id="carouselExampleControls2" class="carousel slide"
									data-ride="carousel">
									<div class="carousel-inner">
										<c:forEach items="${thisWeeksBudgets}" var="budget"
											varStatus="budgetStatus">
											<c:if test="${budgetStatus.index == 0}">
												<div class="carousel-item active">
												<a href="${pageContext.request.contextPath}/expenses/budget-expenses/${budget.id}">
													<div>
														<canvas id="myChart2_${budget.id}"
															style="width: 300px; height: 300px;"></canvas>
													</div></a>
												</div>
											</c:if>
											<c:if test="${budgetStatus.index != 0}">
												<div class="carousel-item">
												<a href="${pageContext.request.contextPath}/expenses/budget-expenses/${budget.id}">
													<div>
														<canvas id="myChart2_${budget.id}"
															style="width: 300px; height: 300px;"></canvas>
													</div></a>
												</div>
											</c:if>

											<c:set var="xValues" value="" />
											<c:set var="yValues" value="" />

											<c:forEach items="${budget.expenses}" var="expense">
												<c:set var="xValues" value="${xValues}${expense.amount}, " />
												<c:set var="yValues" value="${yValues}'${expense.name}', " />
											</c:forEach>

											<c:set var="xValues" value="${xValues}${budget.remainingSum}"/>
											<c:if test="${budget.remainingSum > 0}">   
											    <c:set var="yValues" value="${yValues}'Remaining Sum', "/>
											</c:if>
											<c:if test="${budget.remainingSum < 0}">
												<c:set var="yValues" value="${yValues}'Overspend', "/>
											</c:if>									
											<script>
											var xValues_${budget.id} = [${xValues}];
									        var yValues_${budget.id} = [${yValues}];
									        var barColors_${budget.id} = [ 
									        	"#92A8D1",
									            "#BFD8D2",
									            "#E1D5E7",
									            "#E3DAC9",
									            "#C7D3C4",
									            "#E8D7C2",
									            "#A0A0A0",
									            "#D1C1B9",
									        	"#00aba9",
									        	"#aec7e8",
									            "#2b5797",
									            "#e8c3b9",
									            "#b91d47",
									            "#d7a8b8",
									            "#7f7f7f",
									            "#ff7f0e",
									            "#9467bd",
									            "#8c564b",
									            "#e377c2",
									            "#7f7f7f",
									            "#bcbd22",
									            "#17becf",
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
									            "#ff9896",
									            "#66c2a5",
												];
									        
									     	// Set the same color for budget.remainingSum
									     	if (${budget.remainingSum > 0}) {
									     		barColors_${budget.id}[xValues_${budget.id}.length - 1] = "#1e7145";
											}
									     	if (${budget.remainingSum < 0}) {
									     		barColors_${budget.id}[xValues_${budget.id}.length - 1] = "#ff0000";
											}
										
												new Chart("myChart2_${budget.id}", {
												  type: "doughnut",
												  data: {
												    labels: yValues_${budget.id},
												    datasets: [{
												      backgroundColor: barColors_${budget.id},
										              data: xValues_${budget.id}
												    }]
												  },
												  options: {
												    title: {
												      display: true,
												      text: "${budget.name}",
												    fontSize: 18
												    },
												    legend: {
												        display: false
												      }
												  }
												});
										</script>
										</c:forEach>
									</div>
									<a class="carousel-control-prev"
										href="#carouselExampleControls2" role="button"
										data-slide="prev"> <span
										class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a> <a class="carousel-control-next"
										href="#carouselExampleControls2" role="button"
										data-slide="next"> <span
										class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="sr-only">Next</span>
									</a>
								</div></c:if>
							</div>
							<div class="card-footer">
								
									This Week's Expenses:
									<fmt:setLocale value="en-US" />
									<fmt:formatNumber value="${thisWeeksExpenses }" type="currency" />
								
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card h-100">
							<h5 class="card-header" style="text-align:center">Budgets Over Amount</h5>
							<div class="card-body">
								<c:if test="${empty budgetsOverAmount}">
									<div style="text-align: center;">
										<br>
										<h3>No budgets currently over amount</h3>
									</div>
								</c:if>
								<c:if test="${not empty budgetsOverAmount}">
								<div id="carouselExampleControls3" class="carousel slide"
									data-ride="carousel">
									<div class="carousel-inner">
										<c:forEach items="${budgetsOverAmount}" var="budget"
											varStatus="budgetStatus">
											<c:if test="${budgetStatus.index == 0}">
												<div class="carousel-item active">
												<a href="${pageContext.request.contextPath}/expenses/budget-expenses/${budget.id}">
													<div>
														<canvas id="myChart3_${budget.id}"
															style="width: 300px; height: 300px;"></canvas>
													</div></a>
												</div>
											</c:if>
											<c:if test="${budgetStatus.index != 0}">
												<div class="carousel-item">
												<a href="${pageContext.request.contextPath}/expenses/budget-expenses/${budget.id}">
													<div>
														<canvas id="myChart3_${budget.id}"
															style="width: 300px; height: 300px;"></canvas>
													</div></a>
												</div>
											</c:if>

											<c:set var="xValues" value="" />
											<c:set var="yValues" value="" />

											<c:forEach items="${budget.expenses}" var="expense">
												<c:set var="xValues" value="${xValues}${expense.amount}, " />
												<c:set var="yValues" value="${yValues}'${expense.name}', " />
											</c:forEach>

											<c:set var="xValues"
												value="${xValues}${budget.remainingSum}" />
											<c:set var="yValues" value="${yValues}'Overspend', " />
										

											<script>
											var xValues_${budget.id} = [${xValues}];
									        var yValues_${budget.id} = [${yValues}];
									        var barColors_${budget.id} = [ 
									        	"#92A8D1",
									            "#BFD8D2",
									            "#E1D5E7",
									            "#E3DAC9",
									            "#C7D3C4",
									            "#E8D7C2",
									            "#A0A0A0",
									            "#D1C1B9",
									        	"#00aba9",
									        	"#aec7e8",
									            "#2b5797",
									            "#e8c3b9",
									            "#b91d47",
									            "#d7a8b8",
									            "#7f7f7f",
									            "#ff7f0e",
									            "#9467bd",
									            "#8c564b",
									            "#e377c2",
									            "#7f7f7f",
									            "#bcbd22",
									            "#17becf",
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
									            "#ff9896",
									            "#66c2a5",
												];
									        
										     	// Set the color for overspend
										     	if (${budget.remainingSum < 0}) {
										     		barColors_${budget.id}[xValues_${budget.id}.length - 1] = "#ff0000";
												}
										
												new Chart("myChart3_${budget.id}", {
												  type: "doughnut",
												  data: {
												    labels: yValues_${budget.id},
												    datasets: [{
												      backgroundColor: barColors_${budget.id},
										              data: xValues_${budget.id}
												    }]
												  },
												  options: {
												    title: {
												      display: true,
												      text: "${budget.name}",
												    fontSize: 18
												    },
												    legend: {
												        display: false
												      }
												  }
												});
											</script>
										</c:forEach>
									</div>
									<a class="carousel-control-prev"
										href="#carouselExampleControls3" role="button"
										data-slide="prev"> <span
										class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a> <a class="carousel-control-next"
										href="#carouselExampleControls3" role="button"
										data-slide="next"> <span
										class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="sr-only">Next</span>
									</a>
								</div></c:if>

							</div>
							
							<div class="card-footer">
							Exceeded Amount: 
								<fmt:setLocale value="en-US" />
								<fmt:formatNumber value="${totalOverspentSum}"
										type="currency" />
							</div>
							
						</div>
					</div>
				</div>

				<br>
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<h5 class="card-header">
								Most Recent Expenses :
								<fmt:setLocale value="en-US" />
								<fmt:formatNumber value="${calculatedExpenses }" type="currency" />
							</h5>
							<div class="card-body table-responsive table-borderless">
								<table class="table table-borderless">
									<c:if test="${empty mostRecentExpenses}">
										<div style="text-align: center;">
											<br>
											<h2>You don't have any expenses yet</h2>
										</div>
									</c:if>
									<c:forEach var="expense" items="${mostRecentExpenses}" varStatus="status">
										<c:if test="${status.index % 3 == 0}">
											<tr class="no-border">
										</c:if>
										<td><a href="${pageContext.request.contextPath}/expenses/budget-expenses/${expense.budget.id}"><b>${expense.getFormattedDate() }
										</b>:<br>
											${expense.name} $${expense.getFormattedAmount() }</a>
											<style>
											a {
											  color: inherit;
											  text-decoration: none;
											}
											a:hover {
											  color: inherit; /* use the same color as the surrounding text */
											  text-decoration: none; /* remove underline */
											}
											</style>
										</td>
										<c:if test="${status.index % 3 == 2 or status.last}">
										</c:if>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</div>
				<br> <br>
			</div>
		</div>
	</div>
</body>
</html>