<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
</head>
<body>
	<nav id="nav" class="nav flex-column">
		<a class="nav-link" href="${pageContext.request.contextPath}/customer/${customerId}">Home</a> 
		<a class="nav-link" href="${pageContext.request.contextPath}/budgets/user-budgets/${customerId}">View Budgets</a> 
		<a class="nav-link" href="${pageContext.request.contextPath}/budgets/create-budget/${customerId}">Create Budget</a> 
		<a class="nav-link" href="${pageContext.request.contextPath}/budgets/expenses/${customerId}">Expenses Report</a>
		<a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a> 
	</nav>
</body>
</html>